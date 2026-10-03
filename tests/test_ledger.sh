#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
tmp=$(mktemp -d); cp LEDGER.md "$tmp/LEDGER.bak"; cp STATE.json "$tmp/STATE.bak" 2>/dev/null || true
trap 'cp "$tmp/LEDGER.bak" LEDGER.md; if [ -f "$tmp/STATE.bak" ]; then cp "$tmp/STATE.bak" STATE.json; else rm -f STATE.json; fi' EXIT
bash scripts/ledger.sh add --task TX --attempt 1 --commit aaa --verdict fail --minutes 10 --cost 1.5 --note "first"
bash scripts/ledger.sh add --task TX --attempt 2 --commit bbb --verdict pass --minutes 5 --cost 0.5 --note "no checker" && { echo "FAIL: pass without checker accepted"; exit 1; } || true
python3 -c 'import json; s=json.load(open("STATE.json")); s["STOP"]=True; json.dump(s, open("STATE.json","w"))'
bash scripts/ledger.sh add --task TX --attempt 2 --commit bbb --verdict pass --minutes 5 --cost 0.5 --checker https://example/run/1 --note "green"
python3 - <<'PY'
import json; s=json.load(open("STATE.json")); t=s["tasks"]["TX"]
assert t["attempts"]==2 and t["done"] is True and t["last_verdict"]=="pass", t
assert abs(s["totals"]["cost_usd"]-2.0)<1e-9, s["totals"]
assert s.get("STOP") is True, "Daniel's STOP flag was dropped"
print("ok ledger")
PY
