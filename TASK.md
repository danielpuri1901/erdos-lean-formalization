# Task: a long 2-increasing sequence of triples when n is a square

## Goal

`Solution.lean` must contain

```lean
theorem increasing_triples_square : type_of% @Arxiv.«1609.08688».maximalLength_ge_of_isSquare
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

For a perfect square n there is a 2-increasing sequence of triples with entries in 1..n of length n^(3/2) (Gowers and Long, arXiv 1609.08688).
Read `IsIncreasing₂`, `lt₂` and `maximalLength` in `FormalConjectures/Arxiv/1609.08688/sIncreasingrTuples.lean` first.
No sketch is given here: find a construction of m^3 triples with entries in 1..m^2, where each later triple is larger than each earlier triple in at least two coordinates.
Check your construction by computation for m = 2, 3, 4 before you write Lean.
`maximalLength` is a supremum of a set of natural numbers, so the proof also needs that the set is bounded; the file proves an upper bound you can use.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(sqtuples):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/sqtuples` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 30 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
