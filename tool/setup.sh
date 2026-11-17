#!/usr/bin/env bash
# One-command setup of ClinicalEdge on a new laptop (macOS or Linux).
#
#   git clone https://github.com/userproject02/clinical_edge.git
#   cd clinical_edge && bash tool/setup.sh
#
# Options:
#   --skip-tests   do not run analyze + tests at the end
#   --avd          also create an Android emulator "ce_pixel" (API 36)
#
# Installs (if missing): Flutter 3.50.0 (pinned, same as CI), lefthook,
# CocoaPods (macOS). Checks Xcode, Android SDK and JDK 17 and tells you what
# is missing. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")/.."

FLUTTER_VERSION="3.50.0"
FLUTTER_HOME="${FLUTTER_HOME:-$HOME/development/flutter}"
RUN_TESTS=1
MAKE_AVD=0
for a in "$@"; do
  case "$a" in
    --skip-tests) RUN_TESTS=0 ;;
    --avd) MAKE_AVD=1 ;;
    *) echo "Unknown option: $a"; exit 2 ;;
  esac
done

OS="$(uname -s)"
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }
step() { printf '\n\033[1m== %s\033[0m\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

step "System tools"
if [ "$OS" = "Darwin" ]; then
  if ! have brew; then
    warn "Homebrew not found. Install it from https://brew.sh, then re-run."
    exit 1
  fi
  ok "Homebrew"
  have git || brew install git
  have lefthook || brew install lefthook
  have pod || brew install cocoapods
  ok "git, lefthook, CocoaPods"
else
  have git || { warn "Install git (e.g. sudo apt install git)"; exit 1; }
  if ! have lefthook; then
    warn "lefthook not found: see https://lefthook.dev (optional, git hooks)"
  fi
fi

step "Flutter $FLUTTER_VERSION"
if have flutter && flutter --version 2>/dev/null | grep -q "Flutter $FLUTTER_VERSION "; then
  ok "flutter $FLUTTER_VERSION already on PATH ($(command -v flutter))"
else
  if [ ! -d "$FLUTTER_HOME/.git" ]; then
    mkdir -p "$(dirname "$FLUTTER_HOME")"
    git clone --depth 1 --branch "$FLUTTER_VERSION" \
      https://github.com/flutter/flutter.git "$FLUTTER_HOME"
  else
    git -C "$FLUTTER_HOME" fetch --depth 1 origin "refs/tags/$FLUTTER_VERSION:refs/tags/$FLUTTER_VERSION"
    git -C "$FLUTTER_HOME" checkout "$FLUTTER_VERSION"
  fi
  export PATH="$FLUTTER_HOME/bin:$PATH"
  ok "flutter installed at $FLUTTER_HOME"
  warn "Add to your shell profile: export PATH=\"$FLUTTER_HOME/bin:\$PATH\""
fi
flutter config --no-analytics >/dev/null 2>&1 || true
flutter --version | head -1

step "Platform toolchains"
if [ "$OS" = "Darwin" ]; then
  if xcodebuild -version >/dev/null 2>&1; then
    ok "$(xcodebuild -version | head -1)"
  else
    warn "Xcode not found: install it from the App Store, then run:"
    warn "  sudo xcode-select -s /Applications/Xcode.app && sudo xcodebuild -runFirstLaunch"
  fi
fi
ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
[ -d "$ANDROID_HOME" ] || ANDROID_HOME="$HOME/Android/Sdk"
if [ -d "$ANDROID_HOME" ]; then
  export ANDROID_HOME
  ok "Android SDK at $ANDROID_HOME"
  SDKM="$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"
  if [ -x "$SDKM" ]; then
    # compileSdk 37 is required by flutter_local_notifications.
    yes | "$SDKM" "platforms;android-37.0" "platform-tools" >/dev/null || true
    ok "Android platform 37 + platform-tools"
    if [ "$MAKE_AVD" = 1 ]; then
      ABI="$([ "$(uname -m)" = "arm64" ] && echo arm64-v8a || echo x86_64)"
      IMG="system-images;android-36;google_apis;$ABI"
      yes | "$SDKM" "$IMG" >/dev/null
      echo no | "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" \
        create avd -n ce_pixel -k "$IMG" -d pixel_7 --force >/dev/null
      ok "Emulator ce_pixel created (start: flutter emulators --launch ce_pixel)"
    fi
  else
    warn "Android cmdline-tools missing: Android Studio → SDK Manager → SDK Tools → Command-line Tools"
  fi
else
  warn "Android SDK not found: install Android Studio (https://developer.android.com/studio)"
fi
if java -version 2>&1 | grep -qE 'version "(17|21)'; then
  ok "JDK $(java -version 2>&1 | head -1 | sed -E 's/.*"([0-9]+).*/\1/')"
else
  warn "JDK 17 recommended (Android Studio bundles one; or: brew install openjdk@17)"
fi
flutter doctor || true

step "Project"
flutter pub get
dart run build_runner build -d
flutter gen-l10n
if have lefthook && [ -d .git ]; then lefthook install; ok "git hooks installed"; fi
if [ "$OS" = "Darwin" ] && [ -d ios ]; then (cd ios && pod install --silent) || warn "pod install failed (run it after Xcode is set up)"; fi
ok "dependencies, generated code and l10n ready"

if [ "$RUN_TESTS" = 1 ]; then
  step "Checks"
  flutter analyze
  if [ "$OS" = "Darwin" ]; then
    flutter test --exclude-tags golden   # goldens are rendered on Linux
  else
    flutter test
  fi
fi

step "Done"
cat <<'EOF'
Run the app:
  flutter devices                  # list simulators/emulators
  flutter run -d <device id>

Device tests (end-to-end journey):
  flutter test integration_test -d <device id>

Build:
  flutter build apk --debug        # Android → build/app/outputs/flutter-apk/
  flutter build ios --simulator    # iOS simulator (macOS only)

Deploy Android builds to GCP: see DEPLOY.md (bash tool/deploy_gcp.sh).
EOF
