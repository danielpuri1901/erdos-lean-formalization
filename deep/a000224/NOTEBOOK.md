# a000224 deep attempt notebook

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
  Q2.0 `2 * a (p^2) = p^2 - p + 2` from `a_prime_pow_even` (j = 1): 2(p+1)a = p³+p+2 = (p+1)(p²−p+2). [open]
  Q2.1 k ≤ 20: 21(p²−p+2)² ≥ 16p⁴ for p ≥ 3 (5p⁴−42p³+105p²−84p+84 ≥ 0). [paper, checked p < 5000]
  Q2.2 k ≥ 17 ⇒ p ≤ 31 (17(p²−p+2)² < 16p⁴ fails for p ≥ 32), and then w ≤ B/δ ≤ 1515; finite check
       F2 over p ≤ 31, 17 ≤ k ≤ 20, w ≤ B/δ: (E) never holds (20 cases, max B/δ = 1515 at p = 31, k = 17).
  Q2.3 k = 16: δ = 4(p−2)(2p²−p+2), B = 4p⁴−8p²+8p−16; (E) ⇒ (2δw − B)² = Disc with
       Disc = 16p⁸ − 32p⁷ + 16p⁶ − 96p³ + 240p² − 192p + 192 = g² − (96p³ − 240p² + 192p − 192), g = 4p⁴ − 4p³.
       For p ≥ 11: (g−1)² < Disc < g² (needs 8p⁴ − 104p³ + 240p² − 192p + 191 > 0), so Disc is not a square.
       For p ∈ {3,5,7}: Disc = 45840, ..., not squares (explicit squeeze). [paper, checked p < 3000 directly]
  Q2.4 k ≤ 15: δ ≥ 4p⁴ − 15A² ≥ p⁴/4 (p⁴ + 30p³ − 75p² + 60p − 60 ≥ p⁴), so w < 16 from δw < B < 4p⁴.
       Reduce (E) mod p: A ≡ 1, δ ≡ B ≡ −k, so p ∣ k·w·(w−1) + 1 ≤ 3151. Finite check F1 over k ≤ 15,
       w ≤ 15, p ∣ kw(w−1)+1: the ONLY solution of (E) is (k, w, p) = (13, 2, 3), i.e. q = 3 = p,
       excluded by q ∤ p². (Brute force over p < 3200 agrees.)
  Q2.5 assemble: conjecture for n = p²q. [open]
  Note: the Diophantine system without q ∤ m has the spurious solution p = q = 3 (n = 27); keep q ≠ p.
- Q3 family pqr: k ≤ 63, bounded by the same method; large finite check (~10⁵ (u,v) pairs). [open, maybe out of reach]
- Summary theorem S: every counterexample n is odd, not a prime power, not a product of two
  primes (hence has ≥ 2 distinct prime factors and Ω(n) ≥ 3). [in progress: worker E, attempt 3]

## 3. Facts

- Exhaustive n ∈ [2, 4·10⁹): 0 mismatches (`sweep/a000224/search.c`, `run_4e9.txt`, 5m20s).
- n = m·q, m odd in [3, 10⁶], q prime ∤ m of any size: 0 hits (`sweep/a000224/family.py`).
- Relaxed semiprime system 2 ≤ u < v ≤ 20000 (no primality): 0 solutions (`relaxed.c`).
- a(p^k) recursion checked against the direct definition in stage 1 for n ≤ 3000 (`search.c`, `direct.py`).
- Small-case check of R4/R5 numbers: a(27) = 11, D = 10 = (3⁴−1)/8.
- R3, R4, R5 checked against the direct definition for all odd p < 60 and p^k ≤ 4·10⁵: 0 failures
  (`deep/a000224/check_recursion.py`).
- Independent family search `deep/a000224/famq.c` (quadratic in w, 128-bit exact, Miller–Rabin on q)
  reproduces stage 1 exactly for m odd ≤ 10⁶: 84,272,330 (m,k) pairs, 78,500 integer roots, 0 hits.
  m odd ≤ 2·10⁶: 186,806,550 pairs, 148,935 roots, 0 hits (`famq_2e6.txt`).

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

## 5. Dead ends

- Blind enumeration beyond 4·10⁹ (a hit needs a modulus ≈ n²/16 to divide n² − 1; heuristically pointless).
- Vieta jumping on the semiprime equation (discriminant is n² itself; circular).
- Nested bounded ∀ with decide +kernel over 32×3721 cases: kernel deep recursion; enumerate a small cofactor.
