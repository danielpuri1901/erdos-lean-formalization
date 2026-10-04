# Task: Danilov's theorem on Hall's conjecture

## Goal

`Solution.lean` must contain

```lean
theorem hall_danilov : type_of% @Hall.danilov
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

Read `HallIneq` and `HallConjectureExp` in `FormalConjectures/Wikipedia/Hall.lean` first, and check the edge cases of the definition (x = 0, negative x, the real power).
The statement: for every δ > 0 there is no C > 0 with |y² - x³| > C |x|^(1/2 + δ) for all integers x, y with y² ≠ x³.
Danilov (1982) gives infinitely many integer pairs with 0 < |x³ - y²| < K √x for a fixed K, which is enough.
One route (from memory, unverified; check every identity yourself): the polynomial identity (z² + 6z + 4)³ - (z² + 1)(z² + 9z + 19)² = -27(2z + 11) (correct it if it is wrong), combined with solutions of z² + 1 = 5w² and a congruence condition that makes x and y integers.
Any other correct construction of an infinite family with |x³ - y²| = O(√x) and y² ≠ x³ is fine.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(danilov):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/danilov` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 75 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
