# Handoff

Read this first in every session on this repository.
Last update: 2026-10-03, after plan Tasks 1, 2, 3, 6, 7, 8, and 10 passed, the public dependency repository went live, and the submit( loop ran end to end; Tasks 5, 9, and 11 wait for Daniel.

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

- The checker secret `AGENT_REPO_TOKEN` is set on `erdos-lean-checker` (plan Task 2 step 1 done; token expires 2026-11-01).
- Plan Task 4 steps 1 to 3 are done: release `probe-v0` exists, `scripts/setup-cloud.sh` is the v0 probe, `docs/cloud-environment.md` is written.
  Ruling: network access is `Full`, not `Custom`, because the dialog offers it and it removes allowlist mistakes; GitHub still goes through the proxy either way.
  Daniel creates the environment and runs the probe session himself; the executing session only records the result (Task 4 step 5).

- Probe 1 ran (2026-10-02 15:02 UTC); results and reading in `docs/cloud-probe.md`.
  Public-repository release assets download through the proxy (Lean tarball 200); this private repository's asset returned 404 on HEAD; `cache.mathlib.org` is reachable; the setup script runs as root in `/home/user`, not in the checkout.
- Probe 2 ran (15:12 UTC): repositories clone into `/home/user/<repo-name>` before the setup script; private release assets are not reachable; that session had the checker attached by mistake (no agent work ran).
  Ruling for Task 5, recorded in `docs/cloud-probe.md`: toolchain from the leanprover release, Mathlib from `cache.mathlib.org`, build only the target's import closure in the setup script if Task 1's `build_seconds` shows it fits in about 270 seconds; otherwise a public `erdos-lean-env` repository for the built `.lake`, which needs Daniel's approval.
  Every real cloud session attaches only `erdos-lean-formalization`.

Plan progress (ledger: `.superpowers/sdd/2026-10-02-lean-formalization-harness/progress.md`, git-ignored):

- Task 1 passed: the Lean project builds in CI (build 261 to 338 seconds with the Mathlib cache); `lake-manifest.json` is pinned; a plain `import` of the module-system problem files works.
- Task 2 passed: the checker is green on the trivial target (`comparator/trivial` success), and the freeze test rejects an edited challenge. The checker workflow is hardened beyond the plan; see the checker README "Trust model".
- Task 3 passed: Comparator rejects all five cheating fixtures, each for its own reason (checker README "Negative tests").
- Task 4: probes 1 and 2 are recorded in `docs/cloud-probe.md`. Private release assets are not used.
- Task 5: dependencies are public in https://github.com/danielpuri1901/erdos-lean-env (release `env-v1`, 2.55 GB). The `setup-smoke` workflow runs the whole cloud setup path on a fresh runner and passes: setup 161 seconds, full build 20 seconds (`docs/cloud-probe.md`). Only the real cloud smoke session remains.
- Verdict hole fixed (2026-10-03): a solution that printed `Your solution is okay!` during its own build got a green status, because the checker searched its log for that line. The verdict is now Comparator's exit code; `tests/bad/print_ok.lean` pins it (checker README).
- No human step to ask the checker: the orchestrator pushes a `submit(<target>):` commit, and the checker's `check-submits` workflow verifies it within 15 minutes. Tested end to end on commit `00ef7c0`. On failure the status description is Comparator's last line.
- Tasks 6, 7, 8 passed: guard hook, ledger and `STATE.json`, `AGENTS.md`, worker and orchestrator prompts, budget template.
- Task 9: protocol written in `docs/burn-test.md`; the two sessions are not run.
- Task 10 passed: 58 witnesses (N = 3 to 60) fetched and re-verified exactly; the N = 60 kernel check takes 48 seconds, so `decide +kernel` works for every N (`docs/preflight.md`).
- Task 11: steps 2 and 3 done (Erdős 105 witness data and verifier; frozen statement, Comparator config, and axiom audit in the checker, statement elaborates). Step 1 (Daniel's audit) and steps 4 to 7 remain.
- No final whole-plan review has run yet; it runs after Task 11.

## Executing session: local only

The executor must be a local session (`claude --add-dir ~/Desktop/Projects/erdos-lean-checker` from this repository).
Cloud sessions do not have the superpowers plugin, spend the credit on build work, and would attach the checker repository to the cloud, which the spec forbids.
If the plan's skills are unavailable, run the tasks in order by hand, keeping a ledger in `.superpowers/sdd/<plan>/progress.md` with one line per completed task.

## How to execute

1. Start a Claude Code session with this repository as the working directory and the checker repository added as a second directory: `claude --add-dir ~/Desktop/Projects/erdos-lean-checker`.
2. Model: Claude Opus 5.5 at effort xhigh is enough; the plan carries the design.
3. Prompt: `Read HANDOFF.md, then execute docs/superpowers/plans/2026-10-02-lean-formalization-harness.md with the superpowers:executing-plans skill. Start at Task 1.`
4. The executor keeps its ledger under `.superpowers/sdd/` (git-ignored) and commits after every task.
5. Update this file at every task boundary: what passed, what failed, what Daniel still has to do.

## Daniel's manual steps (the agent cannot do these)

Done: the checker token (Task 2 step 1), the cloud environment `erdos-lean`, probes 1 and 2.

Next, in this order:

1. Paste the current `scripts/setup-cloud.sh` into the `erdos-lean` environment's setup script field, then start one session on `erdos-lean-formalization` only, with the prompt in `docs/cloud-environment.md` ("Smoke session"). It also probes whether the session's GitHub access can write a commit status (a fake verdict) or read the checker. Paste the output to the executing session.
2. Task 9: start the two 15-minute burn-test sessions from `docs/burn-test.md` and read the credit meter before and after each.
3. Task 11 step 1: write the statement audit for Erdős 105 in `docs/preflight.md` before any proving session starts.
4. Report whether usage credits are on or off at claude.ai/settings/usage, and any cap.

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

- Does the setup script restore the 2.55 GB artifact in under five minutes (Task 5 step 6 answers it)?
- Every push to `main` runs `build.yml` (about 7 minutes of Actions time on a private repository); a busy run pushes often.
- The checker's 15-minute poller bills about 96 Actions minutes a day on a private repository; disable it between runs (checker README).
- Answered 2026-10-03: a cloud session cannot write commit statuses (proxy 403) or read the checker (403), so a green `comparator/<target>` status is still proof. Re-check if the GitHub connection method changes (for example `/web-setup` with a broader token).
- Does `promptCacheTtl: "1h"` hold in cloud sessions on usage credits (Task 9 observes it)?
