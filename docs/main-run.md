# Green 72 main run

Plan: `docs/superpowers/plans/2026-10-03-green72-main-run.md`.
Spec: section 6 of `docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md`.

## Design

Six runs try to prove `green72_no_three_in_line_le` (the frozen `Green72.no_three_in_line_le`, 3 ≤ N ≤ 60).
Arm B is the full harness: an orchestrator session dispatches fresh worker subagents, keeps the ledger, and submits.
Arm A is bare: one session with a plain prompt and no harness files.
Both arms use Claude Opus 5.5 at effort xhigh, the same environment `erdos-lean`, the same witness data module, and the same checker.
Each run starts from its own branch `run/<arm><n>`; the cloud session pushes to its own `claude/*` branch, which the checker's poller scans.
Runs go one at a time, so the cloud credit meter attributes cost to one run.

Order: `b1`, `a1`, `b2`, `a2`, `b3`, `a3`.

## Caps

- Arm B: 35 USD and 4 hours per run.
- Arm A: 20 USD and 4 hours per run.
- That is 165 USD for six runs, about 70 percent for arm B and 30 percent for arm A.
- Never schedule the last 20 USD of credit; stop launching when the credit left is below the next run's cap plus 20 USD.
- The executor reads the meter at claude.ai/settings/usage ("Cloud session credits", "$X of $250 left") before and after each run, and stops a session that passes its cap.

## Prompts

Arm B (session on branch `run/b<n>`):

```
You are the orchestrator of Green 72 main run b<n>. Read AGENTS.md, prompts/orchestrator.md, prompts/worker.md, TASKS.md and docs/budget.md, then run the orchestrator loop on the todo tasks in TASKS.md. Workers are fresh subagents with model opus and a 25-minute time box; fill prompts/worker.md for each one. When a worker reports green and your own check passes, push a commit whose message starts with submit(green72): to your branch and poll the commit status comparator/green72 as prompts/orchestrator.md step 4 says; the checker scans claude/* branches every 15 minutes, so no human step is needed. Record every attempt with scripts/ledger.sh and push after each one. This run's caps are 35 USD and 4 hours. Stop when comparator/green72 is success, when a cap is reached, or when STATE.json contains "STOP": true. Do not ask questions; decide and record the decision in the ledger note.
```

Arm A (session on branch `run/a<n>`):

```
Prove green72_no_three_in_line_le in Solution.lean. Challenge.lean holds the frozen statement. Witness data and a Nat collinearity checker are in Solution/Green72/Witnesses.lean; the data is verified. Build with: export PATH=/opt/lean/bin:$PATH && lake build Solution. When the proof builds with no sorry, commit with the message "submit(green72): bare run a<n>" and push to your branch, then poll gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status until comparator/green72 is success or failure; the checker picks up the commit within 15 minutes. On failure read the status description, fix, and submit again. Stop at success or after 4 hours.
```

## Results

| run | arm | session | start (UTC) | solved | minutes to green | USD (meter) | attempts | submissions | cheats caught | failure classes |
|-----|-----|---------|-------------|--------|------------------|-------------|----------|-------------|---------------|-----------------|
| b1 | B | session_01DxRLN4TsM7X6ciQ45Q3EzQ | 2026-10-03 14:14 (meter 243 USD) | yes, `6eb57dc` ([checker](https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37130020332)) | 42 | 4 (243 to 239) | 1 (7 builds) | 1 | 0 | none |
| a1 | A | session_01EbHyNgTRSM4Jqz5WDw3SPQ | 2026-10-03 14:57 (meter 239 USD) | yes, `790b429` ([checker](https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37132458282)) | 30 | 2 (239 to 237) | 1 (no ledger) | 1 | 0 | none |
| b2 | B | session_01CQDEgySRWdZ197F4N5U264 | 2026-10-03 15:29 (meter 237 USD) | yes, `d35acb1` ([checker](https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37137403488)) | 93 | 4 (237 to 233) | 2 | 2 | 0 | lean (checker runner out of memory) |
| a2 | A | session_011a24115oiQXkkVf32pA2R5 | 2026-10-03 17:04 (meter 233 USD) | running | | | | | | |
| b3 | B | | | | | | | | | |
| a3 | A | | | | | | | | | |

Run b1 notes: the single worker split each witness check into 4-point chunks (`Solution/Green72/Chunk.lean`) after one `decide +kernel` over a whole witness peaked at 5.5 GB per module and a 4-way parallel build ran out of memory; a clean `lake build Solution` then took about 3 minutes.
The ledger is in `docs/ledgers/green72-b1.md`; the proof is on branch `run/b1`.

Run a1 notes: the bare session ignored the provided `noThree` and wrote its own checker on raw `Nat` operations and recursors, which cut the N = 60 kernel check from about 55 to about 11 seconds; the whole proof sits in `Solution.lean` and builds in about 2.5 minutes.
It submitted once, about 15 minutes after launch.

Run b2 notes: the first worker checked each witness in one `decide +kernel`; the build passed in the session but the checker's runner (16 GB, 4 parallel module builds) was shut down after 36 minutes, most likely out of memory, and never wrote a verdict.
That exposed a checker gap: the status stayed `pending` and the poller skipped it. The poller now turns a pending status whose run has finished into a failure with that reason (checker commit after `7533f9b`).
The orchestrator measured peak memory (2.1 GB at N = 40, 5.8 GB at N = 60), classified the failure as `lean`, and briefed worker 2, which split each check into chunks of about 10 thousand triples; the second submission passed.
The ledger is in `docs/ledgers/green72-b2.md`.

"Cheats caught" counts checker failures whose description contains `do not match` or `Illegal axiom`, plus guard denials in arm B's ledger.
With three runs per arm the table has little statistical power, and the write-up says so.
