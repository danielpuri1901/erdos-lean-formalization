# Sweep notes: a004290

start: 1791105105 (date -u +%s)

## Phase A: statement

Lean (`.lake/packages/formal_conjectures/FormalConjectures/OEIS/4290.lean`, `OeisA4290.conjecture`):

    a n := sInf { m : ℕ | 0 < m ∧ n ∣ m ∧ ∀ d ∈ Nat.digits 10 m, d = 0 ∨ d = 1 }
    conjecture (k : ℕ) : ∀ n < 10 ^ k - 1, a n < a (10 ^ k - 1)

In words: for n ≥ 1, a n is the least positive multiple of n whose decimal digits are
all 0 or 1 (the set is nonempty for n ≥ 1 by pigeonhole on the repunits R_1..R_{n+1}).
For n = 0 the set is empty (0 ∣ m forces m = 0, contradicting 0 < m), so a 0 = sInf ∅ = 0.
The claim: for every k and every n < 10^k - 1 (natural subtraction), a n < a (10^k - 1).

Definitions used: `Nat.digits 10 m` (little-endian digit list, `digits 10 0 = []`),
`sInf` on ℕ (0 on the empty set), natural subtraction `10^k - 1` (no truncation issue,
10^k ≥ 1).

Edge cases:
- k = 0: 10^0 - 1 = 0, `n < 0` never holds: vacuous.
- k = 1: n ∈ {0..8}, target a 9 = 111111111. n = 0 gives a 0 = 0 < a 9.
- n = 0 in general: a 0 = 0, and a(10^k-1) > 0 for k ≥ 1, so n = 0 is never a problem.
- No division, no empty-sInf trouble for n ≥ 1.

Key fact (known, docstring): a(10^k - 1) = R_{9k} (9k ones). Proof sketch (paper, mine):
every positive multiple N of 10^k - 1 has decimal digit sum ≥ 9k (strong induction:
if N ≥ 10^k write N = 10^k H + L; then H + L ≡ 0, 0 < H + L < N and
s(H+L) ≤ s(H) + s(L) = s(N); base case N < 10^k forces N = 10^k - 1, digit sum 9k).
A 0/1 number with ≥ 9k ones is ≥ R_{9k}, and R_{9k} = R_k * (10^{9k}-1)/(10^k-1)... is a
multiple of 10^k - 1 since 9 ∣ (10^{9k}-1)/(10^k-1) = Σ_{i<9} 10^{ki} ≡ 9 mod 9 — ok.

So the conjecture is equivalent to: for all n < 10^k - 1, a(n) < R_{9k}, i.e. every such n
has a 0/1 multiple with at most 9k digits other than R_{9k} itself. A sufficient condition:
a 0/1 multiple with at most 9k - 1 digits.

statement check: matches (docstring and Lean agree; k = 0 vacuous; n = 0 harmless).
Not trivially true or false: a uniform O(log n)-digit bound for 0/1 multiples is not known
to me; pigeonhole only gives n digits, Olson-type zero-sum bounds give O(sqrt p) for primes.

Reduction used in search: write n = 2^a 5^b m with gcd(m,10) = 1. If y is a 0/1 multiple
of m then 10^max(a,b) * y is a 0/1 multiple of n, so digits(a n) ≤ digits(a m) + max(a,b).
