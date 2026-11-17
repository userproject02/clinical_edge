#!/usr/bin/env bash
# Claude Code Stop hook: block finishing while app files are modified but CLAUDE.md is not.
set -uo pipefail
input="$(cat || true)"
root="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$root" || exit 0

# Avoid an endless loop: if we already blocked once in this stop cycle, warn but allow.
if echo "$input" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  if ! bash tool/ci/context_guard.sh worktree >/dev/null 2>&1; then
    echo "Warning: CLAUDE.md still not updated; pre-commit hook and CI will reject this change." >&2
  fi
  exit 0
fi

if out="$(bash tool/ci/context_guard.sh worktree 2>&1)"; then
  exit 0
fi
reason="Update CLAUDE.md (change log + affected sections) before finishing. ${out//$'\n'/ }"
reason="${reason//\"/\'}"
printf '{"decision":"block","reason":"%s"}\n' "$reason"
exit 0
