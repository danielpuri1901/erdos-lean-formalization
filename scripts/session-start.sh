#!/bin/bash
# SessionStart hook. In cloud sessions: put Lean on PATH, move the prebuilt .lake into the checkout, check the build.
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
export PATH=/opt/lean/bin:$PATH
[ -n "${CLAUDE_ENV_FILE:-}" ] && echo 'export PATH=/opt/lean/bin:$PATH' >> "$CLAUDE_ENV_FILE"
cd "$CLAUDE_PROJECT_DIR" || exit 0
[ -e .lake ] || [ ! -d /opt/erdos-env/.lake ] || mv /opt/erdos-env/.lake .lake
echo "lean: $(lean --version 2>&1)"
start=$(date +%s); lake build Challenge >/tmp/lake-check.log 2>&1; echo "lake build Challenge: exit $? in $(( $(date +%s) - start ))s"
tail -3 /tmp/cloud-setup.log 2>/dev/null
