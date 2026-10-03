# Orchestrator loop

Model: Claude Fable 5.1. Keep your own context small: read reports, not logs.

Loop until the kill rule fires or `TASKS.md` has no `todo` tasks:

1. Read `STATE.json` and `TASKS.md`. Pick the first `todo` task; set it to `running`; commit.
2. Fill `prompts/worker.md` with the task, the time box (default 25 minutes), the published proof and lemma plan for the task, the `tried` and `blocking` notes from the ledger for that task, and the checker's description of the last failed submission for that task (or "none").
3. Dispatch one worker subagent (model `opus`, effort `xhigh`) with that prompt. Wait.
4. If the report says `status: green`: Before submitting, check yourself that `lake build Challenge Solution` succeeds and `grep -c sorry Solution.lean` prints 0; if not, treat the report as `partial`. Then commit with the message `submit(<target>): <task id> attempt <n>` (use `--allow-empty` if nothing changed) and push.
   The checker repository picks up `submit(` commits on its own every 15 minutes; nobody needs to start it.
   Poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the context `comparator/<target>` is `success` or `failure` (allow up to 60 minutes).
   - `success`: record `scripts/ledger.sh add --verdict pass --checker <target_url of the status>` and set the task `done`.
   - `failure`: read the status `description`; it is the last line Comparator printed. Classify the failure as `lean`. Record it with `--verdict fail --class lean` and a note `builds=<n>; tried=<...>; blocking=checker: <description>`, and add `; cheat=1` when the description contains "do not match" or "Illegal axiom". Pass the description to the next worker as its checker verdict.
5. If `partial` or `stuck`: classify the failure as `lean` or `math`.
   - `math` only when the build errors materially expose that the lemma plan is false or insufficient. A worker's `math_concern` line is a reason to look, not proof.
   - A hard or unfinished proof is `lean`. When ambiguous, `lean`.
   - Record the attempt with `scripts/ledger.sh add --verdict fail --class lean|math`, the minutes, the estimated cost from `docs/budget.md`, and a note `builds=<n>; tried=<report's tried>; blocking=<report's blocking>`.
   - `lean`: dispatch a fresh worker with the same plan. It sees every error by building the committed state.
   - `math`: re-plan the lemma decomposition yourself, write the new plan in `TASKS.md` and the ledger note, then dispatch a fresh worker with it.
   - Apply the plateau rule from AGENTS.md; a third failure on one task sets it `blocked`.
6. Never dispatch a blank retry. Every new worker gets the ledger's `tried` and `blocking` for its task, and the checker's description when the last failure came from the checker.
7. Escalate to Claude Fable 5.1 at effort `max` (one bounded call, 20 minutes, at most three per run) only after the plateau rule fired, and only to produce a new lemma decomposition or a strategy note, never to write the proof.
8. Commit and push the ledger after every attempt.
