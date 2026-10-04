# Task: Gauss's bound for the circle problem

## Goal

`Solution.lean` must contain

```lean
theorem gauss_circle_error_le : type_of% @GaussCircleProblem.error_le
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

Read the definitions of `N` and `E` in `FormalConjectures/Wikipedia/GaussCircleProblem.lean` first.
The statement is `∀ᶠ r in atTop, |E r| ≤ 2 * √2 * π * r`.
Gauss's argument: put a unit square centred at every integer point of the disc of radius r.
The squares are disjoint up to boundaries, their union has area N(r), it lies inside the disc of radius r + √2/2, and it covers the disc of radius r - √2/2.
So π(r - √2/2)² ≤ N(r) ≤ π(r + √2/2)², which gives |E(r)| ≤ π(√2 r + 1/2) ≤ 2√2 π r for r ≥ 1.
You may replace the area argument by any other correct proof of the same bound, for example a counting argument by columns.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(gausscircle):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/gausscircle` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 75 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
