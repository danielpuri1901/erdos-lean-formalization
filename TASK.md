# Task: a non-abelian Leinster group exists

## Goal

`Solution.lean` must contain

```lean
theorem leinster_nonabelian_exists : type_of% @LeinsterGroup.exists_nonabelian_leinster_group
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

A non-abelian Leinster group exists (Leinster, 2001).
Read `IsLeinster` in `FormalConjectures/Wikipedia/LeinsterGroup.lean` first: the orders of all normal subgroups add up to twice the order of the group.
The standard example is S3 x C5, of order 30.
The normal subgroups of S3 have orders 1, 3 and 6, and those of C5 have orders 1 and 5.
The orders 6 and 5 are coprime, so every normal subgroup of the product is a product of normal subgroups (check this claim yourself; it is from memory).
The six orders 1, 3, 6, 5, 15, 30 add up to 60.
In Lean the work is to pick a concrete type and to show that the normal subgroups are exactly these six.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(leinster):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/leinster` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 40 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
