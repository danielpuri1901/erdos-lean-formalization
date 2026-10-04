# Sweep notes: tanarctan

start: 1791105290 (date -u +%s)

## Phase A: statement

Source: `.lake/packages/formal_conjectures/FormalConjectures/Arxiv/2607.05739/TanArctanSum.lean`,
theorem `Arxiv.«2607.05739».tan_arctan_sum_not_integer`:

    answer(sorry) ↔ ∀ n : ℕ, 5 ≤ n → ¬ IsIntegerValue n

Definitions, read from the Lean source:
- `gaussProd n = ∏ k ∈ Finset.Icc 1 n, ⟨1, (k:ℤ)⟩ : GaussianInt`, which is Z_n = ∏_{k=1}^n (1 + k i). Z_0 = 1.
- `A n = (gaussProd n).re`, `B n = (gaussProd n).im` (both ℤ).
- `IsIntegerValue n := A n ∣ B n` (divisibility in ℤ).
- `x n := (B n : ℚ) / (A n : ℚ)`. The main theorem does not use it.

In my own words: let Z_n = A_n + B_n i = (1+i)(1+2i)...(1+ni). The conjecture says
that for every n ≥ 5, the integer A_n does not divide the integer B_n.
The intended `answer` is `True`.

Edge cases:
- n = 0: Z_0 = 1, A = 1 divides B = 0, so it is an integer value. The `5 ≤ n` hypothesis excludes it.
- A_n = 0: in ℤ, `0 ∣ b ↔ b = 0`. B_n ≠ 0 whenever A_n = 0, because A^2 + B^2 = ∏(1+k^2) > 0.
  So a pole counts as "not an integer value". That is the right reading (see the docstring).
  From memory, unverified: Cilleruelo showed that ∏(1+k^2) is a square only for n = 3.
  If that holds, A_n ≠ 0 for every n, because A_n = 0 would force ω_n = B_n^2.
  Computed: A_n ≠ 0 for every n ≤ 3000.
- No natural-number subtraction, division, sInf or sSup appears in the main statement.

statement check: matches. The Lean statement says exactly what the docstring says, and nothing makes it trivially true or false.
n = 1..4 are integer values (`isIntegerValue_of_le_four` in the source), so the threshold 5 is sharp.

## Structure (my own derivation)

Let c_n = gcd(A_n, B_n), the largest rational integer dividing Z_n in ℤ[i].
- A_n | B_n ⇔ |A_n| = c_n, because c_n | A_n always, and A | B ⇒ A | gcd(A, B).
- 2-part: v_2(1+k^2) = 1 for odd k and 0 for even k, and (1+i)^2 = 2i.
  So v_{1+i}(Z_n) = o_n := #{odd k ≤ n}, and v_2(c_n) = floor(o_n / 2).
- Primes p ≡ 3 (mod 4) never divide 1 + k^2, so they never divide c_n.
- For p ≡ 1 (mod 4), write p = π π̄ and let r be the smaller root of r^2 ≡ -1 (mod p).
  If p | 1 + k^2, then 1 + k i is divisible by exactly one of π, π̄, to the full power v_p(1 + k^2).
  Which one is decided by k mod p ∈ {r, p - r}.
  So v_p(c_n) = min(V_p^+(n), V_p^-(n)), where V^± sums v_p(1 + k^2) over k ≤ n on each side.
- Computed check: this formula equals gcd(A_n, B_n) exactly for every n ≤ 3000 (`repro.py`).
- An integer value means Z_n = A_n (1 + m i) with |A_n| = c_n, so |cos θ_n| = c_n / sqrt(ω_n),
  where θ_n = Σ arctan k and ω_n = ∏(1 + k^2).
  Heuristically, c_n is far smaller than sqrt(ω_n), so θ_n would have to be absurdly close to π/2 (mod π).

## Phase A: reproduction

`python3 repro.py 3000`: x_1..x_10 = 1, -3, 0, 4, -9/19, 105/73, -308/331, 36/43, -423/281, 2387/4511.
These match the problem file.
The only n ≤ 3000 with A_n | B_n are 1, 2, 3, 4.

Decision: a proof of the full conjecture would need Diophantine control of Σ arctan k (mod π).
That is out of reach in 60 minutes.
Plan:
- B: an exact modular filter in C (A_n ≡ ±c_n mod several primes q ≡ 3 mod 4) far beyond 20000.
- C: a Lean proof by `decide +kernel` of the conjecture on a finite range [5, N0], through a computable bridge.
