# Danilov target: notes

## Statement (checked in `FormalConjectures/Wikipedia/Hall.lean`)

`danilov (δ : ℝ) (h : δ > 0) : ¬ HallConjectureExp (2⁻¹ + δ)`, where
`HallConjectureExp e := ∃ C > 0, HallIneq C e` and
`HallIneq C e := ∀ x y : ℤ, y ^ 2 ≠ x ^ 3 → |y ^ 2 - x ^ 3| > C * (|x| : ℝ) ^ e`.
So for every C > 0 we must exhibit integers x, y with y² ≠ x³ and |y² - x³| ≤ C |x|^(1/2+δ).
Edge cases (x = 0, x < 0, real power of 0) do not matter: our x is a positive integer.

## Construction (identity checked numerically at 11 points, degree 6, so it is exact)

(z² + 6z + 4)³ - (z² + 1)(z² + 9z + 19)² = -27(2z + 11).

If z² + 1 = 5w², put x = 5(z² + 6z + 4), y = 25 w (z² + 9z + 19). Then
x³ - y² = 125[(z² + 6z + 4)³ - 5w²(z² + 9z + 19)²] = -3375(2z + 11).
No congruence condition is needed: scaling by 5 keeps x, y integral.
For z ≥ 1: y² - x³ = 3375(2z + 11) ≠ 0 and ≤ 43875 z, and x ≥ z², so √x ≥ z.

Pell: (2, 1) solves z² - 5w² = -1, and (z, w) ↦ (9z + 20w, 4z + 9w) preserves it and increases z.
So for every N there is a solution with z ≥ N.

## Analysis

|x|^(1/2+δ) = √x · x^δ ≥ z · x^δ. Since t^δ → ∞, pick M with t^δ ≥ 43875/C for t ≥ M,
then pick a Pell solution with z ≥ max(M, 1); x ≥ z ≥ M, so C |x|^(1/2+δ) ≥ 43875 z ≥ |y² - x³|.

## Plan

1. `pell_exists : ∀ N : ℕ, ∃ z w : ℤ, N ≤ z ∧ 1 ≤ w ∧ z^2 + 1 = 5 w^2` (induction).
2. `key_identity` (by `linear_combination`).
3. Real-analysis wrap-up in `hall_danilov`.

## Decisions

- Use the scaled family (x = 5(...)) rather than a congruence condition: simpler, same O(√x) bound.

## Status

`Solution.lean` proves `hall_danilov` with no `sorry`; `#print axioms` shows only propext, Classical.choice, Quot.sound.
Submitted as commit 7db3bbc; `comparator/danilov` reported success ("Your solution is okay!") at 18:44 UTC on 2026-10-04.
