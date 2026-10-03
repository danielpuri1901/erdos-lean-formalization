#!/usr/bin/env bash
# Usage: scripts/ledger.sh add --task T1 --attempt 1 --commit abc1234 --verdict fail|pass|stopped --minutes 25 --cost 3.10 [--checker URL] --note "text"
set -euo pipefail
cd "$(dirname "$0")/.."
[ "${1:-}" = "add" ] || { echo "usage: ledger.sh add --task ... " >&2; exit 2; }
shift
task= attempt= commit= verdict= minutes= cost= checker= note=
while [ $# -gt 0 ]; do
  case "$1" in
    --task) task=$2;; --attempt) attempt=$2;; --commit) commit=$2;; --verdict) verdict=$2;;
    --minutes) minutes=$2;; --cost) cost=$2;; --checker) checker=$2;; --note) note=$2;;
    *) echo "unknown flag $1" >&2; exit 2;;
  esac; shift 2
done
for v in task attempt commit verdict minutes cost; do [ -n "${!v}" ] || { echo "missing --$v" >&2; exit 2; }; done
case "$verdict" in pass|fail|stopped) ;; *) echo "verdict must be pass, fail, or stopped" >&2; exit 2;; esac
if [ "$verdict" = pass ] && [ -z "$checker" ]; then echo "a pass needs --checker URL" >&2; exit 2; fi
printf '| %s | %s | %s | %s | %s | %s | %s | %s | %s |\n' "$(date -u +%FT%TZ)" "$task" "$attempt" "$commit" "$verdict" "$minutes" "$cost" "${checker:--}" "${note//|/\/}" >> LEDGER.md
python3 scripts/state.py
