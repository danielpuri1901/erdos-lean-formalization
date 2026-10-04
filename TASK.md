# Task: the Ramsey number R(3, 5) is 14

## Goal

`Solution.lean` must contain

```lean
theorem ramsey_3_5 : type_of% @RamseyNumbers.ramsey_number_three_five
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

R(3, 5) = 14 (Greenwood and Gleason, 1955).
Read the definition of `R(k, l)` and `IsGraphRamsey` in `FormalConjectures/Wikipedia/RamseyNumbers.lean` first.
Lower bound: a triangle-free graph on 13 vertices with no independent set of size 5.
The usual example is the circulant graph on Z/13 with connection set {1, 5, 8, 12}; this is from memory, so check it by computation before you use it.
Upper bound: R(3, 5) <= R(2, 5) + R(3, 4) = 5 + 9 = 14, which needs R(3, 3) <= 6 and R(3, 4) <= 9; the bound 9 uses that 9 vertices cannot all have degree 3.
Do not try to check all graphs on 14 vertices by computation.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(ramsey35):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/ramsey35` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 40 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
