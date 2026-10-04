# Task: the integer complexity of 3^n is 3n

## Goal

`Solution.lean` must contain

```lean
theorem complexity_of_three_pow : type_of% @Mathoverflow75792.complexity_three_pow
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

The least number of ones needed to write 3^n with addition and multiplication is 3n (Selfridge).
Read `Reachable` and `complexity` in `FormalConjectures/Mathoverflow/75792.lean` first; the file already proves `Reachable (3 ^ n) (3 * n)`.
Sketch, from memory, so check every step.
Key lemma: if `Reachable m k` then m^3 <= 3^k, by induction on `Reachable`.
The product case is direct.
The sum case uses a + b <= a * b when both are at least 2.
When one summand is 1 and the other is b: for b >= 3 use (b + 1)^3 <= 3 * b^3, and treat b = 1 and b = 2 by hand with the induction hypothesis.
Then (3^n)^3 = 3^(3n) <= 3^k gives 3n <= k.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(intcomplexity):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/intcomplexity` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 20 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
