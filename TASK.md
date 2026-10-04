# Task: minimum degree 3 forces a cycle of length divisible by 3

## Goal

`Solution.lean` must contain

```lean
theorem dean_three : type_of% @Arxiv.«2605.02731».dean_conjecture.variants.three
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

Every finite graph with minimum degree at least 3 has a cycle whose length is divisible by 3 (Chen and Saito, 1994).
Read the statement and `cycleLengths` in `FormalConjectures/Arxiv/2605.02731/DeanCycles.lean` first.
This is a real paper proof and no sketch is given here.
A longest path and the neighbours of its end vertex give three cycles, but their lengths alone do not settle the claim; the published proof needs more.
Spend at most 15 minutes on a complete paper argument.
If you do not have one by then, prove the strongest partial statement you can in Lean, write exactly what is missing, and stop.

## How to work

- Read `LESSONS.md` first. It holds what earlier sessions learned about this Lean version, kernel checks and memory.
- Write the argument and the plan into `NOTES.md` before any Lean.
- Build a skeleton first: definitions, then every lemma stated with `sorry` and a passing build, then fill the `sorry`s one at a time.
- Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`.
- Commit and push after every step that builds.
- Keep every kernel check small.
  The checker machine has 7.8 GB of memory plus swap and builds 4 modules at the same time.
- Do not search the web for solutions and do not look for existing formalizations.
- Ignore `Solution/Green72`, `data/sources`, `Timing*` and `scripts/witness.py`: they are leftovers from an earlier target.

## Submit

When the proof builds with no `sorry`, commit with a message that starts with `submit(dean3):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/dean3` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 40 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
