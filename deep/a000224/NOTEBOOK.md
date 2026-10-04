# a000224 deep attempt notebook

```
result: partial
claim: For every n > 1 the biconditional (n.Prime ∧ n ≠ 2) ↔ n² ≡ 1 [MOD a(n)(a(n)−1)] holds whenever n is even,
  prime, a prime power, or of the form p^e·q with p, q prime and ANY exponent e (this contains pq, p²q, p³q and,
  new in run 2, every p^e q with e ≥ 4) (`A224Deep.conjecture_of_structure'''`). Equivalently
  (`counterexample_structure'''`): every counterexample n is odd, composite, not a prime power, and not p^e·q for
  any e; so it has at least three distinct prime factors, or exactly two distinct prime factors both with exponent
  ≥ 2 (smallest open family: p²q²). The full conjecture (Ordowski) remains open; nothing false was claimed.
lean: Solution.lean imports Solution/A224/*.lean (namespaces A224Sweep, A224Deep); the whole Solution library rebuilt
  from scratch (Solution oleans deleted) with no sorry and only propext, Classical.choice, Quot.sound. Main theorems:
  A224Deep.conjecture_of_structure''', counterexample_structure''' (Summary4.lean); conjecture_pow_mul_prime,
  not_modEq_pow_mul_prime, two_mul_a_pow, q4A_eq, q4_A4 (P4Q.lean); q4_small, q4_k16_small_p, q4_large with the
  kernel checks q4ChkSmall_all, q4ChkK16_all, q4ChkLargeAll_true (P4QCheck.lean); q4_dvd_N_even, q4_dvd_N_odd,
  q4_absF_le, q4_e_bound, q4_k16_p_le, q4_w_bound_large (UniformE.lean); q4_k_le_28, q4_p_le_32, q4_w_le_15,
  q4_k16_w_bound (UniformBounds.lean); q4_k16_e4 (P4QAlg.lean); q4_dvd_F, q4_F_ne_zero, q4_X_le (Uniform.lean).
  Run 1: conjecture_of_structure'', counterexample_structure'' (Summary3.lean); conjecture_prime_pow,
  not_modEq_prime_pow, a_prime_pow_odd, a_prime_pow_even (PrimePow.lean); two_mul_a_prime_pow_succ_succ,
  card_nonunit_squares (Recursion.lean); card_unit_squares (Units.lean); reduction, reduction_core (Reduction.lean);
  conjecture_sq_mul_prime (P2Q.lean, with P2QCheck.lean, P2QAlg.lean); conjecture_cube_mul_prime (P3Q.lean, with
  P3QCheck.lean, P3QAlg.lean). Stage 1: conjecture_of_even, modEq_of_odd_prime, a_prime, a_mul, conjecture_semiprime,
  dvd_of_modEq_mul_prime (Sweep.lean).
computed: exhaustive check of every n < 1.6·10¹⁰ (0 mismatches); every n = m·q with m odd ≤ 10⁷ and q a prime not
  dividing m of ANY size (0 hits); the route-specific equation (E) for p^e q has no solution with k ≥ 17, p ≤ 31,
  e ≤ 40; with k ≤ 15, w ≤ 15, e ≤ 23 only the excluded p = q = 3; with k = 16, p ≤ 2000, e ≤ 8 none. The three Q4
  kernel checks (k ≤ 15: 8,080 (E)-evaluations; k = 16, p ≤ 25, 5 ≤ e ≤ 14: 1,020; k ≥ 17, p ≤ 31, 4 ≤ e ≤ 29,
  w ≤ B/δ: 58,781) are Lean proofs; `deep/a000224/q4_checkers.py` is their Python mirror (same result).
route: Q1 (Lean): a counterexample n = m·q with q a simple odd prime factor gives k with kA² < 4m², w ∣ m²−1 and
  (E) (4m²−kA²)w² + (m²−1) = (4m²−kA)w, w = (q+1)/2, A = a(m). Q4 (Lean, complete): for m = p^e, e ≥ 4, with
  2(p+1)A = pX + c (X = p^e, c = p+2 or 2p+1): X ∣ F := kc²w² − 2k(p+1)cw + 4(p+1)², F ≠ 0, so X ≤ |F|;
  k ≤ 28; k ≤ 15 ⇒ w ≤ 15, p ∣ kw(w−1)+1 or kw(w−2)+4, p ≤ 3151, e ≤ 23 (check 1); k = 16 ⇒ 2w ≤ p+5, e = 4 by the
  degree-16 discriminant squeeze, e ≥ 5 ⇒ p ≤ 26 and e ≤ 14 (check 2); k ≥ 17 ⇒ p ≤ 32, and for X ≥ 262144
  w < 34848 so e ≤ 29 (check 3). Together with e = 1, 2, 3 from run 1 this settles every n = p^e q.
next idea: The smallest open families are p²q² (ω = 2, both exponents ≥ 2) and pqr. For n = X·Y with X = p^e and
  Y = q^f coprime, W = a(Y), the identity n² − 1 = kAW(AW−1) reduced mod X still gives X ∣ F(W) = kc²W² − 2k(p+1)cW
  + 4(p+1)² (the right side X²Y² vanishes mod X), and symmetrically Y ∣ F'(A); but the size argument that made Q4
  finite (X ≤ |F| with w bounded) no longer closes, because W ≈ q^f/2 is unbounded; one needs to combine the two
  divisibilities, or a new bound on k from kA²W² ≈ X²Y². For pqr the Q1 bounding method alone leaves the p = 127
  corner (u = 64, ρ = 63.0039, about 2.6·10⁹ (v,w) pairs for k = 63), which needs a Pell-type analysis in s = v+w,
  x = vw. Either family is a fresh route, not a continuation of Q4.
dead ends: blind enumeration beyond 10¹⁰ (heuristically pointless); Vieta jumping on the semiprime equation; nested
  bounded ∀ with decide +kernel over 10⁵ cases (deep recursion; one Bool over List.range loops of 28,710 cases ran in
  28 s); pqr by the Q1 bounding method alone (the p = 127 corner); a direct uniform-in-e discriminant argument (the
  squeeze polynomial depends on e; Q4 used it only for e = 4 and finite checks elsewhere); the run-1 notebook formula
  F = 4(2cw−p−1)² for k = 16 (wrong: F = 16(cw−p−1)² − 12(p+1)²; the crude bound |F| ≤ kc²w² + 2k(p+1)cw + 4(p+1)²
  replaced it).
confidence: high because every Lean theorem rebuilds from scratch with no sorry and only the standard axioms, the
  statements of the family theorems are the conjecture's biconditional at the stated n, the three finite checks were
  mirrored in Python with the same truncated-Nat semantics before being run in the kernel, and the claim is partial
  by design.
```

start: 1791109086 (date -u +%s); hard stop at 1791123486 (start + 4 h).

## 1. Target

Lean (`FormalConjectures/OEIS/224.lean`, `OeisA224.conjecture`):
```lean
theorem conjecture (n : ℕ) (hn : 1 < n) :
    (n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)]
```
with `a n = if n = 0 then 1 else ((Finset.range n).image (fun k => k ^ 2 % n)).card`
(the number of distinct squares mod n). Final theorem must be stated as
`theorem a000224_deep.{u} : type_of% @OeisA224.conjecture.{u} := ...` (no universes here, so plain
`type_of% @OeisA224.conjecture`).

Working reformulation (n ≥ 2, M = a(n)(a(n)-1) ≥ 2): n is an odd prime ⟺ M ∣ n² − 1.
Forward direction and even n are proved (stage 1). The open content: no odd composite n has
M ∣ n² − 1. This is an OEIS conjecture (Ordowski 2017); a full proof would settle an open problem,
so the realistic goal of this run is to enlarge the Lean-verified families and leave a clean record.

Manager's decision (no questions asked): the route below first formalises the prime-power case
(proved on paper in stage 1), then a general reduction lemma for n = m·q, then (if time allows) the
family p²q or pqr. Searches run in the background in parallel.

## 2. Route

Notation: p odd prime. φ = Nat.totient. Everything new lives in namespace `A224Deep`,
files `Solution/A224/*.lean`, imported by `Solution.lean`.

Stage 1 (namespace `A224Sweep` in `Solution.lean`, all proved in Lean, no sorry):
- L0 even n: `conjecture_of_even`. [proved in Lean]
- L1 odd prime ⇒ congruence: `modEq_of_odd_prime`; `a_prime : a p = (p+1)/2`. [proved in Lean]
- L2 multiplicativity `a_mul` (coprime), bridge `a_eq_card_zmod`. [proved in Lean]
- L3 semiprimes p<q: `conjecture_semiprime` (via `semi_core`, decide +kernel 32×121). [proved in Lean]
- L4 necessary condition `dvd_of_modEq_mul_prime`: q odd prime ∤ m, congruence at m·q ⇒ (q+1)/2 ∣ m²−1. [proved in Lean]

Stage 2 route A (prime powers):
- R1 (unit squares) for odd prime p, j ≥ 1: [proved in Lean: `A224Deep.card_unit_squares`, Solution/A224/Units.lean]
  `2 * (((range (p^j)).filter (¬ p ∣ ·)).image (· ^2 % p^j)).card = p^j - p^(j-1)`.
  Proof: squaring is exactly 2-to-1 on residues coprime to p (fibres {x, p^j − x}), because
  y² ≡ x² ⇒ (y−x)(y+x) ≡ 0 and p cannot divide both factors (else p ∣ 2x).
- R2 (non-unit squares) for p prime, k ≥ 0: [proved in Lean: `A224Deep.card_nonunit_squares`, Solution/A224/Recursion.lean]
  `(((range (p^(k+2))).filter (p ∣ ·)).image (· ^2 % p^(k+2))).card = a (p^k)`.
  Proof: multiplication by p² is a bijection from squares mod p^k onto squares of multiples of p
  mod p^(k+2) (Nat.mul_mod_mul_left).
- R3 (recursion) `2 * a (p^(k+2)) = p^(k+2) - p^(k+1) + 2 * a (p^k)` from R1+R2 and the disjoint
  split of range (p^(k+2)) by p ∣ x. [proved in Lean: `A224Deep.two_mul_a_prime_pow_succ_succ`]
- R4 (closed forms) by induction on j from R3 and `a_prime`, a 1 = 1:
  `2*(p+1) * a (p^(2j+1)) = p^(2j+2) + 2p + 1`, `2*(p+1) * a (p^(2j)) = p^(2j+1) + p + 2`.
  [proved in Lean: `A224Deep.a_prime_pow_odd`, `a_prime_pow_even`, Solution/A224/PrimePow.lean]
- R5 (P3) for k ≥ 2: ¬ (p^k)² ≡ 1 [MOD a(p^k)(a(p^k)−1)].
  k even: a ≡ 1 mod p so p ∣ a−1 ∣ n²−1, but p ∣ n. k odd: D = a−1 has 2(p+1)D = p^(k+1) − 1;
  D ∣ p^(2k) − 1 and D ∣ p^(k+1) − 1 give D ∣ p^(k−1) − 1 (subtract p^(k−1)·(p^(k+1)−1)),
  then D ∣ p² − 1 (subtract p²·(p^(k−1)−1)); but 2(p+1)D ≥ p⁴ − 1 = (p²−1)(p²+1) > 2(p+1)(p²−1)
  so D > p² − 1 ≥ 1, contradiction. [proved in Lean: `A224Deep.not_modEq_prime_pow`]
- R6 conjecture for n = p^k, k ≥ 2 (both sides false). [proved in Lean: `A224Deep.conjecture_prime_pow`]

Stage 2 route B (general reduction, then more families):
- Q1 for n = m·q, q odd prime ∤ m, A = a(m) ≥ 2, w = (q+1)/2 ≥ 2, n² − 1 = k·Aw(Aw−1):
  (i) kA² < 4m², (ii) kA < 4m², (iii) w ∣ m² − 1,
  (iv) (4m² − kA²)·w² + (m² − 1) = (4m² − kA)·w, (v) (4m² − kA²)·w < 4m² − kA.
  Paper: (iv) is the identity n² − 1 = 4m²w² − 4m²w + m² − 1 rearranged; (ii): if kA ≥ 4m² then
  kA² − 4m² ≥ kA(A−1) + (kA − 4m²) and (iv) fails by size; (i): if kA² ≥ 4m² and kA < 4m² then (iv)
  forces (4m²−kA)w < m² and (kA²−4m²)w² < m², so kA > 3.5m² and kA² < 4.25m², i.e. A < 2.
  [proved in Lean: `A224Deep.reduction_core` (pure Diophantine) and `A224Deep.reduction` (with a m,
  (q+1)/2 and the ModEq hypothesis), Solution/A224/Reduction.lean]
- Q2 family n = p²q, p ≠ q odd primes. m = p², 2A = p² − p + 2 (from R4b, j = 1), w = (q+1)/2 ≥ 2.
  Q1 gives k with δ := 4p⁴ − kA² ≥ 1, B := 4p⁴ − kA, (E) δw² + (p⁴−1) = Bw, δw < B. Route, every step
  checked numerically in `deep/a000224/q2_analysis.py` (decision 1791110400):
  Q2.0 `2 * a (p^2) = p^2 - p + 2` from `a_prime_pow_even` (j = 1): 2(p+1)a = p³+p+2 = (p+1)(p²−p+2).
  [proved in Lean: `A224Deep.two_mul_a_sq`, Solution/A224/P2Q.lean]
  Q2.1 k ≤ 20: 21(p²−p+2)² ≥ 16p⁴ for p ≥ 3 (5p⁴−42p³+105p²−84p+84 ≥ 0). [proved in Lean: `q2_k_le_20`]
  Q2.2 k ≥ 17 ⇒ p ≤ 31 (17(p²−p+2)² < 16p⁴ fails for p ≥ 32) [`q2_p_le_31`], and then w ≤ B/δ ≤ 1515; finite check
       F2 over p ≤ 31, 17 ≤ k ≤ 20, w ≤ B/δ: (E) never holds (20 cases, max B/δ = 1515 at p = 31, k = 17).
       [F2 proved in Lean: `A224Deep.q2ChkLarge_all` (decide +kernel, 1 s), unpacked as `q2_large`, Solution/A224/P2QCheck.lean]
  Q2.3 k = 16: δ = 4(p−2)(2p²−p+2), B = 4p⁴−8p²+8p−16; (E) ⇒ (2δw − B)² = Disc with
       Disc = 16p⁸ − 32p⁷ + 16p⁶ − 96p³ + 240p² − 192p + 192 = g² − (96p³ − 240p² + 192p − 192), g = 4p⁴ − 4p³.
       For p ≥ 11: (g−1)² < Disc < g² (needs 8p⁴ − 104p³ + 240p² − 192p + 191 > 0), so Disc is not a square.
       For p ∈ {3,5,7}: Disc = 45840, ..., not squares (explicit squeeze). [proved in Lean: `A224Deep.q2_k16`,
       Solution/A224/P2QAlg.lean, with helper `q2_no_sq_between`]
  Q2.4 k ≤ 15: δ ≥ 4p⁴ − 15A² ≥ p⁴/4 (p⁴ + 30p³ − 75p² + 60p − 60 ≥ p⁴), so w < 16 from δw < B < 4p⁴ [`q2_w_le_15`].
       Reduce (E) mod p: A ≡ 1, δ ≡ B ≡ −k, so p ∣ k·w·(w−1) + 1 ≤ 3151. Finite check F1 over k ≤ 15,
       w ≤ 15, p ∣ kw(w−1)+1: the ONLY solution of (E) is (k, w, p) = (13, 2, 3), i.e. q = 3 = p,
       excluded by q ∤ p². (Brute force over p < 3200 agrees.) [mod-p step proved in Lean: `A224Deep.q2_dvd`;
       F1 proved in Lean: `q2ChkSmall_all` (decide +kernel, 42 s), unpacked as `q2_small`]
  Q2.5 assemble: conjecture for n = p²q. [proved in Lean: `A224Deep.not_modEq_sq_mul_prime`,
  `A224Deep.conjecture_sq_mul_prime` (p ≠ q odd primes), Solution/A224/P2Q.lean]
  Note: the Diophantine system without q ∤ m has the spurious solution p = q = 3 (n = 27); keep q ≠ p.
- Q3 family pqr (2 ≤ u < v < w, m = (2u−1)(2v−1), A = uv, r = 2w−1 the simple prime): k ≤ 63. Analysis
  (decision 1791110900, not attempted in Lean): with ρ = 4m²/A² = 4(2−1/u)²(2−1/v)², k ≤ ρ − 1 gives
  δ ≥ A² and w < ρ < 64, a finite check. The critical k = ⌊ρ⌋ gives δ = 4m² mod A² and w < 4m²/δ; for
  fixed u and v → ∞, ρ → ρᵤ = 16(2−1/u)² and w ≲ ρᵤ/frac(ρᵤ). This is small except when ρᵤ is just above
  an integer: u = 64 (p = 127), ρᵤ = 63.0039, frac = 1/256: then k = 63, v ∈ [16130, 32512], w ≤ B/δ with
  about 2.6·10⁹ (v,w) pairs (`q3_analysis`, below) — far beyond a kernel check; the exact equation there is a
  pair of simultaneous Pell-type conditions in s = v+w, x = vw. (u = 32 and u = 128 give p = 63, 255, not
  prime.) Computationally the corner is covered: famq (m ≤ 10⁷) includes pq = 127·q for q ≤ 65025.
  Verdict: pqr is out of reach for this run; the p = 127 corner is the obstruction to record.
- Q3' family p³q (decision 1791111600, done): same route as Q2 with 2A = p³ − p² + p + 1 (R4a, j = 1), X = p³:
  k ≤ 24 [`q3_k_le_24`]; k ≥ 17 ⇒ p ≤ 32 [`q3_p_le_32`] and w ≤ B/δ ≤ 336, finite check [`q3ChkLarge_all`, `q3_large`];
  k = 16 ⇒ (2δw − B)² = Disc(p) of degree 12 with (g−1)² < Disc < g² for g = 4p⁶ − 4p⁵ + 4p⁴ − 4p³, p ≥ 12,
  and a table for p ≤ 11 [`q3_k16`]; k ≤ 15 ⇒ w ≤ 15 [`q3_w_le_15`] and, since A ≡ (p+1)/2 (mod p),
  p ∣ k·w·(w−2) + 4 ≤ 2929 [`q3_dvd`], finite check with no solution at all [`q3ChkSmall_all`, `q3_small`].
  Result: `A224Deep.conjecture_cube_mul_prime` (Solution/A224/P3Q.lean). [proved in Lean]
- Q4 (run 1: idea and building blocks; run 2: PROVED IN LEAN for every e ≥ 4, see 'Run 2' below) uniform family p^e q, X = p^e, 2(p+1)A = pX + c with
  c = p+2 (e even) or 2p+1 (e odd) (R4). From n² − 1 = k·a(a−1): kA²w² − kAw + 1 = X²(2w−1)²; multiplying by
  4(p+1)² and reducing mod X gives X ∣ F := k c² w² − 2k(p+1)c w + 4(p+1)² = k(cw − p − 1)² + (4−k)(p+1)²,
  and F ≠ 0 for k ≠ 4 (else k(k−4) would be a square), F > 0 for k = 4. So p^e ≤ F: once w is bounded, e is
  bounded. k ≤ 15 ⇒ w ≤ 15 uniformly; k ≥ 17 ⇒ p ≤ 32 and (for e ≥ 3) w ≲ 400; k = 16 ⇒ F = 4(2cw−p−1)² so
  p^⌈e/2⌉ ≤ 2cw ≈ 2p², i.e. e ≤ 4 (e ≤ 7 for p ≤ 11): only the discriminant squeeze for e ∈ {3, 4} remains
  as genuinely new algebra. Estimated 5–6 worker slots (3 attempts), which the 10-attempt budget does not
  allow in this run. Numerics (`deep/a000224/q4_analysis.py`): the identity 4(p+1)²(kA²w² − kAw + 1) ≡ F
  (mod X) holds (3000 random cases); F = k(cw−p−1)² + (4−k)(p+1)² exactly; k(k−4) is a square only for k = 4;
  for e ≥ 4: k ≤ 28, k ≥ 17 ⇒ p ≤ 31 with max B/δ = 3027, k = 16 ⇒ w ≤ (p+3)/2 and e ≤ 8 (e ≤ 4 for p ≥ 29),
  k ≤ 15 ⇒ F ≤ 1.4·10¹¹ so e ≤ 23; direct search for p ≤ 31, e ∈ 4..12, all k, w ≤ B/δ: no solution of (E).
  Lean so far (attempt 9): `q4_dvd_F`, `q4_F_ne_zero`, `q4_X_le` (Solution/A224/Uniform.lean). Attempt 10 (running):
  `UniformBounds.lean` (k ≤ 28; k ≥ 17 ⇒ p ≤ 32; k ≤ 15 ⇒ w ≤ 15; k = 16 ⇒ 2w ≤ p + 5 for X ≥ p⁴) and
  `P4QAlg.lean` (k = 16, e = 4: 2A = p⁴ − p³ + p² − p + 2, Disc of degree 16 with coefficients
  [192, −192, 240, −288, 336, −192, 144, −96, 0, 0, 16, −32, 48, −64, 48, −32, 16] (low→high),
  g = 4p⁸ − 4p⁷ + 4p⁶ − 4p⁵, (g−1)² < Disc < g² for p ≥ 12, table for p ≤ 11). What would remain for a
  complete Q4: the mod-p reduction of F (F ≡ 4(kw(w−1)+1) or kw(w−2)+4 mod p), the finite checks over e
  (k ≤ 15: 6,028 cases; k ≥ 17: ~90,000 cases; k = 16, e ∈ 5..8, p ≤ 29), and the assembly through `reduction`
  with m = p^e (needs `a (p^e)` from R4a/R4b in the form 2(p+1)A = pX + c).
- Summary theorem S: every counterexample n is odd, not a prime power, not a product of two
  primes (hence has ≥ 2 distinct prime factors and Ω(n) ≥ 3). [proved in Lean:
  `A224Deep.counterexample_structure`, and its contrapositive `conjecture_of_structure`, Solution/A224/Summary.lean;
  extended with the p²q clause in `counterexample_structure'` (Summary2.lean) and with the p³q clause in
  `counterexample_structure''` / `conjecture_of_structure''` (Summary3.lean)]

## 3. Facts

- Exhaustive n ∈ [2, 4·10⁹): 0 mismatches (`sweep/a000224/search.c`, `run_4e9.txt`, 5m20s).
- Exhaustive n ∈ [4·10⁹, 10¹⁰): 0 mismatches (same `search.c`, copied to `deep/a000224/search.c`;
  `run_4e9_7e9.txt`, `run_7e9_1e10.txt`, two background processes, about 15 min each). So every n < 10¹⁰ is checked.
- Exhaustive n ∈ [10¹⁰, 1.6·10¹⁰): 0 mismatches (`run_1e10_13e9.txt`, `run_13e9_16e9.txt`). Every n < 1.6·10¹⁰ is checked.
- Uniform-route record (`q4_search.py`, exact): (E) for n = p^e q has no solution with k ≥ 17, p ≤ 31 odd, e ≤ 40,
  w ≤ B/δ (87,459 cases); with k ≤ 15, w ≤ 15, p prime ∣ N(k,w), e ≤ 23 the only solution is (p,e,k,w) = (3,2,13,2),
  i.e. q = p = 3 (6,028 cases); with k = 16, p ≤ 2000 odd, e ≤ 8, w ≤ (p+5)/2: none (3.5·10⁶ cases).
- n = m·q, m odd in [3, 10⁶], q prime ∤ m of any size: 0 hits (`sweep/a000224/family.py`).
- Relaxed semiprime system 2 ≤ u < v ≤ 20000 (no primality): 0 solutions (`relaxed.c`).
- a(p^k) recursion checked against the direct definition in stage 1 for n ≤ 3000 (`search.c`, `direct.py`).
- Small-case check of R4/R5 numbers: a(27) = 11, D = 10 = (3⁴−1)/8.
- R3, R4, R5 checked against the direct definition for all odd p < 60 and p^k ≤ 4·10⁵: 0 failures
  (`deep/a000224/check_recursion.py`).
- Independent family search `deep/a000224/famq.c` (quadratic in w, 128-bit exact, Miller–Rabin on q)
  reproduces stage 1 exactly for m odd ≤ 10⁶: 84,272,330 (m,k) pairs, 78,500 integer roots, 0 hits.
  m odd ≤ 2·10⁶: 186,806,550 pairs, 148,935 roots, 0 hits (`famq_2e6.txt`).
  m odd ≤ 10⁷ (q prime ∤ m of ANY size): 1,170,099,673 pairs, 664,581 integer roots, 0 hits (`famq_1e7.txt`).
  This covers n = m·q for every odd m ≤ 10⁷ with a prime q ∥ n, in particular p²q for p ≤ 3162 and pqr
  for pq ≤ 10⁷ (q the largest prime), with the third prime unbounded.
- Q2 route checks (`q2_analysis.py`): Q2.1 holds for 3 ≤ p < 5000; Q2.2's bound p ≤ 31 holds for p < 5000;
  the 20 finite (p,k) cases of Q2.2 have no integer root w; the only (E)-solution with k ≤ 15, w ≤ 15,
  p ∣ kw(w−1)+1 is (13, 2, 3) (brute force over p < 3200 agrees); k = 16: isqrt(Disc) = 4p⁴−4p³−1 or −2
  for the tested p and no solution of (E) with p < 3000; the mod-p identity was checked on 2000 random triples.

## 4. Attempts

1. Items R1 (worker A) and R2+R3 (worker B), in parallel. Both: proved-in-lean, first build passed.
   Files: Solution/A224/Units.lean, Solution/A224/Recursion.lean. Manager check: merged (stub R1 in
   Recursion.lean deleted, `import Solution.A224.Units` added), `lake build Solution` passes, grep finds
   no sorry/admit/axiom/native_decide, `#print axioms` on all three: propext, Classical.choice, Quot.sound.
   Also moved the stage 1 content of Solution.lean unchanged into Solution/A224/Sweep.lean so that
   submodules can import it. Minutes used: about 4 (workers) + 6 (manager). Wall clock so far: 10 min.
2. Items R4+R5+R6 (worker C) and Q1 (worker D), in parallel. Both: proved-in-lean, first build passed.
   Files: Solution/A224/PrimePow.lean, Solution/A224/Reduction.lean. Manager check: imported into
   Solution.lean, `lake build Solution` passes, grep finds no sorry/admit/axiom/native_decide/
   implemented_by/unsafe in Solution/A224, `#print axioms` on all six theorems: propext,
   Classical.choice, Quot.sound. Worker C notes for LESSONS: `Nat.dvd_sub'` is gone, use `Nat.dvd_sub`;
   `Nat.Coprime.dvd_of_dvd_mul_left` takes `p ∣ 2 * (A - 1)` directly. Minutes: 4 + 3 (workers), 5 (manager).
   Wall clock so far: 20 min. Prime powers (stage 1's P3) are now in Lean.
3. Item S (worker E): proved-in-lean, first build passed. File: Solution/A224/Summary.lean. Manager check:
   imported into Solution.lean, `lake build Solution` passes, no sorry/admit/axiom/native_decide,
   `#print axioms` on both theorems: propext, Classical.choice, Quot.sound. Minutes: 2 (worker), 3 (manager).
   Wall clock so far: 25 min. Decision: go for the p²q family (route Q2 above), two workers: F = the two
   finite checks (F1 for Q2.4, F2 for Q2.2), G = Q2.0, Q2.3 (k = 16 discriminant) and the mod-p lemma of Q2.4.
4. Items F (finite checks F1, F2; worker F) and G (q2_dvd, q2_k16; worker G), in parallel. Both proved-in-lean,
   first build passed. Files: Solution/A224/P2QCheck.lean, Solution/A224/P2QAlg.lean. Manager check: imported
   into Solution.lean, `lake build Solution` passes, no sorry/admit/axiom/native_decide; `#print axioms`:
   q2_small, q2_large: [propext, Quot.sound]; q2_dvd, q2_k16: [propext, Classical.choice, Quot.sound];
   no Lean.ofReduceBool. Worker F timing: q2ChkSmall_all 42 s kernel, q2ChkLarge_all 1 s. Worker G: `hw` unused
   in q2_k16 (the k = 16 equation has no solution for any w). Minutes: 4 + 4 (workers), 4 (manager).
   Wall clock so far: 34 min. Next: H assembles Q2.0, Q2.1, Q2.2, Q2.4 bounds and the theorem for n = p²q.
5. Item Q2.5 assembly (worker H): proved-in-lean, first build passed. File: Solution/A224/P2Q.lean. Manager check:
   imported into Solution.lean, `lake build Solution` passes, no sorry/admit/axiom/native_decide,
   `#print axioms conjecture_sq_mul_prime`: propext, Classical.choice, Quot.sound. Minutes: 2 (worker), 3 (manager).
   Wall clock so far: 42 min. The family p²q is done. Decision: next family p³q by the same route
   (numerics in `deep/a000224/q3cube_analysis.py`: k ≤ 24; k ≥ 17 ⇒ p ≤ 32 and max B/δ = 336; k ≤ 15 ⇒ w ≤ 15,
   mod p gives p ∣ kw(w−2)+4 (A ≡ (p+1)/2 mod p), finite check has NO solution at all; k = 16 ⇒ discriminant squeeze
   with g = 4p⁶ − 4p⁵ + 4p⁴ − 4p³, isqrt(Disc) = g − 1 for large p). Workers I (summary + p²q clause) and
   J (p³q finite checks) run now; then K (p³q algebra) and L (assembly). Longer-term idea recorded in section 2:
   a uniform treatment of p^e q via X ∣ F (see Q4).
6. Item S' (worker I): proved-in-lean. File: Solution/A224/Summary2.lean (`counterexample_structure'`,
   `conjecture_of_structure'`, now also excluding n = p²q). Manager check: imported into Solution.lean, build
   passes, no sorry/admit/axiom/native_decide, `#print axioms`: propext, Classical.choice, Quot.sound.
   Worker note: `Nat.odd_pow.mp` does not exist here; use `Nat.odd_mul` after `pow_two`. Minutes: 2 + 3.
   Wall clock so far: 47 min. Worker J (p³q finite checks) still running; K (p³q algebra) launched now.
7. Item p³q finite checks (worker J): proved-in-lean. File: Solution/A224/P3QCheck.lean (`q3ChkSmall_all`
   36 s kernel, `q3ChkLarge_all` 1 s; unpacked `q3_small`, `q3_large`). Manager check: imported, build passes,
   no sorry/admit/axiom/native_decide, `#print axioms`: propext, Quot.sound (no ofReduceBool). Minutes: 3 + 3.
   Wall clock so far: 50 min. K (p³q algebra) running; L (p³q assembly, with stubs for K's two lemmas) launched now.
8. Items p³q algebra (worker K: `q3_dvd`, `q3_k16` with helpers `q3_disc_large`, `q3_disc_small`,
   Solution/A224/P3QAlg.lean) and p³q assembly (worker L: `two_mul_a_cube`, `q3_k_le_24`, `q3_p_le_32`,
   `q3_w_le_15`, `not_modEq_cube_mul_prime`, `conjecture_cube_mul_prime`, Solution/A224/P3Q.lean). Both
   proved-in-lean. K note: one monolithic proof of q3_k16 hit the heartbeat limit (nlinarith on degree-12
   bounds); splitting the large-p and small-p discriminant cases into helper lemmas with explicit `ring`
   identities fixed it. Manager merge: deleted the two stubs in P3Q.lean, added `import Solution.A224.P3QAlg`;
   the cut also removed L's helper `q3_two_mul_half`, which I re-proved (7 lines). `lake build Solution` passes,
   no sorry/admit/axiom/native_decide anywhere in Solution/A224, `#print axioms conjecture_cube_mul_prime`:
   propext, Classical.choice, Quot.sound. Minutes: 4 + 4 (workers), 6 (manager). Wall clock so far: 56 min.
   The family p³q is done. Attempt 9 (running): N = summary theorem with the p³q clause; M = Lean building
   blocks of the uniform route Q4 (`q4_dvd_F`, `q4_F_ne_zero`, `q4_X_le`), for the next run.
9. Items Q4 blocks (worker M: `q4_dvd_F`, `q4_F_ne_zero`, `q4_X_le`, Solution/A224/Uniform.lean) and S''
   (worker N: `counterexample_structure''`, `conjecture_of_structure''` with the p²q and p³q clauses,
   Solution/A224/Summary3.lean). Both proved-in-lean, first build. Manager check: imported, `lake build Solution`
   passes, no sorry/admit/axiom/native_decide, `#print axioms`: propext, Classical.choice, Quot.sound for all five.
   M note: `hA1 : 1 ≤ A` in q4_dvd_F is unused (kA ≤ kA² holds for A = 0 too). Minutes: 2 + 2 (workers), 4 (manager).
   Wall clock so far: 60 min. Decision for the last allowed attempt (10): two reusable Q4 pieces, O = the e ≥ 4
   bounds (k ≤ 28, k ≥ 17 ⇒ p ≤ 32, k ≤ 15 ⇒ w ≤ 15, k = 16 ⇒ 2w ≤ p + 5) and P = the k = 16, e = 4 discriminant
   squeeze (the only infinite-family algebra left in Q4). Then stop: the 10-attempt budget is the binding limit.
10. Items Q4 bounds (worker O: `q4_k_le_28`, `q4_p_le_32`, `q4_w_le_15`, `q4_k16_w_bound`,
    Solution/A224/UniformBounds.lean) and the k = 16, e = 4 squeeze (worker P: `q4_k16_e4` with helpers
    `q4_disc_large`, `q4_disc_small`, `q4_two_mul_half`, Solution/A224/P4QAlg.lean). Both proved-in-lean.
    O note: lemma 4 hit the heartbeat limit with nlinarith; linarith with explicit product hints fixed it.
    Manager check: imported into Solution.lean; the WHOLE Solution library rebuilt from scratch (oleans deleted)
    in 2m04s with no errors; grep over Solution.lean and Solution/A224 finds no sorry/admit/axiom/native_decide/
    implemented_by/unsafe; `#print axioms` on the 18 main theorems (scratch file importing `Solution`): only
    propext, Classical.choice, Quot.sound. Minutes: 5 + 3 (workers), 6 (manager). Wall clock: 69 min.
    Ten attempts are logged: stop.

## Run 2 (continuation, 2026-10-04): finish Q4

start: 1791133370 (date -u +%s); limits of this run: at most 5 attempts (11..15), at most 90 minutes (hard stop 1791138770),
stop when Q4 is proved in Lean. Manager decisions (no questions asked):

- Correction to the Q4 idea above: for k = 16, F = 16(cw−p−1)² − 12(p+1)², NOT 4(2cw−p−1)². The e-bound still follows
  from the crude estimate |F| ≤ k c² w² + 2k(p+1)cw + 4(p+1)²: with 2w ≤ p+5 and c ≤ 2p+1, p⁵ ≤ X ≤ |F| ≤ G(p) :=
  16p⁴ + 208p³ + 776p² + 704p + 184 fails for p ≥ 27, so e ≥ 5 forces p ≤ 26, and then |F| ≤ 10,802,196 < 3¹⁵ gives e ≤ 14.
- k ≤ 15: w ≤ 15 (in Lean), p ∣ N(e,k,w) with N = kw(w−1)+1 (e even) or kw(w−2)+4 (e odd) from p ∣ X ∣ F and
  F ≡ 4N resp. N (mod p); so p ≤ 3151 and |F| ≤ 143,061,270,991 < 3²⁴, e ≤ 23.
- k ≥ 17: k ≤ 28, p ≤ 32 (in Lean). New: δ > 0 forces kp² < 16(p+1)², so 4(p+1)²δ = (16(p+1)²−kp²)X² − 2kpcX − kc²
  ≥ X² − 116480X − 118300 ≥ X²/2 for X ≥ 262144, hence w < 32(p+1)² ≤ 34848 and |F| < 3³⁰, e ≤ 29;
  for X < 262144, e ≤ 11 directly.
- Three Bool finite checks (Python mirror with exact truncated-Nat semantics, all odd p not only primes,
  `deep/a000224/q4_checkers.py`): k ≤ 15 (8,080 (E)-evaluations), k = 16 with p ≤ 25, 5 ≤ e ≤ 14 (1,020),
  k ≥ 17 with p ≤ 31, 4 ≤ e ≤ 29, w ≤ B/δ (58,781; max B/δ = 3027): no solution anywhere.
- Plan: attempt 11 = two parallel workers, Q = `Solution/A224/P4QCheck.lean` (definitions q4c, q4A, q4N, q4E and the
  three checks, unpacked as `q4_small`, `q4_k16_small_p`, `q4_large`), R = `Solution/A224/UniformE.lean`
  (`q4_dvd_N_even`, `q4_dvd_N_odd`, `q4_absF_le`, `q4_e_bound`, `q4_k16_p_le`, `q4_w_bound_large`).
  The manager drafts the assembly `P4Q.lean` (`two_mul_a_pow`, `q4A_eq`, `q4_A4`, `not_modEq_pow_mul_prime`,
  `conjecture_pow_mul_prime`) and `Summary4.lean` (clause `¬ ∃ p q e, p.Prime ∧ q.Prime ∧ n = p^e * q`) meanwhile.

### Attempts of run 2

11. Items Q (worker: finite checks, `Solution/A224/P4QCheck.lean`) and R (worker: bound lemmas,
    `Solution/A224/UniformE.lean`), in parallel. Q: proved-in-lean, first build; definitions `q4c`, `q4A`, `q4N`, `q4E`,
    checks `q4ChkSmall_all` (49 s kernel), `q4ChkK16_all` (9 s), `q4ChkLargeAll_true` (one Bool over 33×30×29, 28 s,
    about 4 GB), unpacked as `q4_small`, `q4_k16_small_p`, `q4_large`; worker reports `#print axioms`: propext, Quot.sound.
    Manager check of Q: the three unpacked statements and the three definitions are character-for-character the ones in
    the brief (script diff); forbidden-word grep empty. Meanwhile the manager drafted the assembly against sorry-stubs of
    the Q and R statements (scratch file, `lake env lean`: only the stub sorries), and wrote `P4Q.lean` and `Summary4.lean`.
    R: proved-in-lean, first build; all six lemmas, statements character-for-character as briefed (script diff);
    worker notes: `Nat.Coprime p 4` from `Nat.gcd_rec` and p % 4 ∈ {1,3}; `convert h using 1` after `dvd_sub` leaves a
    side goal `Int.instDvd = semigroupDvd`, closed by `rfl`; `hodd` unused in `q4_dvd_N_odd` (kept for the statement).
    Manager: added `import Solution.A224.P4Q`, `import Solution.A224.Summary4`; `lake build Solution` passed (29 s on top
    of the workers' oleans); forbidden-word grep over Solution.lean and Solution/A224 empty; `#print axioms` on the 16
    main theorems: propext, Classical.choice, Quot.sound (the three check theorems: propext, Quot.sound; no
    Lean.ofReduceBool). Committed and pushed (8f52055). Then the Solution oleans were deleted and the library rebuilt
    from scratch (log `deep/a000224/build_scratch.log`). Minutes: 4 + 5 (workers), about 20 (manager, including the
    assembly draft). Wall clock of run 2 at the push: 16 min. Q4 is proved in Lean: stop (the run's stop condition).

## 5. Dead ends

- Blind enumeration beyond 4·10⁹ (a hit needs a modulus ≈ n²/16 to divide n² − 1; heuristically pointless).
- Vieta jumping on the semiprime equation (discriminant is n² itself; circular).
- Nested bounded ∀ with decide +kernel over 32×3721 cases: kernel deep recursion; enumerate a small cofactor.
