# a000224 sweep notes

start: 1791105350 (date -u +%s)

## Phase A: statement

Lean (`FormalConjectures/OEIS/224.lean`, `OeisA224.conjecture`):
for `n : ℕ`, `1 < n`: `(n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)]`.

Definitions, read from the source:
- `a n = if n = 0 then 1 else ((Finset.range n).image (fun k => k ^ 2 % n)).card`,
  i.e. the number of distinct values of k^2 mod n for 0 ≤ k < n.
- `Nat.ModEq m x y` is `x % m = y % m`. With m = 0 it means x = y.
- `a n - 1` is natural-number subtraction.

In my words: for n ≥ 2, n is an odd prime exactly when a(n)(a(n)-1) divides n^2 - 1.

Edge cases:
- For n ≥ 2 the image contains 0 (k=0) and 1 (k=1), and 0 ≠ 1 mod n, so a n ≥ 2.
  So `a n - 1 ≥ 1` (no truncation) and the modulus a(a-1) ≥ 2 and is even.
  The modulus-0 case never occurs for n ≥ 2.
- n = 2: a = 2, modulus 2, 4 % 2 = 0 ≠ 1. Both sides false. OK.
- `n ≠ 2` is needed: 2 is excluded on the left, and the right side is false at 2.
- n even (any): n^2 even, modulus even, so n^2 % M is even while 1 % M = 1. Right side false,
  left side false. The even case is trivial.

statement check: matches. The Lean statement says what the docstring says.
No trivial truth or falsity: odd composites are the real content.

Small cases reproduced: `direct.py` (direct definition) gives a(1..15) = 1,2,2,2,3,4,4,3,4,6,6,4,7,8,6
and 0 mismatches of the biconditional for n = 2..4000. Matches the problem file.

`search.c` (segmented sieve, a(n) multiplicative with the prime-power recursion below) agrees with
direct computation of a(n) for n = 2..3000, and gives 0 mismatches for n < 10^7 (0.7 s).

Prime-power recursion used (proved on paper, standard): for odd p,
a(1)=1, a(p)=(p+1)/2, a(p^k) = phi(p^k)/2 + a(p^{k-2}) for k ≥ 2
(units give phi/2 squares; non-units x = p y give p^2 * (y^2 mod p^{k-2})).
For p = 2: a(2)=2, a(4)=2, a(2^k) = 2^{k-3} + a(2^{k-2}) for k ≥ 3. a is multiplicative (CRT).

## Phase B: searches (all exact integer arithmetic)

- `search.c`, exhaustive, every n in [2, 10^7): 0 mismatches of the biconditional (0.7 s).
  a(n) cross-checked against the direct definition for n = 2..3000 (0 disagreements).
- `search.c`, exhaustive, every n in [2, 4*10^9): see result line below (run in background).
- `family.py 1000000`: every n = m*q with m odd, 3 ≤ m ≤ 10^6, q prime not dividing m, q of ANY size.
  Uses a(mq) = a(m)(q+1)/2 and solves the quotient-k quadratic in q exactly
  (k < 4m^2/a(m)^2 is forced). 84,272,330 (m,k) pairs, 78,500 integer roots, all with q = 1 or q | m,
  0 genuine hits. So no counterexample has the form m*q with q ∥ n and n/q ≤ 10^6.
- `relaxed.c 20000`: pairs 2 ≤ u < v ≤ 20000 (no primality) with
  uv(uv-1) | ((2u-1)(2v-1))^2 - 1: 0 solutions. Sanity run with u = 1 allowed finds exactly the
  19,999 trivial solutions (n = 2v-1, the "prime" case), as it should.
  Note u = v = 4 (n = 49 treated as if a(49) were 16) is a relaxed solution, so u ≠ v matters.

## Phase C: proofs on paper

Notation: odd n ≥ 3, M = a(a-1). The congruence is M | n^2 - 1 (M ≥ 2).

(P0) Even n: n^2 % M is even, 1 % M = 1. Fails. [Lean: `A224Sweep.not_modEq_of_even`, `conjecture_of_even`]

(P1) Odd prime p: a(p) = (p+1)/2 (k and p-k give the same square; k ↦ k^2 is injective on
0..(p-1)/2 because p | (k-j)(k+j)). With p = 2t+1, M = t(t+1) and p^2 = 1 + 4t(t+1).
[Lean: `A224Sweep.a_prime`, `modEq_of_odd_prime`]

(P2) Necessary conditions (proved on paper): if the congruence holds for n, then
 (i) gcd(n, a(n)(a(n)-1)) = 1 (since gcd(n, n^2-1) = 1);
 (ii) for every prime q with q ∥ n: (q+1)/2 divides (n/q)^2 - 1
      (a(n) = a(n/q)(q+1)/2 by multiplicativity, and q ≡ -1 mod (q+1)/2, so n^2 ≡ (n/q)^2).
      In particular q ≤ 2(n/q)^2 - 3.

(P3) Odd prime powers n = p^k, k ≥ 2: the congruence fails. (proved on paper, no computation)
 Recursion gives a(p^k) = phi(p^k)/2 + a(p^{k-2}) and phi(p^j)/2 ≡ 0 mod p for j ≥ 2.
 - k even: a(p^k) ≡ a(1) = 1 mod p, so p | a-1 | n^2-1, but p | n. Contradiction.
 - k odd ≥ 3: summing, a(p^k) = (p^{k+1} + 2p + 1)/(2(p+1)), so D := a-1 = (p^{k+1}-1)/(2(p+1)).
   D | p^{2k}-1 and D | p^{k+1}-1, so D | p^{gcd(2k,k+1)}-1 = p^2-1 (gcd = 2 as k+1 is even).
   Then p^{k+1}-1 ≤ 2(p+1)(p^2-1); but p^{k+1}-1 ≥ (p^2+1)(p^2-1) and p^2+1 > 2(p+1) for p ≥ 3.
 Checked numerically: a(27) = 11, D = 10 = 80/8.

(P4) Semiprimes n = pq, 3 ≤ p < q primes: the congruence fails. (paper proof + finite computation)
 u = (p+1)/2, v = (q+1)/2, 2 ≤ u < v, a = uv, n = (2u-1)(2v-1).
 Suppose n^2 - 1 = k·uv(uv-1).
 Step 1: k ≤ 15, since 16P(P-1) - (n^2-1) = 4(s(4P-s+1) - 6P) > 0 (P = uv, s = u+v ≤ 2v ≤ P, s ≥ 5).
 Step 2: the equation is equivalent to  α v^2 + 4u(u-1) = (16u^2 - (16+k)u + 4) v,
         α = (16-k)u^2 - 16u + 4.  (n-1)(n+1) = 4X(X+1), X = (2u-1)v - u.)
 Step 3: hence α v < 16 u^2.
 Step 4: u ≤ 31: if u ≥ 32 then α ≥ u^2-16u+4 > 0 and α v ≥ (u^2-16u+4)(u+1) > 16u^2.
 Step 5: v | 4u(u-1) (from Step 2), so v ≤ 4·31·30 = 3720.
 Step 6: so p ≤ 61, q ≤ 7439, n < 4.6·10^5, inside the exhaustive range [2, 10^7): no hit.
         Independently, `relaxed.c` covers u < v ≤ 20000: no hit.
 Primality of p, q is used only to get a(pq) = uv.
