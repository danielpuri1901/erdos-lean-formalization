#!/bin/bash
# v0: probe only. Records facts about the cloud VM; never fails the session.
LOG=/tmp/cloud-probe.log
{
  echo "date=$(date -u +%FT%TZ)"
  echo "pwd=$PWD"; echo "user=$(whoami)"; echo "home=$HOME"
  echo "nproc=$(nproc)"; echo "mem=$(free -g | awk '/Mem/{print $2}')G"
  echo "disk=$(df -h / | awk 'NR==2{print $4}') free"
  echo "lakefile_in_pwd=$([ -f lakefile.toml ] && echo yes || echo no)"
  echo "curl_version=$(curl --version | head -1)"
  for u in \
    https://github.com/danielpuri1901/erdos-lean-formalization/releases/download/probe-v0/probe.txt \
    https://github.com/leanprover/lean4/releases/download/v4.33.1/lean-4.33.1-linux.tar.zst \
    https://cache.mathlib.org/ \
    https://release.lean-lang.org/ ; do
    code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 20 --head "$u" 2>&1 | tail -c 3)
    echo "head $u -> $code"
  done
  echo "env_remote=$CLAUDE_CODE_REMOTE"
  echo "home_user_ls=$(ls /home/user 2>/dev/null | tr '\n' ' ')"
  echo "find_lakefile=$(find / -maxdepth 4 -name lakefile.toml 2>/dev/null | tr '\n' ' ')"
  code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 30 https://github.com/danielpuri1901/erdos-lean-formalization/releases/download/probe-v0/probe.txt 2>&1 | tail -c 3)
  echo "get private asset -> $code"
  code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 30 https://api.github.com/repos/danielpuri1901/erdos-lean-formalization/releases/tags/probe-v0 2>&1 | tail -c 3)
  echo "get private release api -> $code"
} > "$LOG" 2>&1 || true
exit 0
