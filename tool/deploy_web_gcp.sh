#!/usr/bin/env bash
# Build the Flutter web demo and publish it on Cloud Run with a public URL
# (nginx serving build/web). See DEPLOY.md → Web demo.
#
#   bash tool/deploy_web_gcp.sh --project <gcp-project-id>
#        [--region europe-west1] [--service clinicaledge-web] [--skip-build]
#
# Needs: Flutter, gcloud CLI logged in, billing enabled on the project.
set -euo pipefail
cd "$(dirname "$0")/.."
PROJECT=""
REGION="europe-west1"
SERVICE="clinicaledge-web"
BUILD=1
while [ $# -gt 0 ]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2 ;;
    --region) REGION="$2"; shift 2 ;;
    --service) SERVICE="$2"; shift 2 ;;
    --skip-build) BUILD=0; shift ;;
    *) echo "Unknown option: $1"; exit 2 ;;
  esac
done
[ -n "$PROJECT" ] || { echo "Usage: $0 --project <gcp-project-id> [...]"; exit 2; }
command -v gcloud >/dev/null || { echo "Install the gcloud CLI first."; exit 1; }

if [ "$BUILD" = 1 ]; then
  echo "== flutter build web --release"
  flutter build web --release
fi
[ -f build/web/index.html ] || { echo "build/web is missing; run without --skip-build"; exit 1; }

STAGE="build/web_deploy"
rm -rf "$STAGE"
mkdir -p "$STAGE"
cp -R build/web "$STAGE/web"
cp tool/web/Dockerfile tool/web/nginx.conf "$STAGE/"

echo "== Enabling Cloud Run, Cloud Build and Artifact Registry on $PROJECT"
gcloud services enable run.googleapis.com cloudbuild.googleapis.com \
  artifactregistry.googleapis.com --project "$PROJECT" >/dev/null

# New projects build with the Compute Engine default service account, which
# needs the Cloud Run builder role for source deploys (idempotent).
NUMBER="$(gcloud projects describe "$PROJECT" --format='value(projectNumber)')"
gcloud projects add-iam-policy-binding "$PROJECT" \
  --member="serviceAccount:${NUMBER}-compute@developer.gserviceaccount.com" \
  --role="roles/run.builder" --condition=None >/dev/null

echo "== Deploying $SERVICE to Cloud Run ($REGION), public"
gcloud run deploy "$SERVICE" \
  --source "$STAGE" \
  --project "$PROJECT" \
  --region "$REGION" \
  --allow-unauthenticated \
  --port 8080 \
  --memory 256Mi \
  --min-instances 0 \
  --max-instances 3 \
  --quiet

URL="$(gcloud run services describe "$SERVICE" --project "$PROJECT" \
  --region "$REGION" --format='value(status.url)')"
echo "== Live: $URL"
