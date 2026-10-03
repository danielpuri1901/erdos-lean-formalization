#!/usr/bin/env bash
# The session hook must never start a build when the prebuilt packages are missing:
# lake would compile Mathlib from source for hours (smoke session 2, 2026-10-03).
set -u
cd "$(dirname "$0")/.."
tmp=$(mktemp -d); fail=0
mkdir -p "$tmp/bin" "$tmp/project"
printf '#!/bin/sh\necho "lake $*" >> "%s/calls"\n' "$tmp" > "$tmp/bin/lake"; chmod +x "$tmp/bin/lake"
printf '#!/bin/sh\necho "Lean (fake)"\n' > "$tmp/bin/lean"; chmod +x "$tmp/bin/lean"
out=$(PATH="$tmp/bin:$PATH" CLAUDE_CODE_REMOTE=true CLAUDE_PROJECT_DIR="$tmp/project" ERDOS_ENV_DIR="$tmp/no-env" bash scripts/session-start.sh 2>&1)
if [ -s "$tmp/calls" ]; then echo "FAIL no_packages: lake was called: $(cat "$tmp/calls")"; fail=1; else echo "ok   no_packages: lake not called"; fi
echo "$out" | grep -q "prebuilt packages missing" && echo "ok   no_packages: says why" || { echo "FAIL no_packages: no reason printed: $out"; fail=1; }
mkdir -p "$tmp/env/.lake/packages/mathlib"
out=$(PATH="$tmp/bin:$PATH" CLAUDE_CODE_REMOTE=true CLAUDE_PROJECT_DIR="$tmp/project" ERDOS_ENV_DIR="$tmp/env" bash scripts/session-start.sh 2>&1)
[ -d "$tmp/project/.lake/packages/mathlib" ] && echo "ok   with_packages: .lake moved in" || { echo "FAIL with_packages: .lake not moved"; fail=1; }
grep -q "lake build Challenge" "$tmp/calls" 2>/dev/null && echo "ok   with_packages: build ran" || { echo "FAIL with_packages: build did not run"; fail=1; }
exit $fail
