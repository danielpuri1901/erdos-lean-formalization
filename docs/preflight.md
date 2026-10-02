# Preflight record

## Pins

- formal-conjectures: `df3f12d7bd06feb3f71ae37abae0ca7cb798d9b1` (resolved 2026-10-02 from `df3f12d7bd06`).
- Lean toolchain: `leanprover/lean4:v4.33.1` (same as the formal-conjectures pin).
- Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474` (tag `v4.33.1`), inherited from the formal-conjectures manifest.

## Module system

The formal-conjectures problem files are module files (`module`, `public import`, `@[expose] public section`).
A plain, non-module `Challenge.lean` or `Solution.lean` that says `import FormalConjectures.GreensOpenProblems.«72»` builds without changes (build run 37025309583, 2026-10-02, 338 seconds with the Mathlib cache).
Plan Task 1 step 4 (converting the files to modules) was not needed.

## Axioms of the trivial target

`challenge_trivial` depends on `[propext, Classical.choice, Quot.sound]` even with the proof `Iff.rfl`, because the statement itself uses classical definitions (`sSup`, `Collinear`).
Every audit therefore accepts any subset of the permitted axioms, not only the empty set.
