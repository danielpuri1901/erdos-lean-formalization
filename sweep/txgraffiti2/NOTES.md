# txgraffiti2 sweep notes

start: 1791105004 (date -u +%s)

## Phase A: understanding

Statement (own words): V finite with decidable equality, G a simple graph on V,
G connected (so V nonempty), maxDegree G <= 3, and "if G = ⊤ then card V ≠ 4"
(i.e. G is not K4).  Then zeroForcingNumber G <= indepNum G + 1.

Definitions, read from `FormalConjectures/Arxiv/2507.17780/2.lean`:
- `zeroForcingStep G S = S ∪ {w ∉ S | ∃ v ∈ S, Adj v w ∧ ∀ u, Adj v u → u ∉ S → u = w}`
  (simultaneous colour-change rule: every black v with exactly one white neighbour w forces w).
- `zeroForcingClosure G S = (zeroForcingStep G)^[card V] S`.
  The step is inflationary; if it does not stabilise it adds >= 1 vertex, so card V
  iterations reach the true closure. Matches the standard definition.
- `IsZeroForcingSet G S := zeroForcingClosure G S = univ`.
- `zeroForcingNumber G = sInf {k | ∃ S, S.card = k ∧ IsZeroForcingSet G S}`;
  univ is forcing, so the set is nonempty and sInf is a true minimum.
- `G.indepNum` (Mathlib) = sSup {n | ∃ s, G.IsNIndepSet n s}, bounded by card V.
- `G.maxDegree` (Mathlib) = max of degrees (0 for empty V; irrelevant since connected).

Edge cases:
- empty V: excluded by `Connected` (needs Nonempty).
- K1: Z=1, α=1. K2: Z=1, α=1. K3 (= ⊤ with card 3, allowed): Z=2, α=1, 2<=2 tight.
- K4: Z=3, α=1 — excluded by `_hNotK4` exactly (⊤ with card 4 is K4; ⊤ on 4 vertices has max degree 3).
- No ℕ subtraction/division. sInf over a nonempty set; sSup over a bounded set.
- Hypotheses are satisfiable (e.g. paths), so not vacuous.
- Monotonicity: superset of a forcing set is forcing (closure is monotone in S), so
  Z <= k iff some k-set forces. Used in the search code.

statement check: matches (Lean = docstring = standard Z(G) <= α(G)+1 for connected
subcubic G ≠ K4).

Reproduction (own code):
- `zf.c` (bitmask C; closure by repeated forcing, α by branching) mode `all n`: all
  labelled connected subcubic graphs on n vertices.
- `check.py` (independent Python; follows the Lean definitions literally: step iterated
  card V times, Z by increasing k, α by brute force), labelled + isomorphism classes.
- Results (labelled count / tight Z=α+1 / failures):
  n=1: 1/0/0, n=2: 1/0/0, n=3: 4/1/0, n=4: 38/0/1 (the 1 failure is K4),
  n=5: 472/30/0, n=6: 7540/340/0 — Python and C agree exactly.
  C only: n=7: 150930 labelled, 630 tight, 0 failures.
- Isomorphism classes (Python, n<=6): 1,1,2,6,10,29; 6 at n=4 includes K4, so 5 without.
  Matches the problem file's 1,1,2,5,10,29.
