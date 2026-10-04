# Task: the Ramsey number R(3, 4) is 9

## Goal

`Solution.lean` must contain

```lean
theorem ramsey_3_4 : type_of% @RamseyNumbers.ramsey_number_three_four
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

R(3, 4) = 9 (Greenwood and Gleason, 1955).
Read the definition of `R(k, l)` and `IsGraphRamsey` in `FormalConjectures/Wikipedia/RamseyNumbers.lean` first.
The branches `origin/run/ramsey44` and `origin/run/ramsey35` of this repository hold Lean proofs, accepted by the checker or waiting for it, of R(4, 4) = 18 and R(3, 5) = 14.
Both contain the upper bound R(3, 4) <= 9 and the argument that turns the two bounds into the value of `R`.
Fetch them and reuse what you need.
Lower bound: a triangle-free graph on 8 vertices with no independent set of size 4.
The usual example is the circulant graph on Z/8 with connection set {1, 4, 7}; this is from memory, so check it by computation before you use it.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(ramsey34):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/ramsey34` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 20 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
