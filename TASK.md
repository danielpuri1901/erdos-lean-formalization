# Task: the Steiner system S(5, 8, 24) exists

## Goal

`Solution.lean` must contain

```lean
theorem witt_design_exists : type_of% @SteinerSystems.steiner_system_5_8_24
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

The large Witt design exists: a Steiner system S(5, 8, 24) (Witt, 1938).
Read `SteinerSystem` in `FormalConjectures/Wikipedia/SteinerSystem.lean` first: `cover_unique` asks that every 5-subset lies in exactly one block.
The blocks are the 759 octads, the words of weight 8 in the extended binary Golay code.
Generate them with your own program and write them into Lean as data, for example as `Nat` bitmasks.
A check of all 42,504 five-subsets against 759 blocks is heavy; a counting argument is lighter: any two distinct blocks share at most 4 points, so a 5-subset lies in at most one block, and 759 * 56 = 42,504 = C(24, 5) then gives exactly one.
Keep every kernel check small and split the pairwise check into chunks.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(witt24):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/witt24` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 40 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
