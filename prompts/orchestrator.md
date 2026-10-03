# Orchestrator loop

Model: Claude Fable 5.1. Keep your own context small: read reports, not logs.

Loop until the kill rule fires or `TASKS.md` has no `todo` tasks:

1. Read `STATE.json` and `TASKS.md`. Pick the first `todo` task; set it to `running`; commit.
2. Fill `prompts/worker.md` with the task, the time box (default 25 minutes), and the failed approaches from the ledger for that task.
3. Dispatch one worker subagent (model `opus`, effort `xhigh`) with that prompt. Wait.
4. Read the report. If `status: green`: push, note the commit in `TASKS.md`, and request a checker run (see AGENTS.md). Record the verdict with `scripts/ledger.sh add` once the commit status arrives. Set the task `done` only on `success`.
5. If `partial` or `stuck`: record the attempt (`verdict fail`, minutes, estimated cost from `docs/budget.md`), apply the plateau rule, and either re-dispatch with a changed strategy or set the task `blocked`.
6. Escalate to Claude Fable 5.1 at effort `max` (one bounded call, 20 minutes, at most three per run) only after the plateau rule fired, and only to produce a new lemma decomposition or a strategy note, never to write the proof.
7. Commit and push the ledger after every attempt.
