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

## Phase B: search for a counterexample

Method (`search.c`), exact necessary condition:
- n is an integer value ⇒ A_n ≡ ±c_n (mod q) for every prime q.
- I use q ∈ {2^61 - 1, 4611686018427387847, 4611686017427387867}. All are primes ≡ 3 (mod 4), so q never divides c_n.
- Any n that fails one congruence is rigorously excluded, assuming the code is correct.
- A survivor would need an exact check.
- A_n mod q comes from the recursion (a, b) ↦ (a - n b, b + n a).
- c_n mod q comes from the content formula (Phase A):
  - Sieve 1 + k^2 by the primes p ≡ 1 (mod 4) up to N + 2, with both roots ±r of r^2 ≡ -1 (mod p).
  - Track the exponents V^+_p and V^-_p, and multiply c by p^(increase of the min).
  - The 2-part is 2^floor(o_n/2).
  - A leftover cofactor of 1 + n^2 is a prime P > N + 2 with exponent 1.
    It enters c_n exactly when its partner P - n lies in [1, n - 1].

Validation of the C code against independent exact Python big integers:
- `check_dump.py`: A_n mod q0 and gcd(A_n, B_n) mod q0 agree for every n ≤ 3000 (S = 2^20, 2^24, and 2^25 builds).
- `check_dump_sampled.py`: A_n mod q0 agrees for every n ≤ 20000, and gcd mod q0 agrees at every n divisible by 499 and at n = 20000 (41 points).

Results:
- n ≤ 10^9 (`run_1e9.log`, segment size 2^24): the only survivors are n = 1, 2, 3, 4. So for 5 ≤ n ≤ 10^9, A_n ∤ B_n.
  This is computed, not proved: it relies on the correctness of `search.c`.
- n ≤ 4·10^9 (`run_4e9.log`, segment size 2^25): running; the result goes in the report.
  4·10^9 is about the limit where 1 + k^2 fits in a uint64.

A local obstruction was looked for and not found (on paper):
- 2-adic: Z_n/2^floor(o/2) ≡ i^(t + o/2) (mod 2) when o is even, where t = #{k ≤ n : k ≡ 3 mod 4}.
  An integer value needs this to be ≡ 1 (mod 2).
  But t + o/2 is always even for n ≡ 3, 0 (mod 4), and o is odd for n ≡ 1, 2 (mod 4).
  So the 2-adic condition never fails.
- p-adic for p ≡ 1 (mod 4) only says "Re(Z_n / p^e) is a p-adic unit" when the two sides are unbalanced. It gives no class of n.
- Mod q ≡ 3 (mod 4): Z_n mod q is periodic in n, but c_n mod q is not, so there is no congruence-class obstruction.

Conclusion: the problem is archimedean.
An integer value needs |cos θ_n| = c_n / sqrt(ω_n) exactly, with θ_n = Σ arctan k.

## Phase C: proof attempt

### What a full proof would need (plain mathematics)

Let θ_n = Σ_{k≤n} arctan k, ω_n = ∏(1 + k^2) = A_n^2 + B_n^2, and c_n = gcd(A_n, B_n).
1. A_n | B_n ⇔ |A_n| = c_n. [proved on paper; proved in Lean: `isIntegerValue_iff_gcd_eq_natAbs`]
2. There is an explicit formula for c_n from the factorizations of 1 + k^2 (Phase A). [proved on paper; computed up to 3000]
3. Integer value m = x_n ⇒ ω_n = c_n^2 (1 + m^2), so the squarefree kernel K_n divides 1 + m^2. [proved on paper]
4. Largest-prime argument: let P be a prime factor of 1 + n^2 with P > 2n.
   Then v_P(ω_n) = 1, because the other solutions j of j ≡ ±n (mod P) are P - n > n and n + P > n.
   So P | K_n | 1 + m^2 and |m| ≥ sqrt(P - 1) > sqrt(2n - 1).
   An integer value is therefore large, so θ_n is within about 1/|m| of π/2 (mod π). [proved on paper; this is the mechanism of Ono's theorem, from memory, unverified]
5. MISSING: an inequality |cos θ_n| ≠ c_n / sqrt(ω_n) for every n ≥ 5.
   It would need a lower bound for the distance from θ_n to π/2 + πℤ, a linear form in n logarithms of Gaussian integers (log(1 + k i)), sharp to about exp(-n log n).
   Baker-type bounds for n logarithms lose a factor like C^n in the exponent, which is far too weak.
   [unknown; this is the open core of the problem]
6. MISSING alternative: a local (congruence) obstruction. Phase B shows there is none at 2, none at p ≡ 1 (mod 4), and none from q ≡ 3 (mod 4) classes. [ruled out on paper]

Decision: step 5 is the whole difficulty and I have no idea that gets around it, so I do not try the full proof.
What I formalize instead:
(a) Reduction 1 in Lean.
(b) The conjecture on the finite range 5 ≤ n ≤ 10000, by a Lean-checked computation.

### Finite-range argument (what the Lean proof says, line by line)

Lean file `Solution/TanArctanCheck.lean`, namespace `TanArctanSweep`:
- Step 1, `gaussProd_succ`: Z_{n+1} = Z_n · (1 + (n+1) i). This is `Finset.prod_Icc_succ_top`.
- Step 2, `zrec_eq`: the recursion zrec 0 = (1, 0), zrec (n+1) = (a - (n+1) b, b + (n+1) a) equals (A n, B n).
  The proof is induction, using `Zsqrtd.re_mul` and `Zsqrtd.im_mul` with d = -1.
- Step 3, `checkFrom_sound`: if `checkFrom fuel n a b = true` and zrec n = (a, b), then A_m ∤ B_m for n ≤ m < n + fuel.
  The checker tests `b % a ≠ 0` at each index; `Int.dvd_iff_emod_eq_zero` holds even for a = 0.
- Step 4, `check_to_10000`: `checkFrom 9996 5 190 (-90) = true` by `decide +kernel`, which takes about 300 s.
- `not_isIntegerValue_of_check` and then `Solution.lean`'s `tan_arctan_sum_not_integer_of_le_10000` give:
  ∀ n, 5 ≤ n → n ≤ 10000 → ¬ IsIntegerValue n.

Kernel cost: 2000 → 5 s, 4000 → 30 s, 10000 → 300 s, so it scales like N^2.5.
The overhead is in the kernel, not in GMP. A range of 10^5 by this method is out of reach.
