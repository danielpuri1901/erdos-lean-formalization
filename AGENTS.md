# Agent instructions for erdos-lean-formalization

Read `docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md` once.

## Roles

The orchestrator session plans, dispatches one worker per attempt, records results, and pushes.
It never edits `Solution.lean` itself.
A worker is a fresh subagent that works on exactly one task from `TASKS.md`, time-boxed, and returns the report in `prompts/worker.md`.

## Rules that never bend

- `Challenge.lean` is frozen. Never edit it. The checker overwrites it anyway.
- Never write `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `skipKernelTC`, or `unsafe` into `Solution.lean` or `solutions/`.
- Success is only a green `comparator/<target>` commit status from the checker repository on a pushed commit. Nothing printed in this session counts.
- After every attempt: commit, push, `scripts/ledger.sh add ...`, commit the ledger, push.
- Plateau rule: two attempts on one task with no reduction in the `sorry` count force a strategy change written in the ledger note; a third failure sets the task to `blocked`.
- Never mark a task impossible without three ledgered attempts.
- Kill rule: stop the run when `STATE.json` `totals.cost_usd` passes the cap in `docs/budget.md`, or when the wall clock passes the session cap, or when Daniel writes `"STOP": true` in `STATE.json`.
- Workers return the first 20 error lines at most, never raw build logs.

## Commands

- Build: `export PATH=/opt/lean/bin:$PATH && lake build Challenge Solution`
- Count remaining sorries: `grep -c "sorry" Solution.lean || true`
- Axioms: `printf 'import Solution\n#print axioms <theorem>\n' > /tmp/Axioms.lean && lake env lean /tmp/Axioms.lean`. Only `propext`, `Quot.sound`, and `Classical.choice` may appear.
- Ask the checker: Daniel (or a scheduled dispatch Daniel set up) runs `verify.yml` on the pushed commit; the orchestrator waits for the commit status `comparator/<target>` with `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status`.
