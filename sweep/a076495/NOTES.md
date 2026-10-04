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
