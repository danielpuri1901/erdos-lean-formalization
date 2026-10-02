# Lean formalization harness: design

Status: draft for Daniel's review, 2026-10-02.
Owner: Daniel Puri.

## 1. Goal

Run an autonomous Claude Code agent for ten or more hours on real mathematics, with every result checked by a machine, and publish an honest write-up of what happened.
The agent turns published human proofs of known results into Lean 4 proofs of the exact statements in `google-deepmind/formal-conjectures`.
The harness around the agent is measured, not only the proofs.
The write-up is the portfolio piece.
A machine-checked proof is the bonus.

Success criteria, in order of weight:

1. The external checker is green on at least one target statement, from a commit the agent produced.
2. The measurement table exists: solve rate, time to green, dollars per success, failure taxonomy, cheating attempts caught, for a bare run and for the harness run.
3. Daniel can explain the Lean statement, the proof idea, and every harness decision without the model.
4. The write-up is published by 2026-10-28.

Non-goals:

- Solving an open problem.
- Posting anything on erdosproblems.com or opening a pull request without Daniel's explicit approval of the exact text.
- Building a general agent platform.

## 2. Why this shape

AI resolves open Erdős problems rarely (Nexus: 9 of 353; FrontierMath Erdős: Claude Fable 5.1 scored 0 of 68 at $300 per attempt).
AI formalizes known results far more often (OEIS Open: Claude Opus 4.8 solved 29 to 30 percent at $50 per attempt).
Claude Code has looped and quit on formal proof tasks before (Nexus appendix: Claude Code Opus 4.7 solved 0 of 9 known-solvable problems).
So the harness and the external checker are the product, and the target choice follows the odds.

## 3. Targets

Formal-conjectures commit pinned at `df3f12d7bd06` (2026-10-01), Lean toolchain `leanprover/lean4:v4.33.1`.

### Warm-up: Erdős 105, `Erdos105.erdos_105.variants.sub_four`

File: `FormalConjectures/ErdosProblems/105.lean`.
Statement: for disjoint finite sets A and B in the plane with |A| = |B| + 4 and A not collinear, does some line through two points of A miss B?
The answer is no, by an explicit 10 plus 6 point counterexample posted on FC issue #6709 (opened 2026-09-30).
The proof is a finite witness, which Lean checks by computation.
Scoop risk is days, so this target is the smoke test, not the headline.
Freeze the statement as the negated universal form on the pinned commit, because PR #6762 removes `answer(...)` wrappers.

### Main: Green 72, `Green72.no_three_in_line_le`

File: `FormalConjectures/GreensOpenProblems/72.lean`.
Statement: for 3 <= N <= 60, the largest subset of the N by N grid with no three points on a line has exactly 2N points.
The upper bound is already proved in the file (`allowedSetSize_le`).
The missing half is one witness set of 2N points per N, with a proof that no three of its points are collinear.
Witness data is public for every N up to 60 (Flammenkamp, Prellberg).
No Lean proof was found in formal-conjectures, plby/lean-proofs, open pull requests, GitHub code search, or the forum, as of 2026-10-02.

Known risks for Green 72:

- Kernel time is unmeasured. About 4.3 million triples across all N, 280 thousand at N = 60, checked once by `lake build` and again by Comparator's replay. `native_decide` is banned.
- The file uses the Lean module system (`module`, `public import`). Comparator's handling of module-system files is unverified.
- The proof may take one to three hours, mostly build waits, so the ten-hour run needs the task queue in section 6, not this target alone.
- The headline must say "kernel-verified computer search result for a Green problem", never "solved an Erdős problem".

Backup: Erdős 872, `variants.prime_question`.
Rejected after live checks: 1095 (needs the prime number theorem, absent from Mathlib), 263 (Aristotle Lean proof exists), Green 14 W(3,29) (certificate unpublished), 939 (public Lean proof since May 2026), 197 and 158 (open problems, out of scope).

## 4. Standing preflight gate

Before any budget is spent on a target, a human-readable table records, with dates and links:

1. The FC file on the pinned commit still has `sorry` and no `formal_proof` attribute.
2. No Lean proof in plby/lean-proofs, in FC pull requests, in GitHub code search for the declaration name, or in the forum thread.
3. Nobody visibly working on it.
4. The published proof is read, and every cited theorem it needs is found in Mathlib by name, or listed as a small lemma to prove.
5. Daniel has read the Lean statement against the English problem and signed off.

The table is the first published artifact.

## 5. Architecture

### Two repositories

`erdos-lean-formalization` is the agent repository.
It is attached to cloud sessions.
Everything in it is editable by the agent, so nothing in it is trusted for verdicts.

`erdos-lean-checker` is the checker repository.
It is never attached to an agent session.
It holds the frozen target statements, the Comparator configuration, and a GitHub Actions workflow that rebuilds a named commit of the agent repository and runs Comparator.
Its green check on commit X is the only definition of success.

### Roles

Orchestrator: one Claude Code cloud session on Claude Fable 5.1.
It reads the ledger, picks the next task, dispatches one worker, reads the worker's report, records the result, pushes, and repeats.
It never edits proofs itself.

Worker: a fresh Claude Code subagent on Claude Opus 5.5 at xhigh effort, one per attempt, time-boxed.
It receives one task, works in the agent repository, commits, and returns a report of fixed shape: status, files changed, remaining `sorry` count, first 20 error lines, what it tried, what it thinks blocks it.
It never returns raw build logs.

Escalation: Claude Fable 5.1 at max effort, used for the initial proof-strategy plan, for a stuck task after the plateau rule fires, and for a second opinion on the statement audit.
Each escalation is one bounded call, 20 minutes at most, three per run at most.

### State on disk

`TASKS.md` is the queue: one line per task with id, target declaration, lemma scope, status.
`LEDGER.md` is append-only: task id, attempt number, worker commit, checker verdict, time, dollars, why it failed.
`STATE.json` holds the machine-readable summary that scripts write and the orchestrator reads.
Only scripts write `STATE.json`.
Every completed attempt ends with a commit and a push.
A reclaimed VM, a compaction, or a killed session loses nothing that was pushed.

### Guards inside the agent repository

Hooks deny edits to the frozen statement files, deny `sorry`, `admit`, new `axiom`, `native_decide`, `implemented_by`, and `skipKernelTC` in committed proofs, and log every denial to the ledger.
These are cheap feedback, not security.
The agent can edit its own hooks, and the write-up says so.
The checker repository is the security.

### Checker

The workflow runs on `ubuntu-24.04` in the checker repository.
It checks out the agent repository at the commit under test, installs elan, fetches the Mathlib cache, builds the target and the frozen statement, runs an axiom audit, builds Comparator and lean4export at pinned commits, runs Comparator under landrun, and writes a commit status back to the agent repository.
Comparator is currently pinned to Lean v4.35.0-rc3 and FC to v4.33.1, and lean4export has a v4.33.0 tag.
Making these versions agree is build step 3 in section 9, and the run does not start until the checker is green on a trivial statement.

### Budget and plateau rules

Prices used: Opus 5.5 at $4 input, $20 output, $0.20 cache read per million tokens; Fable 5.1 at $10, $50, $0.25.
The credit is about 17 to 34 Opus hours or 4 to 11 Fable hours; the 15-minute burn test replaces this estimate with a measurement.
Budget plan: about 20 Opus worker hours, at most three Fable escalations of 20 minutes, $20 reserve.
Usage credits shorten the prompt cache lifetime to five minutes; set `CLAUDE_CODE_PROMPT_CACHE_TTL=1h` and confirm it holds in the burn test.
Each session has a hard dollar cap and a kill rule written in the ledger.
Plateau rule: two attempts on one task with no reduction in `sorry` count force a strategy change by the orchestrator; a third failure stops the task and records it.
The orchestrator may never declare a task impossible without three ledgered attempts.

## 6. Measurement design

The ten-hour run is a queue of bounded tasks, not one open-ended grind.
Tasks: five to eight lemma-sized pieces of Green 72 and Erdős 105.
Each task runs at least three times under arm A and three times under arm B.
Arm A is a bare `claude --cloud` run with the Nexus-style prompt and no harness.
Arm B is the full harness.
Reported per arm: solve rate, time to green checker, dollars per success, failure taxonomy with transcript links, cheating attempts the checker caught.
With n = 3 per cell the table has little statistical power, and the write-up says so.
Recommended budget split: 70 percent arm B, 30 percent arm A.

## 7. Human checkpoints

Before launch, one to two hours: build a set of deliberately bad submissions (a `sorry`, an extra axiom, a `native_decide`, an edited statement, a redefined definition) and confirm the checker rejects every one.
Before launch: Daniel reads the Lean statement against the English problem and signs the preflight table.
Every three to four hours: read the `STATE.json` diff, the last ledger lines, and `git log --stat`; no progress across two checks means steer, restart, or stop.
Morning after: re-run the checker on the final commit, read `#print axioms`, sample three commits, decide, update the decision log.

## 8. Deliverables

- The agent repository, public after Daniel's approval, with README sections: verification path, honesty inventory (what the model did, what Daniel did, what was borrowed), provenance map (which published source each idea came from), decision log.
- The checker repository.
- The preflight table.
- The measurement table.
- A write-up by 2026-10-28.
- Optionally, a two-line pull request to formal-conjectures linking the proof with a `formal_proof` attribute, only with Daniel's approval.

## 9. Build order

1. Claim the credit (done 2026-10-02) and record the usage settings before and after.
2. Create the two private repositories (this commit).
3. Make the checker green on a trivial statement with Lean v4.33.1 and a compatible Comparator and lean4export; no go until green.
4. Build the environment artifact: Lean 4.33.1, leantar, Mathlib oleans at the pinned revision, and the FC utilities, hosted as release assets on the agent repository or as a Docker image, because the cloud GitHub proxy blocks release assets from unattached repositories.
5. First cloud session, no proving: environment loads in under five minutes and `105.lean` builds.
6. Fifteen minutes on Opus 5.5 and fifteen on Fable 5.1; compute dollars per hour from token counts.
7. Time the N = 60 kernel check for Green 72 before committing budget.
8. Write the budget in hours and the session kill rule; confirm the arm split.
9. Warm-up: Erdős 105 end to end through the checker.
10. Main run: the task queue of section 6.
11. Write-up.

Calendar: 6 to 10 Lean hours for Daniel before 2026-10-15, run kill date 2026-10-24, write-up 2026-10-28, credit expiry 2026-11-04.

## 10. Decisions

- 2026-10-02: formalization of known results, not open problems. Reason: section 2.
- 2026-10-02: Fable 5.1 orchestrates, Opus 5.5 implements. Reason: judgment is rare and expensive, grinding is cheap and frequent.
- 2026-10-02: Claude Code cloud sessions, not the Pi harness. Reason: the credit pays only for cloud sessions, and Pi on a subscription login bills per token.
- 2026-10-02: Green 72 main, Erdős 105 warm-up. Reason: section 3.

## 11. Open questions

- Does Comparator accept module-system files from formal-conjectures?
- What is the N = 60 kernel check time without `native_decide`?
- Does `CLAUDE_CODE_PROMPT_CACHE_TTL=1h` hold inside cloud sessions on usage credits?
- Does the cloud proxy allow release assets from the attached agent repository?
