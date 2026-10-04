# Task: the exact floor formula for the number of lattice points in a disc

## Goal

`Solution.lean` must contain

```lean
theorem gauss_circle_exact_form : type_of% @GaussCircleProblem.exact_form_floor
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

The number of integer points in the disc of radius r is 1 + 4 * sum over i of (floor(r^2/(4i+1)) - floor(r^2/(4i+3))).
Read `N` in `FormalConjectures/Wikipedia/GaussCircleProblem.lean` first.
Sketch, from memory, so check every step.
N(r) is 1 plus the sum over 1 <= n <= r^2 of r2(n), the number of ways to write n as a sum of two squares of integers.
Jacobi: r2(n) = 4 (d1(n) - d3(n)), where d1 and d3 count the divisors of n that are 1 and 3 modulo 4.
Summing d1 over n <= x gives the sum over d = 1 mod 4 of floor(x/d), and the same for d3.
The infinite sum has only finitely many nonzero terms, so it is a finite sum.
Look in Mathlib for the two-squares counting formula; if it is not there, it has to be proved, for example through the Gaussian integers.
The branch `origin/run/gausscircle` holds a checked Lean proof of Gauss's bound for the same `N`; its lemmas about the lattice points may help.
If you cannot finish, prove the strongest partial statement you can, write exactly what is missing, and stop.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(gaussexact):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/gaussexact` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 30 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
