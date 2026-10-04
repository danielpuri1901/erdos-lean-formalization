# Task: weak Giuga numbers and the sum of reciprocals of prime factors

## Goal

`Solution.lean` must contain

```lean
theorem weak_giuga_iff_sum : type_of% @AgohGiuga.isWeakGiuga_iff_sum_primeFactors
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

A composite number n is a weak Giuga number exactly when the sum of 1/p over its prime factors minus 1/n is a whole number.
Read `IsWeakGiuga` in `FormalConjectures/Wikipedia/AgohGiuga.lean` first, and the other statements about weak Giuga numbers in that file.
Sketch, from memory, so check every step.
For a prime p that divides n, p - 1 divides phi(n), so i^phi(n) is 1 modulo p when p does not divide i and 0 otherwise.
So the sum of i^phi(n) over 0 < i < n is congruent to n - n/p modulo p, and the Giuga condition modulo p says that p divides n/p - 1.
That condition for every prime factor forces n to be squarefree, and for squarefree n it is the same as the condition on the sum of 1/p.
Prime powers that divide n need care: the divisibility by n must be recovered from the conditions modulo each prime.
The branch `origin/run/giuga` holds a checked Lean proof of the matching statement for strong Giuga numbers; you may fetch it and reuse its lemmas.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(weakgiuga):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/weakgiuga` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 30 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
