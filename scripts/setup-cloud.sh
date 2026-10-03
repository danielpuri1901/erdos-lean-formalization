#!/bin/bash
# v1: restore Lean at /opt/lean and the prebuilt dependencies at /opt/erdos-env/.lake/packages.
# The dependencies come from the public repository danielpuri1901/erdos-lean-env (compiled open-source libraries only).
# The setup script does not run inside the checkout, so scripts/session-start.sh moves .lake into it.
# Must finish in under 5 minutes; never fails the session.
LOG=/tmp/cloud-setup.log
BASE="https://github.com/danielpuri1901/erdos-lean-env/releases/download/env-v1"
LEAN_URL="https://github.com/leanprover/lean4/releases/download/v4.33.1/lean-4.33.1-linux.tar.zst"
start=$(date +%s)
(
  set -euo pipefail
  echo "pwd=$PWD user=$(whoami)"
  # The cloud image has no zstd command (smoke session 2026-10-03); both archives need it.
  if ! command -v unzstd >/dev/null; then
    apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq zstd >/dev/null
    echo "zstd_seconds=$(( $(date +%s) - start ))"
  fi
  rm -rf /tmp/env /opt/erdos-env && mkdir -p /tmp/env /opt/lean /opt/erdos-env && cd /tmp/env
  curl -sSfL "$LEAN_URL" | tar --use-compress-program=unzstd -xf - -C /opt/lean --strip-components=1
  echo "lean_seconds=$(( $(date +%s) - start ))"
  curl -sSfL -O "$BASE/env.sha256"
  awk '{print $2}' env.sha256 | xargs -P 8 -I{} curl -sSfL -o {} "$BASE/{}"
  sha256sum -c env.sha256
  echo "download_seconds=$(( $(date +%s) - start ))"
  cat $(awk '{print $2}' env.sha256) | tar --use-compress-program=unzstd -xf - -C /opt/erdos-env
  echo 'export PATH=/opt/lean/bin:$PATH' > /etc/profile.d/lean.sh
  chmod -R a+rwX /opt/erdos-env /opt/lean
  rm -rf /tmp/env
  echo "setup_seconds=$(( $(date +%s) - start ))"
) > "$LOG" 2>&1
# Not `( ... ) || ...`: bash ignores set -e inside a command whose status `||` tests.
rc=$?
[ "$rc" -eq 0 ] || echo "setup failed (exit $rc), see above" >> "$LOG"
exit 0
