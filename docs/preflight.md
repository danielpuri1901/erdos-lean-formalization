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

## Checker on the trivial target

- Green run: https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37027530432 on agent commit `5e8c05f3daa24784dd608ddfef479fee5f51f0a0`; Comparator printed `Your solution is okay!` and the commit status `comparator/trivial` is `success`.
- Comparator `v4.33.0` with its toolchain set to `v4.33.1` builds, exports, and accepts module-system imports; no lean4export change was needed.

## Freeze test

On a throwaway branch, `Challenge.lean` was edited to `theorem challenge_trivial : True := by sorry` and `Solution.lean` proved `True`.
The checker overwrote the challenge with its frozen copy and rejected the solution: `Challenge and solution theorem statement do not match: 'challenge_trivial'`.
Run: https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37028790977 (agent commit `13b56eb29960d4c30080e202534536bb4d831a54`, branch deleted afterwards).
