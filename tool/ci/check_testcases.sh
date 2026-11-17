#!/usr/bin/env bash
# Fails when a requirement ID referenced in changed test files has no row in docs/TESTCASES.md.
# Usage: tool/ci/check_testcases.sh BASE HEAD   (or no args: compare working tree with HEAD)
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

if [ $# -ge 1 ] && [ -n "${1:-}" ] && [ "$1" != "0000000000000000000000000000000000000000" ] && git cat-file -e "$1^{commit}" 2>/dev/null; then
  files="$(git diff --name-only "$1" "${2:-HEAD}" -- test integration_test)"
else
  files="$(git ls-files test integration_test)"
fi

ids=""
for f in $files; do
  [ -f "$f" ] || continue
  ids="$ids $(grep -oE '\b(AUTH|HOME|CRS|QZ|CERT|COMP|PAY|ADM|SET)-[0-9]+\b' "$f" || true)"
done
ids="$(echo "$ids" | tr ' ' '\n' | sed '/^$/d' | sort -u)"

missing=""
for id in $ids; do
  grep -q "| $id |" docs/TESTCASES.md || missing="$missing $id"
done

if [ -n "$missing" ]; then
  echo "Requirement IDs used in tests but missing from docs/TESTCASES.md:$missing" >&2
  exit 1
fi
echo "TESTCASES.md covers all requirement IDs referenced in changed tests."
