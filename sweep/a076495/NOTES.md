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

## Phase B: try to break it

### Reduction used to structure the search (proved on paper, later in Lean, see Phase C)

Let x > 0 with σ(x) mod x = 5 and write σ(x) = kx + 5 (k = σ(x) div x). Then x ≥ 6.
- σ(x) odd ⟹ x = m² or x = 2m² (standard; proof in Phase C).
- σ(x) even ⟹ kx odd ⟹ x odd and k odd. k = 1 means σ(x) = x + 5, impossible because 5 is untouchable.
  So k ≥ 3 and σ(x) ≥ 3x + 5 (x is an odd number with abundancy > 3).

So it is enough to search (A) x = m², x = 2m², and (B) odd x with σ(x) > 3x.

### Search A: squares and twice squares (`sq.c`)

Segmented factorization of m; σ(m²) = ∏ (p^(2e+1) − 1)/(p − 1), σ(2m²) = (2^(2a+2) − 1)·σ(u²) for m = 2^a·u, u odd; 128-bit arithmetic.
Self-test with other residues (`./sq 1 100 T`): T=6 finds m=5 (x=25), T=30 finds m=29 (x=841), T=38 finds m=37 (x=1369), T=39 finds 2·9² = 162. These match a(6), a(30), a(38), a(39).
Runs (T=5): m in [1, 10^9), [10^9, 2·10^9), [2·10^9, 3.1·10^9), [3.1·10^9, 4.2·10^9): 0 hits.
So no x = m² with m < 4.2·10^9 (x < 1.764·10^19) and no x = 2m² with m < 4.2·10^9 (x < 3.528·10^19).

### Search B: odd x with σ(x) > 3x (`dfs.c`)

Depth-first search over prime factorizations, primes increasing.
- Node n (a prefix of the factorization) is tested itself.
- Children n·q^e only for q² ≤ L/n (q larger than the primes of n).
- A last prime P with exponent 1 and P² > L/n: σ(nP) = σ(n)(P + 1), and σ(nP) ≡ T (mod nP) holds iff
  P·t = σ(n) − T with t ≡ −σ(n) (mod n), t > 0 (and a mirrored form when σ(n) < T; σ(n) = T has no n for T = 5).
  So P is found from the few t ≤ (σ(n) − T)/P_min in that residue class, then checked with deterministic Miller–Rabin.
- Pruning (mode H=3): stop at n if σ(n)/n · ∏ q/(q−1) over the longest run of consecutive primes q > P(n) with product ≤ L/n is < 3.
  Valid because σ(c)/c < ∏_{q | c} q/(q−1) and c ≤ L/n has at most that many distinct prime factors.

Validation:
- General mode (all x, no pruning, `./dfs 1000000 T 2 0`) against an independent divisor-sum sieve (`cnt.c`), counts of x ≤ 10^6 with σ(x) mod x = T for T = 0..40:
  all agree except T = 0 (sieve 10, DFS 9): the difference is x = 1, which the DFS skips on purpose (σ(1) mod 1 = 0).
- Pruned mode (`./dfs 20000000 T 3 2`, odd x with σ(x) > 2x) against `cnth.c` for T = 0..40: all agree (11 hits in total).
- Pruned mode H=3 finds the odd 3-abundant number 1018976683725 = 3³·5²·7²·11·13·17·19·23·29 (from memory, then checked: σ/x = 3.0205) when T is set to its residue 20872956825 (found as a leaf), and not when L = x − 1.
  It also finds 1018976683725·29 = 29550323828025 (found as a node, residue 707909181525).

Runs (T=5, odd, H=3):
- L = 10^12: 454045 nodes, 0 hits. L = 10^13: 1503693 nodes, 0 hits. L = 10^14: 4780858 nodes, 0 hits.
- L = 4·10^18: 1108720268 nodes, 0 hits (about 1 minute).
- L = 1.764·10^19: 2320375732 nodes, 0 hits.

### Combined computational result (not a proof)

With the reduction (now a Lean theorem), A and B together show: no x < 1.764·10^19 has σ(x) mod x = 5.
Also a plain sieve to 10^7 (`small.c`) found none.

Correction found while writing Phase C: in `dfs.c` the node test `σ(n) > 3n` was done in doubles with no slack.
At x near 10^19, σ(x) = 3x + 5 can round to equality, so a k = 3 node could be skipped.
Fixed (factor 1 − 1e-12 slack, as the pruning tests already had), validated again (same results on all the tests above), and search B rerun to L = 1.764·10^19 (see Phase D for the final count).
The old outputs `dfsB_4e18.out` and `dfsB_1764e19.out` come from the unfixed binary; the rerun is `dfsB_1764e19_fixed.out`.
Remaining float caveat, checked by hand: when the prime list (up to √L) runs out, the boost bound ignores one possible extra prime > √L.
That can only happen when n ≈ 1, where σ(n)/n ≈ 1 is nowhere near 3, so no pruning decision changes.

## Phase C: try to prove it

### Full conjecture

Out of reach. σ(x) = kx + 5 with k = 2 (σ(x) = 2x + 5, x a square or twice a square) is a quasi-perfect-type equation; equations of this kind (e.g. σ(x) = 2x + 1) are famous open problems.
From memory, unverified: Pollack–Pomerance-type results say solutions of σ(n) ≡ a (mod n) are sparse apart from "regular" families n = p·m with m | a and σ(m) = a.
For a = 5 there is no regular family (m | 5 and σ(m) = 5 has no solution: σ(1) = 1, σ(5) = 6), so 5 is a "sporadic" residue, but that gives only density, not nonexistence.

### Proved reduction (paper)

Lemma 1 (5 is untouchable): σ(x) ≠ x + 5 for every x.
- x < 17: direct check.
- x prime: σ(x) = x + 1.
- x ≥ 17 composite: p = minFac(x), p² ≤ x, q = x/p satisfies p ≤ q < x and q ≠ 1, so 1 and q are distinct proper divisors.
  σ(x) = x + 5 means the proper divisors sum to 5, so 1 + q ≤ 5, q ≤ 4, x = pq ≤ q² ≤ 16, contradiction.
  Status: proved on paper, proved in Lean.

Lemma 2: σ(n) odd and n ≠ 0 ⟹ n = m² or n = 2m².
- Write n = 2^k·m with m odd. Suppose m is not a square.
- Work in ZMod 2: σ(n) = Σ_{d | n} d. Involution g on divisors of n: g(d) = m/d if d is odd, g(d) = d if d is even.
  An odd d divides m (coprime to 2^k), m/d is odd, so the terms of d and g(d) are 1 + 1 = 0; for even d the term is 0.
  g(d) ≠ d for odd d, since otherwise m = d·d.
  So the sum is 0 and σ(n) is even (Finset.sum_involution). Contradiction.
- So m = j², and n = (2^i j)² if k = 2i, or n = 2(2^i j)² if k = 2i + 1.
  Status: proved on paper, proved in Lean.

Reduction: x > 0 and σ(x) mod x = 5 ⟹ x = m², or x = 2m², or (x odd and σ(x) ≥ 3x + 5).
- σ(x) = kx + 5 with k = σ(x)/x (Nat.div_add_mod).
- σ(x) odd: Lemma 2.
- σ(x) even: kx is odd, so x and k are odd; k = 1 contradicts Lemma 1; so k ≥ 3.
  Status: proved on paper, proved in Lean.

### Lean (Solution.lean, namespace `A076495Sweep`, builds, no `sorry`; axioms: propext, Classical.choice, Quot.sound)

- `sigma_ne_add_five (x : Nat) : sigma 1 x ≠ x + 5`
- `sq_or_two_sq_of_odd_sigma (n : Nat) (hn : n ≠ 0) (h : Odd (sigma 1 n)) : ∃ m, n = m ^ 2 ∨ n = 2 * m ^ 2`
- `reduction (x : Nat) (hx : 0 < x) (h : sigma 1 x % x = 5) : (∃ m, x = m ^ 2 ∨ x = 2 * m ^ 2) ∨ (Odd x ∧ 3 * x + 5 ≤ sigma 1 x)`
- `a5_zero_or_special : a 5 = 0 ∨ (∃ m, a 5 = m ^ 2 ∨ a 5 = 2 * m ^ 2) ∨ (Odd (a 5) ∧ 3 * a 5 + 5 ≤ sigma 1 (a 5))` (with `a = OeisA76495.a`)
- `small_check : ∀ x, x < 300 → sigma 1 x % x ≠ 5` (`decide +kernel`, a few seconds)

Not attempted in Lean: a lower bound for odd x with σ(x) > 3x (needs at least 8 distinct odd prime factors, since 3/2·5/4·…·19/18 = 2.92 < 3 and adding 23/22 gives 3.06; so x ≥ 3·5·7·11·13·17·19·23 = 111546435).
