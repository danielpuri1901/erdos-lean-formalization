# Task: a snake in the n-cube has length at most 2^(n-1)

## Goal

`Solution.lean` must contain

```lean
theorem snake_le_two_pow : type_of% @SnakeInBox.snake_upper_bound
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

For n at least 1, an induced path in the n-dimensional cube has at most 2^(n-1) edges (Danzer and Klee, 1967).
Read `Hypercube`, `IsSnakeInGraphOfLength` and `LongestSnakeInTheBox` in `FormalConjectures/Wikipedia/SnakeInTheBox.lean` first.
The length counts edges, and `LongestSnakeInTheBox` is a supremum, so the proof also needs that the set of lengths is bounded.
No sketch is given here: find the argument yourself and check the bound by computation for n = 1, 2, 3, 4 (the true maxima are 1, 2, 4, 7).
Spend at most 10 minutes on a complete paper argument.
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

When the proof builds with no `sorry`, commit with a message that starts with `submit(snakeupper):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/snakeupper` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 30 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
