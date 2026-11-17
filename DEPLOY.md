# Setup and deploy

## New laptop

```sh
git clone https://github.com/userproject02/clinical_edge.git
cd clinical_edge
bash tool/setup.sh          # add --avd to also create an Android emulator
```

The script installs Flutter 3.50.0 (pinned, same as CI), lefthook and CocoaPods if they are missing. It checks Xcode, the Android SDK (API 37) and JDK 17, gets packages, generates code and l10n, installs git hooks, and runs analyze and tests. It is safe to re-run. You still need these manually:

- **Xcode** from the App Store (macOS, for iOS).
- **Android Studio** with its command-line tools (for Android).

Then run `flutter run -d <device>`.

## Deploy to Google Cloud

ClinicalEdge is an iOS and Android app with no web build, so "deploy" means building the app in the cloud and handing it to testers:

```
GitHub ──► Cloud Build (cloudbuild.yaml) ──► Cloud Storage bucket ──► (optional) Firebase App Distribution
             analyze · tests · APK + AAB       builds/<sha>/, latest/        email to tester groups
```

### One-off build

```sh
gcloud auth login
bash tool/deploy_gcp.sh --project <gcp-project-id>
#   --bucket <name>           default: <project>-clinicaledge-builds
#   --region me-central1      bucket location (default: me-central1, Doha)
#   --firebase-app <app-id>   also send the APK to App Distribution testers
#   --groups testers          tester group(s) for App Distribution
```

The script enables Cloud Build and Storage, creates the bucket, grants Cloud Build write access, and submits `cloudbuild.yaml`. The newest APK is at `gs://<bucket>/latest/clinicaledge-debug.apk`.

### Build on every push to main

1. In Cloud Build → Repositories, connect `userproject02/clinical_edge`.
2. Run `bash tool/deploy_gcp.sh --project <id> --setup-trigger`.

### Notes

- **Signing:** v1 has no release signing. The APK is a debug build for testers, and the AAB is unsigned. For the Play Store, add an upload keystore (stored in Secret Manager) and a signing config.
- **iOS:** Cloud Build has no macOS, so build iOS locally (`flutter build ipa`) or on a macOS CI runner, and ship it through TestFlight.
- **Backend:** there is nothing to deploy. v1 runs on mock local data. A production backend (Firebase/Firestore in a `me-central` region, Cloud Functions for the audit chain) is listed in README → *What to build next*.
