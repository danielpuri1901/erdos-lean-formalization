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
