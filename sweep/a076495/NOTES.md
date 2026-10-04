# Sweep a076495: no x with sigma(x) mod x = 5

start: 1791104466 (date -u +%s)

## Phase A: understand

### Statement (read from `FormalConjectures/OEIS/76495.lean`)

- `a n := if h : ∃ x, 0 < x ∧ (sigma 1 x : ℕ) % x = n then Nat.find h else 0`
  (classical decidability, `noncomputable`).
- `sigma 1 x` is Mathlib's `ArithmeticFunction.sigma 1`, i.e. `∑ d ∈ x.divisors, d ^ 1`.
  `Nat.divisors 0 = ∅`, so `sigma 1 0 = 0`; irrelevant because of `0 < x`.
- `%` is `Nat.mod`; `x % x`-style edge cases do not matter since `x > 0`.
- `conjecture : a 5 = 0`.

In my words: there is no positive integer x such that the remainder of sigma(x) on division by x is 5.

### Edge cases

- If a witness x exists then `Nat.find h ≥ 1` (it satisfies `0 < x`), so `a 5 ≠ 0`.
  If no witness exists, `a 5 = 0` by the `else` branch.
  So `a 5 = 0 ↔ ¬ ∃ x > 0, σ(x) % x = 5`. No degenerate truth.
- Any witness has x ≥ 6, because `σ(x) % x < x`.
- No natural subtraction, no division, no sInf/sSup.

statement check: matches (the Lean statement says exactly "no positive x with σ(x) mod x = 5").

### Small cases (own code: `small.c`, plain divisor-sum sieve)

`./small 10000000`: a(0..40) =
1, 2, 20, 4, 9, 0, 25, 8, 10, 15, 14, 21, 24, 27, 22, 16, 26, 39, 208, 36, 34, 51, 38, 57, 112, 95, 46, 69, 48, 115, 841, 32, 58, 45, 62, 93, 660, 155, 1369, 162, 44.
This matches the problem file (a(1..15), a(18)=208, a(30)=841).
No x ≤ 10^7 has σ(x) mod x = 5.
