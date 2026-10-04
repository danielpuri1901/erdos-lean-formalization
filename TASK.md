# Task: Giuga's characterisation of strong Giuga numbers

## Goal

`Solution.lean` must contain

```lean
theorem strong_giuga_iff : type_of% @AgohGiuga.isStrongGiuga_iff
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

A composite number is a strong Giuga number exactly when it is a Carmichael number and the sum of 1/p over its prime factors minus 1/a is a whole number (Giuga, 1950).
Read `IsStrongGiuga` in `FormalConjectures/Wikipedia/AgohGiuga.lean` and the definition of `IsCarmichael` that it uses first.
Sketch, from memory, so check every step.
For a prime p that divides a, the sum of i^(a-1) over 0 < i < a is congruent modulo p to (a/p) times the sum of i^(a-1) over 0 < i < p.
The sum of i^k over 0 < i < p is -1 modulo p when p - 1 divides k, and 0 modulo p otherwise.
So the Giuga condition modulo p gives that p - 1 divides a - 1 and that p divides a/p - 1; the second one gives that a is squarefree.
Korselt's criterion turns "squarefree and p - 1 divides a - 1 for every prime factor" into the Carmichael property, and "p divides a/p - 1 for every prime factor" is the same as the condition on the sum of 1/p.
The same file may already hold lemmas for the weak Giuga case; use them.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(giuga):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/giuga` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 40 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
