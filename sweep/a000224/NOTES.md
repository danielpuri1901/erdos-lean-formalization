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
