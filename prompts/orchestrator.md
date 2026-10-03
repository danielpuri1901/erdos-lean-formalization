# Orchestrator loop

Model: Claude Fable 5.1. Keep your own context small: read reports, not logs.

Loop until the kill rule fires or `TASKS.md` has no `todo` tasks:

1. Read `STATE.json` and `TASKS.md`. Pick the first `todo` task; set it to `running`; commit.
2. Fill `prompts/worker.md` with the task, the time box (default 25 minutes), the published proof and lemma plan for the task, the failed approaches from the ledger for that task, and the last diagnostic (the previous attempt's first 20 error lines, or "none" for a first attempt).
3. Dispatch one worker subagent (model `opus`, effort `xhigh`) with that prompt. Wait.
4. Read the report. If `status: green`: push, note the commit in `TASKS.md`, and request a checker run (see AGENTS.md). Record the verdict with `scripts/ledger.sh add` once the commit status arrives. Set the task `done` only on `success`.
5. If `partial` or `stuck`: classify the failure as `lean` or `math`.
   - `math` only when the build errors materially expose that the lemma plan is false or insufficient. A worker's `math_concern` line is a reason to look, not proof.
   - A hard or unfinished proof is `lean`. When ambiguous, `lean`.
   - Record the attempt with `scripts/ledger.sh add --verdict fail --class lean|math`, the minutes, the estimated cost from `docs/budget.md`, and a note that starts with `builds=<n>` from the report.
   - `lean`: dispatch a fresh worker with the same plan plus the first 20 error lines.
   - `math`: re-plan the lemma decomposition yourself, write the new plan in `TASKS.md` and the ledger note, then dispatch a fresh worker with it.
   - Apply the plateau rule from AGENTS.md; a third failure on one task sets it `blocked`.
6. Never dispatch a blank retry. Every new worker gets the last diagnostic and the ledger's failed approaches for its task.
7. Escalate to Claude Fable 5.1 at effort `max` (one bounded call, 20 minutes, at most three per run) only after the plateau rule fired, and only to produce a new lemma decomposition or a strategy note, never to write the proof.
8. Commit and push the ledger after every attempt.
