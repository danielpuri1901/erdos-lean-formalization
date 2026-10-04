# Task: the trivial bound in Green's problem 66

## Goal

`Solution.lean` must contain

```lean
theorem green66_trivial_bound : type_of% @Green66.green_66.variants.trivial_bound
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

Read `IsSumOfTwoSquares` in `FormalConjectures/GreensOpenProblems/66.lean` first.
The statement: there is C > 0 such that every large real X has a natural number n that is a sum of two squares with X - C X^(1/4) ≤ n ≤ X.
Argument: let u = ⌊√X⌋ and v = ⌊√(X - u²)⌋, and take n = u² + v².
Then n ≤ X, X - u² < 2u + 1 ≤ 2√X + 1, and (X - u²) - v² < 2v + 1 ≤ 2√(2√X + 1) + 1, which is at most C X^(1/4) for large X.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(green66):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/green66` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 45 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
