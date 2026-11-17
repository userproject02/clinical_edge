#!/usr/bin/env bash
# Claude Code SessionStart hook: prints current status and recent changes from CLAUDE.md into context.
set -euo pipefail
root="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
f="$root/CLAUDE.md"
[ -f "$f" ] || exit 0
echo "=== ClinicalEdge context (from CLAUDE.md) ==="
awk '/^## Current status/{p=1} /^## Module map/{p=0} p' "$f"
echo "Last 5 change-log entries:"
awk '/^## Change log/{p=1; next} /^## /{p=0} p && /^- /' "$f" | head -5
echo "Rules: read CLAUDE.md + AGENTS.md before changing code; update CLAUDE.md in the same commit as every change."
