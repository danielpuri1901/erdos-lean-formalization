# Task: one good value of F gives infinitely many

## Goal

`Solution.lean` must contain

```lean
theorem increasing_triples_power : type_of% @Arxiv.«1609.08688».maximalLength_pow
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

If F(n) = n^e for some n > 1, then F(m) >= m^e for arbitrarily large m, where F(n) is the longest 2-increasing sequence of triples with entries in 1..n (Gowers and Long, arXiv 1609.08688).
Read `IsIncreasing₂`, `lt₂` and `maximalLength` in `FormalConjectures/Arxiv/1609.08688/sIncreasingrTuples.lean` first.
Sketch, from memory, so check every step.
Product lemma: F(a * b) >= F(a) * F(b).
Take a longest sequence s for a and a longest sequence t for b, and combine them in lexicographic order: the triple number (i, j) has the coordinates (s_i - 1) * b + t_j.
Two triples with different i compare like s_i, and two triples with the same i compare like t_j.
Then F(n^k) >= F(n)^k = (n^k)^e, and n^k is as large as you like.
`maximalLength` is a supremum of a set of natural numbers, so you also need that the set is bounded; the file proves an upper bound you can use.
The branch `origin/run/sqtuples` holds an accepted Lean proof of a related statement about `maximalLength`; its lemmas may help.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(triplespow):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/triplespow` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 15 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
