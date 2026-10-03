#!/usr/bin/env python3
"""Rebuild STATE.json from LEDGER.md. Only this script writes STATE.json."""
import json, pathlib
root = pathlib.Path(__file__).resolve().parent.parent
rows = []
for line in (root / "LEDGER.md").read_text().splitlines():
    if not line.startswith("|") or line.startswith("| time") or line.startswith("|---"):
        continue
    cells = [c.strip() for c in line.strip().strip("|").split("|")]
    if len(cells) < 9 or cells[1] == "guard":
        continue
    rows.append(dict(zip(["time", "task", "attempt", "commit", "verdict", "minutes", "cost_usd", "checker", "note"], cells)))
tasks = {}
for r in rows:
    t = tasks.setdefault(r["task"], {"attempts": 0, "last_verdict": None, "done": False, "minutes": 0.0, "cost_usd": 0.0})
    t["attempts"] += 1
    t["last_verdict"] = r["verdict"]
    t["minutes"] += float(r["minutes"])
    t["cost_usd"] += float(r["cost_usd"])
    if r["verdict"] == "pass" and r["checker"].startswith("http"):
        t["done"] = True
state = {
    "tasks": tasks,
    "totals": {"minutes": sum(t["minutes"] for t in tasks.values()), "cost_usd": round(sum(t["cost_usd"] for t in tasks.values()), 2)},
    "denials": sum(1 for l in (root / "LEDGER.md").read_text().splitlines() if "| guard |" in l),
}
# Daniel's kill switch survives every rebuild.
old = root / "STATE.json"
if old.exists() and json.loads(old.read_text()).get("STOP"):
    state["STOP"] = True
(root / "STATE.json").write_text(json.dumps(state, indent=2, sort_keys=True) + "\n")
print(json.dumps(state["totals"]))
