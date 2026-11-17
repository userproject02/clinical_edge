#!/usr/bin/env bash
# Build and publish the Android app on Google Cloud (Cloud Build → Cloud
# Storage, optional Firebase App Distribution). See DEPLOY.md.
#
#   bash tool/deploy_gcp.sh --project <gcp-project-id> [--bucket <name>]
#        [--region me-central1] [--firebase-app <id>] [--groups testers]
#        [--setup-trigger]
#
# Needs: gcloud CLI, logged in (`gcloud auth login`), billing enabled.
set -euo pipefail
cd "$(dirname "$0")/.."

PROJECT=""
BUCKET=""
REGION="me-central1"   # Doha; closest GCP region to the UAE
FIREBASE_APP=""
GROUPS="testers"
TRIGGER=0
while [ $# -gt 0 ]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2 ;;
    --bucket) BUCKET="$2"; shift 2 ;;
    --region) REGION="$2"; shift 2 ;;
    --firebase-app) FIREBASE_APP="$2"; shift 2 ;;
    --groups) GROUPS="$2"; shift 2 ;;
    --setup-trigger) TRIGGER=1; shift ;;
    *) echo "Unknown option: $1"; exit 2 ;;
  esac
done
[ -n "$PROJECT" ] || { echo "Usage: $0 --project <gcp-project-id> [...]"; exit 2; }
BUCKET="${BUCKET:-$PROJECT-clinicaledge-builds}"
command -v gcloud >/dev/null || { echo "Install the gcloud CLI: https://cloud.google.com/sdk/docs/install"; exit 1; }

echo "== Project $PROJECT · region $REGION · bucket gs://$BUCKET"
gcloud config set project "$PROJECT" >/dev/null
gcloud services enable cloudbuild.googleapis.com storage.googleapis.com >/dev/null

if ! gcloud storage buckets describe "gs://$BUCKET" >/dev/null 2>&1; then
  gcloud storage buckets create "gs://$BUCKET" --location="$REGION" \
    --uniform-bucket-level-access
  echo "Created gs://$BUCKET"
fi

# Let Cloud Build write to the bucket.
NUMBER="$(gcloud projects describe "$PROJECT" --format='value(projectNumber)')"
gcloud storage buckets add-iam-policy-binding "gs://$BUCKET" \
  --member="serviceAccount:$NUMBER@cloudbuild.gserviceaccount.com" \
  --role=roles/storage.objectAdmin >/dev/null

SUBS="_BUCKET=$BUCKET,_FIREBASE_APP_ID=$FIREBASE_APP,_TESTER_GROUPS=$GROUPS"

if [ "$TRIGGER" = 1 ]; then
  # Build on every push to main (connect the GitHub repo in Cloud Build
  # → Repositories first).
  gcloud builds triggers create github \
    --name=clinicaledge-main --repo-owner=userproject02 \
    --repo-name=clinical_edge --branch-pattern='^main$' \
    --build-config=cloudbuild.yaml --substitutions="$SUBS" \
    --region="$REGION" || echo "Trigger not created (connect the repo first)."
fi

SHA="$(git rev-parse --short HEAD 2>/dev/null || echo manual)"
gcloud builds submit --config=cloudbuild.yaml \
  --substitutions="$SUBS,_SHA=$SHA" .

echo
echo "APK: gs://$BUCKET/latest/clinicaledge-debug.apk"
echo "Share a download link (valid 7 days, needs a service-account key or"
echo "impersonation): gcloud storage sign-url gs://$BUCKET/latest/clinicaledge-debug.apk --duration=7d"
