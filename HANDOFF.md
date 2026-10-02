# Handoff

Read this first in every session on this repository.
Last update: 2026-10-02, after the plan was written and before any task of it ran.

## What this project is

An autonomous Claude Code agent turns published human proofs of known Erdős and Green results into Lean 4 proofs of the exact statements in `google-deepmind/formal-conjectures`, with an external checker and a measured harness.
The portfolio piece is the write-up of the harness and the run.
A machine-checked proof is the bonus.

Spec: `docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md` (approved by Daniel on 2026-10-02).
Plan: `docs/superpowers/plans/2026-10-02-lean-formalization-harness.md` (11 tasks, each with code, commands, and pass criteria).

## State

Done:

- Both repositories exist, private: this one (agent) and `danielpuri1901/erdos-lean-checker` (checker, local at `~/Desktop/Projects/erdos-lean-checker`, never attached to an agent session).
- The $250 cloud-session credit is claimed: $250 of $250 left, expires 2026-11-05 08:59 GMT+1, cloud sessions only, not Routines or Projects.
- Preflight facts are in the spec, section 3: Erdős 105 counterexample verified with exact integers; Green 72 witness data sources confirmed; no Lean proof found for either; Comparator tag `v4.33.0` exists; Mathlib cache host is `cache.mathlib.org`.

Not done: every task in the plan.
No Lean has been built anywhere yet.
No cloud session has run yet.

## How to execute

1. Start a Claude Code session with this repository as the working directory and the checker repository added as a second directory: `claude --add-dir ~/Desktop/Projects/erdos-lean-checker`.
2. Model: Claude Opus 5.5 at effort xhigh is enough; the plan carries the design.
3. Prompt: `Read HANDOFF.md, then execute docs/superpowers/plans/2026-10-02-lean-formalization-harness.md with the superpowers:executing-plans skill. Start at Task 1.`
4. The executor keeps its ledger under `.superpowers/sdd/` (git-ignored) and commits after every task.
5. Update this file at every task boundary: what passed, what failed, what Daniel still has to do.

## Daniel's manual steps (the agent cannot do these)

- Task 2 step 1: create the fine-grained GitHub token `erdos-checker` (repo access only `erdos-lean-formalization`; Contents read; Commit statuses read and write; expiry 2026-11-30) and run `gh secret set AGENT_REPO_TOKEN -R danielpuri1901/erdos-lean-checker`, pasting the token at the prompt. Never paste it into chat.
- Task 4 and Task 5: create the cloud environment `erdos-lean` at claude.ai/code exactly as `docs/cloud-environment.md` says, paste the setup script, and start the probe and smoke sessions.
- Task 9: start the two 15-minute burn-test sessions and read the credit meter before and after each.
- Task 11 step 1: write the statement audit for Erdős 105 in `docs/preflight.md` before any proving session starts.
- Still open: report whether usage credits are on or off at claude.ai/settings/usage, and any cap.

## Rules that never bend

- `formal-conjectures` pin `df3f12d7bd06`, Lean `v4.33.1`, permitted axioms `propext`, `Quot.sound`, `Classical.choice`.
- Success is only a green `comparator/<target>` commit status from the checker repository.
- No `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `skipKernelTC`, `unsafe` in `Solution.lean` or `solutions/`.
- Nothing gets posted to erdosproblems.com or formal-conjectures without Daniel's approval of the exact text.
- Every cloud run is a plain cloud session or `claude --cloud`, never a Routine or a Project.
- Markdown prose: one sentence per line, no em dashes.
- Credit deadline: use it by 2026-11-04 (Pacific). Run kill date 2026-10-24. Write-up 2026-10-28.

## Decisions already made

- Formalize known results, not open problems (spec section 2).
- Fable 5.1 orchestrates, Opus 5.5 workers implement, no multi-agent fan-out, fresh worker per attempt.
- Claude Code cloud sessions, not the Pi harness, because the credit pays only for cloud sessions.
- Green 72 `Green72.no_three_in_line_le` is the main target; Erdős 105 `variants.sub_four` is the warm-up and smoke test.
- The checker lives in a separate repository and overwrites `Challenge.lean` before every verdict.
- The main run and the write-up get their own plan after Task 11 produces real numbers.

## Open risks

- Does the cloud GitHub proxy serve release assets from the attached repository (Task 4 answers it; fallback is S3)?
- Does Comparator at `v4.33.0` accept Lean `v4.33.1` oleans and module-system files from formal-conjectures (Task 2 answers it)?
- What is the Green 72 N = 60 kernel time without `native_decide` (Task 10 answers it)?
- Does `promptCacheTtl: "1h"` hold in cloud sessions on usage credits (Task 9 observes it)?
