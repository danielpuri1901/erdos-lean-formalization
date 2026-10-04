# Sweep notes: minmodulus

start: 1791105193 (date -u +%s)

## Statement (read from the Lean source)

Source: `.lake/packages/formal_conjectures/FormalConjectures/Arxiv/2607.08366/MinModulus.lean`.

- `IsValidMod (A : Finset (ZMod N))`: for every `m : ZMod N → ℕ` with
  `∑ a ∈ A, m a = #A` and `∑ a ∈ A, (m a : ZMod N) * a = ∑ a ∈ A, a`, we have `m a = 1` for all `a ∈ A`.
  (Values of `m` off `A` are irrelevant.)
- `minModulus n = 2 ^ n - 2 ^ (Nat.log 2 n)` (natural subtraction; never truncates since
  `2^(log2 n) ≤ n < 2^n`).
- `min_modulus : answer(sorry) ↔ ∀ n N, 2 ≤ n → 0 < N → N < minModulus n →
   ∀ A : Finset (ZMod N), #A = n → ¬ IsValidMod A`.

In words: for n ≥ 2 and 1 ≤ N < 2^n − 2^⌊log₂ n⌋, no n-element subset of Z/N is valid.

## Reformulation (proved on paper)

Write m = 1 + v. Then v_a ≥ −1, Σ v_a = 0, v ≠ 0. Let D = {a : v_a = −1} (a set, size k ≥ 1)
and P = the multiset with multiplicities v_a on A \ D (size k). So:

A is valid ⇔ there are no disjoint D (a nonempty set) and P (a multiset on A \ D) with |D| = |P|
and ΣD ≡ ΣP (mod N).

Consequences:
- validity is invariant under affine maps x ↦ u·x + c with u a unit (|D| = |P| kills c);
- validity is hereditary: a subset of a valid set is valid (its (D,P) pairs are pairs for A);
- 2c ≡ 2d is allowed (D would need d twice), e.g. {0,1} mod 2 is valid.

## Edge cases

- N = 0 excluded by `0 < N`. N = 1: ZMod 1 has 1 element, no n-set with n ≥ 2, vacuous.
- N < n: no n-subset exists, vacuous.
- n = 2: minModulus 2 = 2, so only N = 1, vacuous. n = 3: N ∈ {3,4,5} matter.
- `Nat.log 2 n` is ⌊log₂ n⌋ for n ≥ 1; no truncation issue in the subtraction.
- #A ≤ 1 sets are valid trivially, but excluded by 2 ≤ n.

statement check: matches (the Lean statement says what the docstring says; I found no trivial
truth/falsity: the vacuous range N < n is harmless and the hard range n ≤ N < minModulus n is real).

## Phase A: small cases reproduced

Code: `search.c` (DFS over sets {0 < a1 < ...}, translation normalisation only, full DP check of
each prefix), `search2.c` (also unit normalisation: WLOG {0, g} ⊆ A with g | N the least
gcd(b − a, N) over pairs, every difference has gcd ≥ g; incremental DP per depth),
`check.py` (independent brute force straight from the definition, no symmetry at all).

Least N with a valid n-set, and every N up to 2^n − 1 or 2^n that admits one:

| n | valid N found (range searched)             | least | minModulus |
|---|--------------------------------------------|-------|------------|
| 2 | 2,3,4 (N=1..4; search, search2, check.py)  | 2     | 2          |
| 3 | 6,7,8 (N=1..8; all three)                  | 6     | 6          |
| 4 | 12,14,15,16 (N=1..16; all three)           | 12    | 12         |
| 5 | 28,30,31,32 (N=1..32 C; N=1..31 Python)    | 28    | 28         |
| 6 | 60,62,63,64 (N=6..64; search and search2)  | 60    | 60         |

So the problem file's numbers reproduce. New observation: the set of valid moduli is NOT upward
closed: N = 13 (n=4), 29 (n=5), 61 (n=6) admit no valid set although a smaller modulus does
(each is minModulus + 1). So the conjecture cannot be reduced to checking N = minModulus − 1.
`check.py` also confirms {2^k − 1} is valid mod minModulus n and not mod minModulus n − 1 for
n = 6, 7.

## Phase B: n = 7 (new range)

`search2 7 N N` for every N = 7..125 (4 parallel chunks, files `n7a..n7d.txt`):
no valid 7-set for N = 7..123; valid at N = 124 = minModulus 7 (found {0,1,3,7,15,31,63});
none at N = 125. So the conjecture holds for n = 7 (computer only, not a proof).
`search2` agrees with `search` (independent DFS, no unit normalisation) on every N ≤ 64 for
n ≤ 6, and with `check.py` (pure brute force) for n ≤ 5.
Pattern seen for n = 4..7: minModulus + 1 admits no valid set (13, 29, 61, 125).

## Phase C: proof attempts

### Proved (paper and Lean): N ≥ 2^(n−1)

Lemma W (witness). If a₀ ∈ A, D, P ⊆ A \ {a₀} disjoint, D ≠ ∅, |P| ≤ |D| and
ΣD = ΣP + (|D| − |P|)·a₀ in Z/N, then A is not valid. Proof: the multiset m that drops D,
doubles P and gives a₀ multiplicity 1 + |D| − |P| has size |A| and sum ΣA, and m = 0 on D.
(Proved on paper; Lean `MinModulusSweep.not_isValidMod_of_witness`.)

Lemma S. If S ≠ T ⊆ A \ {a₀} and Σ_S (a − a₀) = Σ_T (a − a₀), A is not valid.
Proof: cancel S ∩ T (Mathlib `sum_sdiff_eq_sum_sdiff_iff`), WLOG |T\S| ≤ |S\T|, apply W with
D = S\T, P = T\S. (Lean `not_isValidMod_of_shifted_sum_eq`.)

Theorem. n ≥ 1, 0 < N < 2^(n−1), |A| = n ⇒ A not valid. Pigeonhole of the 2^(n−1) subsets of
A \ {a₀} into Z/N under S ↦ Σ_S (a − a₀), then Lemma S.
(Lean `not_isValidMod_of_lt_two_pow_pred`, builds, axioms: propext, Classical.choice, Quot.sound.)

This is the "dissociated set" bound: A − a₀ minus {0} must have distinct subset sums mod N.
It covers every N < 2^(n−1) for every n; the conjecture's range is N < 2^n − 2^⌊log₂ n⌋,
so roughly half the range remains.

### Plain-maths reformulation with a₀ = 0 (proved on paper)

With 0 ∈ A and A' = A \ {0}, A is valid iff both:
(C1) no nonempty set D ⊆ A' and multiset Q on A' \ D with |Q| ≤ |D| and ΣD = ΣQ;
(C2) no set D' ⊆ A' and multiset P on A' \ D' with |P| = |D'| + 1 and ΣD' = ΣP.

### One more value (paper): N ≥ 2^(n−1) + 1 for n ≥ 3

Take b ∈ A' with 2b ≠ 0 (exists for n ≥ 3: Z/N has at most one element of order 2 and A'
has ≥ 2 nonzero elements). Then 2b is not a subset sum of A': 2b = ΣT with b ∈ T is a
subset-sum collision {b} vs T\{b} (C1); with b ∉ T, |T| ≥ 2 it is C1 with D = T, Q = {b,b};
|T| = 1 is C2 with D' = T, P = {b,b}; T = ∅ is 2b = 0, excluded. So the 2^(n−1) distinct
subset sums avoid the value 2b, and N ≥ 2^(n−1) + 1.

### Why the counting does not easily reach 2^n

Values 2b + ΣS (S ⊆ A' \ {b}) may legally coincide with ΣT when b ∉ T and |S\T| ≥ |T\S|
(neither side is a set after cancellation and C2's size condition fails). Two base points
a₀, a₁ give two families of size-(n−1) multisets, but cross-collisions are allowed whenever
both padding elements have multiplicity ≥ 2. The extremal set {2^k − 1} shows the gap from
2^(n−1) to 2^n − 2^⌊log₂ n⌋ comes from these multiset (not set) relations; a proof needs to
control them, e.g. by an injection of ~2^n carefully chosen multisets whose pairwise
cancellations always leave a set on one side.
