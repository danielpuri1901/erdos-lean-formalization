#!/bin/bash
# SessionStart hook. In cloud sessions: put Lean on PATH, move the prebuilt .lake into the checkout, check the build.
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
ENV_DIR="${ERDOS_ENV_DIR:-/opt/erdos-env}"
export PATH=/opt/lean/bin:$PATH
[ -n "${CLAUDE_ENV_FILE:-}" ] && echo 'export PATH=/opt/lean/bin:$PATH' >> "$CLAUDE_ENV_FILE"
cd "$CLAUDE_PROJECT_DIR" || exit 0
[ -e .lake ] || [ ! -d "$ENV_DIR/.lake" ] || mv "$ENV_DIR/.lake" .lake
tail -3 /tmp/cloud-setup.log 2>/dev/null
# Without the prebuilt packages, lake would compile Mathlib from source for hours.
if [ ! -d .lake/packages/mathlib ]; then
  echo "prebuilt packages missing: do not run lake build; read /tmp/cloud-setup.log and stop"
  exit 0
fi
echo "lean: $(lean --version 2>&1)"
start=$(date +%s); lake build Challenge >/tmp/lake-check.log 2>&1; echo "lake build Challenge: exit $? in $(( $(date +%s) - start ))s"
