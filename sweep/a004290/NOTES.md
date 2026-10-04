# Sweep notes: a004290

```
result: partial
claim: (Lean) OeisA4290.conjecture holds for k ≤ 3; for every k ≥ 1, a(10^k - 1) ≥ 10^(9k-1),
  and the conjecture at k follows from "every 0 < n < 10^k - 1 has a 0/1 multiple below 10^(9k-1)".
  (Paper + computer) the conjecture holds for k ≤ 7; and there is an infinite family,
  n = (10^(34m)-1)/103 and n = (10^(46m)-1)/139, where a(n) has exactly 9k digits, the same
  number of digits as a(10^k - 1) (the conjecture still holds there: a(n) has fewer ones).
lean: Solution.lean, namespace SweepA4290: conjecture_le_three (k ≤ 3; also conjecture_le_one,
  conjecture_le_two, conjecture_three), a_rep_ge, ds_of_dvd, conjecture_of_witnesses'
  all build with no sorry; axioms propext, Classical.choice, Quot.sound.
computed: exact a(n) for all n ≤ 99998 (BFS); upper bounds for all n < 10^7 - 1 (meet-in-the-middle
  + BFS fallback, every witness re-checked by an independent Python script): max digit length
  ≤ 49 for k = 6 (need ≤ 53), ≤ 58 for k = 7 (need ≤ 62). Structured family n = c(10^r-1)/d,
  c ∈ {1,2,4,5,8}: exact length formula (proved on paper, checked against BFS on 100 cases), all
  d < 10^7 searched: minimum digit margin 0 (d = 103, 139), never negative.
next idea: a counterexample would be a d coprime to 10 such that every orbit of x ↦ 10x mod d has a
  digit 9 in the expansion of x/d ("V = 9") and the longest cyclic run of non-9 digits G satisfies
  G < 9·floor(log10 d) (or G - 9j < max(a,b) for a multiplier c = 2^a5^b < d/10^j); then
  n = c(10^r-1)/d, ord_d(10) | r, has a(n) > R_{9k}. Search d beyond 10^7 with v9fast.c (early exit
  makes this cheap), and look at other multipliers c (3, 7, 9, ...) via the same exact formula.
  Heuristically (1 - 0.9^(9j))^(d/p) kills large d, so a proof attempt should instead try to bound
  len(a(n)) ≤ 9k for n < 10^k - 1 directly, which looks out of reach (no known O(log n) bound).
dead ends: plain exhaustive BFS is O(n) per n (k=5 takes 50 s in C, k=6 would take hours); use the
  2^a5^b reduction plus meet-in-the-middle instead. Families with V ≤ 8 have margin growing linearly
  in r, so only V = 9 families matter. Pigeonhole and Olson-type zero-sum bounds are far too weak
  for a proof.
confidence: high because the Lean theorems build without sorry, the computer witnesses were checked
  by independent code, and the family formula is proved on paper and matched exact BFS.
```


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

## Phase A.6: reproduction

`bfs_exact.c` (BFS over residues, digit 0 before 1): a(1..20) = 1, 10, 111, 100, 10, 1110,
1001, 1000, 111111111, 10, 11, 11100, 1001, 10010, 1110, 10000, 11101, 1111111110, 11001, 100.
Matches the problem file. Exact a(n) for all n ≤ 99998 (50 s): no violator for k = 1..5.
Exact maximum of len(a(n)) over n in [10^(k-1)-1, 10^k-1):
k=1: 4 (n=6), k=2: 12 (n=72), k=3: 21 (n=792), k=4: 30 (n=7992), k=5: 43 (n=76923 = 999999/13).
Bound needed: len ≤ 9k-1 suffices (9k digits allowed unless a(n) = R_{9k}).
k=5 margin is only 2 digits (43 vs 45).

## Phase B: search

### B1. Exhaustive k = 6, 7 (upper bounds, independently verified)

Exact reduction (proved on paper): n = 2^a 5^b m, gcd(m,10) = 1, e = max(a,b). A 0/1 number x
divisible by 2^a has its low a digits zero (if S = set of 1-positions below a, v2(Σ_{i∈S} 10^i)
= min S < a), same for 5^b, so x = 10^e y with m | y. Hence len(a(n)) = e + len(a(m)).

`mitm.c`: for every m < 10^7 coprime to 10, meet-in-the-middle over subset sums of 10^i mod m
(low s positions in a hash table, high s+1 positions in Gray-code order; s grows on failure;
exact BFS fallback, used for 88 values of m). Writes a witness per m.
`verify.py` (independent, Python big ints): checks every witness is a positive 0/1 number
divisible by m, then recomputes for every n < 10^7 - 1 the bound e + len(w(m)).
Result (verified by verify.py over ALL n < 9999999):

    k=6: max bound 49 at n=729927 (= (10^8-1)/137), need <= 53 -> ok
    k=7: max bound 58 at n=8799912,                 need <= 62 -> ok

So the conjecture holds for k ≤ 7 (computer check; bounds are upper bounds, k ≤ 5 exact).
Run time: mitm 98 s on 4 cores; verify.py a few minutes.

### B2. Structured family n = (10^r - 1)/d: exact formula (proved on paper)

Let gcd(d,10)=1, p = ord_d(10), p | r, n = (10^r-1)/d, B = (10^p-1)/d.
Claim: len(a(n)) = min over t = 1..d of [ max over q with c_q(t) > 0 of (q + r c_q(t)) ] - p + 1,
where c(t) is the p-digit vector of t·B (q = 0 is the units digit).
Proof: for a 0/1 multiple x of n let c_j = #{1-positions ≡ j mod r}. Then
V = Σ c_j 10^j ≡ x ≡ 0 (mod n) because n | 10^r - 1, and V > 0. If every c_j ≤ 9 then
V ≤ 10^r - 1 = d n, so V = t n with 1 ≤ t ≤ d and c is the digit vector of t n (which is
t B repeated r/p times). c_j ones at positions ≡ j (mod r) force a position ≥ j + r(c_j - 1),
and placing them at j, j+r, ... attains it. If some c_j ≥ 10 the length is ≥ 9r + 1, worse than
t = d (all nines, length 9r). Repetition of the period-p block turns max_j(j + r(c_j-1)) into
max_q (q + r c_q) - p.  ∎
Checked against exact BFS for all 100 cases n = (10^r-1)/d < 10^7, r ≤ 7: 0 mismatches
(`formula_check.py`).

Consequence. If every multiple tB (t < d) contains a digit 9 ("V = 9"), then
len(a(n)) = 9r - G, where G = max over orbits of x ↦ 10x mod d of the longest cyclic run of
non-9 digits in the expansion of x/d. With j = floor(log10 d), n has r - j digits and
k(n) = r - j, so the digit margin 9k - len = G - 9j, independent of r.
Multiplying n by c = 2^a5^b with c·n < 10^k - 1 (roughly c < d/10^j) adds e = max(a,b)
digits without changing k: effective margin G - 9j - e.
If V ≤ 8 then len ≤ 8r and the margin grows linearly in r.

`v9.c` / `v9fast.c` search over d:
- d ≤ 30000, all periods: 5102 d have V = 9; smallest margins:
  d=53 (p=13) G=12 margin 3, with c=4 effective margin 1 (n = 754716981132, len 107 vs 108);
  d=103 (p=34) G=18 margin 0; d=139 (p=46) G=18 margin 0; d=1003 margin 3.
- d in [30000, 10^7) (`v9fast.c`, T = 3, 4 parallel ranges): no d with margin ≤ 3.
  So over all d < 10^7 the smallest margin is 0 (d = 103, 139) and the smallest effective
  margin (with c = 2^a5^b) is 0; nothing negative.
- `family.py` (all V, r ≤ 200, p ≤ 16, d ≤ 2·10^6): min margin 2 (n = 76923), none ≤ 1
  except as above.

FINDING: infinite family where a(n) has exactly as many digits as a(10^k - 1):
n = (10^(34m) - 1)/103, k = 34m - 2, len(a(n)) = 9k = 306m - 18 (m=1: 288 digits, m=2: 594);
also n = (10^(46m)-1)/139, k = 46m - 2. Witnesses checked by independent Python
(m=1,2 for d=103; m=1 for d=139). There a(n) has 153 (resp. 207) ones, so a(n) < R_{9k}
and the conjecture still holds; but the digit-count version is tight, so any proof must
compare more than lengths, and a d with V = 9 and G < 9j would be a counterexample.
Heuristic: a random orbit word of length p has longest non-9 run ≈ log(p/10)/log(10/9);
V = 9 with G ≤ 9j needs all ≈ d/p orbits to have 9s at least every 9j digits:
probability ≈ (1 - 0.9^(9j))^(d/p), which collapses for j ≥ 3. So small d is where to look,
and small d is now searched exhaustively.

## Phase C: proof attempt

### Plain argument for what is proved

(1) Lower bound (general k ≥ 1). ds = decimal digit sum.
  - ds(a+b) ≤ ds(a) + ds(b) (strong induction on a+b, split off the units digit, carry 0/1).
  - ds(10^k H + L) = ds(H) + ds(L) for L < 10^k.
  - ds(10^k - 1) = 9k.
  - Every N > 0 with (10^k-1) | N has ds(N) ≥ 9k: if N < 10^k then N = 10^k - 1;
    else N = 10^k H + L with H ≥ 1, and H + L is a smaller positive multiple
    (N - (H+L) = (10^k-1)H), so 9k ≤ ds(H+L) ≤ ds H + ds L = ds N.
  - A 0/1 number m has ds(m) ≤ #digits, so #digits ≥ 9k and m ≥ 10^(9k-1).
  - The repunit R_{9k} lies in S(10^k - 1) (R_{ki+k} = R_{ki} 10^k + R_k ≡ R_{ki} + R_k,
    so R_{9k} ≡ 9 R_k = 10^k - 1 ≡ 0), hence a(10^k-1) ≥ 10^(9k-1).
(2) Reduction: if every 0 < n < 10^k - 1 has a 0/1 multiple w < 10^(9k-1), then
    a n ≤ w < 10^(9k-1) ≤ a(10^k-1); n = 0 has a 0 = 0.
(3) k = 1: m ∈ S 9 ⇒ 9 | ds m, 0 < ds m ≤ #digits ⇒ m ≥ 10^8; witnesses a(1..8) ≤ 1110.
(4) k = 2: m ∈ S 99 ⇒ ds m ∈ 9ℕ, nonzero. If ds m = 9: alternating digit sum A has
    |A| ≤ 9, A ≡ ds m (mod 2) (0/1 digits) and 11 | A, so A = 0, contradiction with parity.
    So ds m ≥ 18, m ≥ 10^17. Witnesses a(1..98) (exact values from BFS) are < 10^17.
Lemma status: all proved on paper and in Lean.

The full conjecture needs a uniform bound len(a(n)) ≤ 9k - 1 (or = 9k with a(n) ≠ R_{9k})
for all n < 10^k - 1, i.e. an O(log n) bound on the length of 0/1 multiples with constant
about 9/log2(10)·... This is beyond reach: pigeonhole gives n digits, zero-sum (Olson)
bounds give O(sqrt p) for primes. Not attempted further.

### Lean (`Solution.lean`, namespace `SweepA4290`, builds with no sorry; axioms
propext, Classical.choice, Quot.sound only)

- `conjecture_le_one (k) (hk : k ≤ 1)`: the conjecture for k ≤ 1.
- `conjecture_le_two (k) (hk : k ≤ 2)`: the conjecture for k ≤ 2.
- `ds_of_dvd`: every positive multiple of 10^k - 1 (k ≥ 1) has digit sum ≥ 9k.
- `ge_of_mem_rep`, `rep_mem`, `a_rep_ge`: a(10^k - 1) ≥ 10^(9k-1) for all k ≥ 1
  (the lower half of the docstring's "known" value a(10^k-1) = R_{9k}).
- `conjecture_of_witnesses'`: for k ≥ 1, the conjecture at k follows from: every
  0 < n < 10^k - 1 has a 0/1 multiple below 10^(9k-1).  (Proved reduction.)
- `wit3_0` .. `wit3_7` (998 witnesses, the exact BFS values of a n, checked by `norm_num`),
  `conjecture_three` (k = 3 via the reduction), `conjecture_le_three` (all k ≤ 3).
  Full file builds in about 100 s.
- k = 4 by the same route needs 9998 witnesses; not tried (estimated 15-20 min build).

Decisions taken without asking: worked on k-small Lean cases plus the general reduction rather
than a full proof (no viable proof idea); searched structured families (n | 10^r - 1 with
small cofactor d) rather than blind enumeration beyond 10^7; stopped the Lean work at k = 3.

end: about 2050 s after start (34 min).
