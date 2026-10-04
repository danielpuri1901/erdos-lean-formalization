# Task: every strong Giuga number is a Carmichael number

## Goal

`Solution.lean` must contain

```lean
theorem strong_giuga_is_carmichael : type_of% @AgohGiuga.agoh_giuga.variants.isStrongGiuga_implies_isCarmichael
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

Every strong Giuga number is a Carmichael number (Giuga, 1950).
Read `IsStrongGiuga` in `FormalConjectures/Wikipedia/AgohGiuga.lean` and the definition of `IsCarmichael` that it uses first.
The branch `origin/run/giuga` of this repository holds a Lean proof, accepted by the checker, that a composite number is strong Giuga exactly when it is Carmichael and a sum condition holds.
Fetch it, copy what you need into `Solution.lean`, and take the first half of that statement.
A strong Giuga number is composite by definition.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(giugacarmichael):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/giugacarmichael` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 15 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.
