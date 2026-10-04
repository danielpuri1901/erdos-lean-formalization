# Task: the value of the generalized Stern sequence A112970 at powers of two

## Goal

`Solution.lean` must contain

```lean
theorem a112970_power_of_two : type_of% @OeisA112970.conjecture1_value
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

For the sequence A112970, a(2^n) = floor(n^2 / 4) + 1.
Read the definition of `a` in `FormalConjectures/OEIS/112970.lean` first.
The source gives the route: a(2^(n+1)) = a(2^n) + a(2^n - 2) for n >= 1, and a(2^m - 2) = floor((m + 1) / 2) for m >= 1.
Prove the two facts by induction from the recurrence a(2k + 1) = a(k), a(2k) = a(k) + a(k - 2), then the claim by induction on n.
Check the small cases by computation before you write Lean.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(a112970):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/a112970` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 20 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
