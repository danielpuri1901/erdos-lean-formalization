# Budget and kill rule

Prices: Opus 5.5 $4 in / $20 out / $0.20 cache read per million tokens; Fable 5.1 $10 / $50 / $0.25.
Measured burn (Task 9): Opus 5.5 ____ USD/hour; Fable 5.1 ____ USD/hour.

Caps:
- Session cost cap: ____ USD (orchestrator stops dispatching when STATE.json totals.cost_usd exceeds it).
- Session wall-clock cap: ____ hours.
- Fable escalations: at most 3 per run, 20 minutes each.
- Worker time box: 25 minutes.
- Reserve: 20 USD of the credit is never scheduled.

Kill rule: any cap reached, or Daniel sets {"STOP": true} in STATE.json, ends the run; the orchestrator commits, pushes, and stops.
`scripts/state.py` keeps the `STOP` flag when it rebuilds `STATE.json`.
