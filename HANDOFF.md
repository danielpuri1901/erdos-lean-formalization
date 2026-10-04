# Handoff

Read this first in every session on this repository.
Last update: 2026-10-03 19:40 UTC. The Erdős 105 warm-up and all six Green 72 main runs are green (`docs/main-run.md`); the write-up is published privately at https://claude.ai/artifact/3x7der745TqJWx4sYaPkKH (copy in `docs/writeup/`). The checker's `check-submits` schedule is disabled until the next run.

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
- Task 9: folded into the warm-up run; the burn is read from the cloud credit meter (247 of 250 USD at launch).
- Task 10 passed: 58 witnesses (N = 3 to 60) fetched and re-verified exactly; the N = 60 kernel check takes 48 seconds, so `decide +kernel` works for every N (`docs/preflight.md`).
- Task 11: staged (one task E105 in `TASKS.md` with the published counterexample and a lemma plan; Challenge is the frozen statement; Solution holds it with `sorry`). The orchestrator session runs it at claude.ai/code (session `session_01B7hB8bfBYPWgkem72nKBg4`); verdicts arrive automatically through `submit(erdos105):` commits.
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

Done: checker token, cloud environment `erdos-lean` (setup script now pasted by the executor through Chrome), smoke sessions, usage-credit check (usage credits on, 0 EUR balance, 43 EUR monthly cap, auto-reload off; cloud credit 247 of 250 USD at launch, expires 2026-11-05).

Second round so far (2026-10-03, details in `docs/clarksuen-pilot.md`): bare pilots proved Clark-Suen (22 minutes, about 2 USD) and Suen-Tarr (about 31 minutes, about 3 USD), each on the first submission.
Both are short combinatorics proofs, too easy to show whether the harness helps.
Daniel chose to look for a target about 10 times harder (a long published proof, or one that needs theory Mathlib lacks); the search is running.
New run caps for that target need Daniel's approval before any run.

Still Daniel's, whenever he wants:

1. Read the Erdős 105 statement audit in `docs/preflight.md` (written by Claude, not his sign-off) before anything is published.
2. Stop the run at any time by pushing `"STOP": true` into `STATE.json`, or by stopping the session "Erdős 105 warm-up orchestrator" at claude.ai/code.

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
- The checker's poller is a loop that bills every minute it runs and stops after 2 hours without a push; start it by hand when a run begins (checker README).
- Fixed 2026-10-03: the checker's private runner (7.8 GB of memory) was killed by large parallel kernel checks; verify.yml now frees disk and adds swap, and the killed b2 submission passes (checker run 37151232633).
- Fixed 2026-10-03: the poller loop crashed after its first dispatch (empty 204 response); fixed and re-tested end to end.
- Answered 2026-10-03: a cloud session cannot write commit statuses (proxy 403) or read the checker (403), so a green `comparator/<target>` status is still proof. Re-check if the GitHub connection method changes (for example `/web-setup` with a broader token).
- Does `promptCacheTtl: "1h"` hold in cloud sessions on usage credits (Task 9 observes it)?
