# Budget and kill rule

Prices: Opus 5.5 $4 in / $20 out / $0.20 cache read per million tokens; Fable 5.1 $10 / $50 / $0.25.
Measured burn (Task 9): folded into the Erdős 105 warm-up run, read from the cloud credit meter at claude.ai/settings/usage ("$X of $250 left"); $247 left at launch on 2026-10-03.
Until it is measured, the orchestrator records 5 USD per 25-minute Opus worker attempt in the ledger (an estimate from the spec's range of about 7 to 15 USD per Opus hour).

Caps:
- Session cost cap: 60 USD (min of 60 and a quarter of the remaining credit); the orchestrator stops dispatching when `STATE.json` `totals.cost_usd` exceeds it, and Daniel's executor sets `"STOP": true` if the credit meter shows more than 60 USD spent.
- Session wall-clock cap: 6 hours for the warm-up.
- Fable escalations: at most 3 per run, 20 minutes each.
- Worker time box: 25 minutes.
- Reserve: 20 USD of the credit is never scheduled.

Kill rule: any cap reached, or Daniel sets {"STOP": true} in STATE.json, ends the run; the orchestrator commits, pushes, and stops.
`scripts/state.py` keeps the `STOP` flag when it rebuilds `STATE.json`.
