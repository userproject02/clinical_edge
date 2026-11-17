#!/usr/bin/env bash
# Fails when app files changed but CLAUDE.md did not.
# Usage:
#   tool/ci/context_guard.sh worktree          # uncommitted + untracked changes (Claude Code Stop hook)
#   tool/ci/context_guard.sh staged            # staged changes (pre-commit hook)
#   tool/ci/context_guard.sh range BASE HEAD   # commit range (CI)
#   tool/ci/context_guard.sh phase-tag TAG     # phase tag: CLAUDE.md and docs/TESTCASES.md must change since previous phase tag
set -euo pipefail

cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  exit 0
fi

APP_PATTERN='^(lib/|test/|integration_test/|assets/|android/|ios/|pubspec\.yaml$|pubspec\.lock$|analysis_options\.yaml$|l10n\.yaml$|build\.yaml$)'
mode="${1:-worktree}"

case "$mode" in
  worktree)
    changed="$(git status --porcelain --untracked-files=all | sed -E 's/^.{3}//; s/.* -> //')"
    ;;
  staged)
    changed="$(git diff --cached --name-only --diff-filter=ACMRD)"
    ;;
  range)
    base="${2:?base sha required}"; head="${3:-HEAD}"
    if [ -z "$base" ] || [ "$base" = "0000000000000000000000000000000000000000" ] || ! git cat-file -e "$base^{commit}" 2>/dev/null; then
      base="$(git rev-list --max-parents=0 "$head" | tail -n 1)"
      changed="$(git diff-tree --no-commit-id --name-only -r --root "$base"; git diff --name-only "$base" "$head")"
    else
      changed="$(git diff --name-only "$base" "$head")"
    fi
    ;;
  phase-tag)
    tag="${2:?tag required}"
    prev="$(git describe --tags --abbrev=0 --match 'phase-*' "$tag^" 2>/dev/null || true)"
    if [ -n "$prev" ]; then
      changed="$(git diff --name-only "$prev" "$tag")"
    else
      root="$(git rev-list --max-parents=0 "$tag" | tail -n 1)"
      changed="$(git diff-tree --no-commit-id --name-only -r --root "$root"; git diff --name-only "$root" "$tag")"
    fi
    missing=""
    echo "$changed" | grep -qx 'CLAUDE.md' || missing="$missing CLAUDE.md"
    echo "$changed" | grep -qx 'docs/TESTCASES.md' || missing="$missing docs/TESTCASES.md"
    if [ -n "$missing" ]; then
      echo "Phase tag $tag: these files were not updated since ${prev:-the first commit}:$missing" >&2
      exit 1
    fi
    echo "Phase tag $tag: CLAUDE.md and docs/TESTCASES.md updated."
    exit 0
    ;;
  *)
    echo "unknown mode: $mode" >&2; exit 2 ;;
esac

app_changes="$(echo "$changed" | grep -E "$APP_PATTERN" || true)"
if [ -z "$app_changes" ]; then
  exit 0
fi
if echo "$changed" | grep -qx 'CLAUDE.md'; then
  exit 0
fi

{
  echo "App files changed but CLAUDE.md was not updated:"
  echo "$app_changes" | sed 's/^/  - /' | head -20
  echo "Add a change-log line (and update module map / contracts / status if affected) in CLAUDE.md. See AGENTS.md → Change protocol."
} >&2
exit 1
