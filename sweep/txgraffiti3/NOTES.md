# txgraffiti3 sweep notes

start: 1791104516 (date -u +%s)

## Phase A: statement

Lean: `Arxiv.«2507.17780».tx_graffiti_conjecture_3`, in
`.lake/packages/formal_conjectures/FormalConjectures/Arxiv/2507.17780/3.lean`.

For every finite type V with decidable equality, every simple graph G on V with
decidable adjacency, and every r >= 1 such that every vertex has degree r:
`G.indepDominationNumber <= G.saturationNumber`.

Definitions, read from the Lean sources (FormalConjecturesForMathlib):
- `IsIndepSet D` (Mathlib): pairwise non-adjacent.
- `IsDominating G D`: every v is in D or adjacent to some w in D.
- `IsNIndepDominatingSet n D`: D independent, dominating, D.card = n.
- `indepDominationNumber G = sInf {n | exists D : Finset V, IsNIndepDominatingSet n D}`.
- `IsEdgeMatching G M` (M : Finset (Sym2 V)): every e in M is in G.edgeSet, and any two
  elements of M are equal or share no vertex.
- `IsMaximalEdgeMatching G M`: IsEdgeMatching G M and for every e in G.edgeSet with e not in M,
  `insert e M` is not a matching.
- `saturationNumber G = sInf {n | exists M, IsMaximalEdgeMatching G M and M.card = n}`.
  Bridge `saturationNumber_eq_computable` exists (powerset enumeration).

Edge cases:
- V empty: hypotheses hold vacuously (any r >= 1); both sides are 0 (empty set is an
  independent dominating set, empty matching is maximal). 0 <= 0, fine.
- sInf of empty set: never happens. Both sets are nonempty for every finite graph
  (a maximal independent set is independent dominating; a greedy maximal matching exists).
- No subtraction, no division. Loops impossible (M is inside edgeSet, simple graph).
- r is fixed and >= 1, so no isolated vertices; G need not be connected.

statement check: matches (the Lean statement says exactly i(G) <= mu*(G) for r-regular
G with r >= 1, with the usual meanings of i and mu*).

Red team: no trivial truth or falsity. r = 1 (perfect matching, i = mu* = n/2) and r = 2
(disjoint cycles, i(C_k) = mu*(C_k) = ceil(k/3), both additive over components) are true
with equality, so any counterexample needs r >= 3.

Small cases reproduced (own code): `eval.h` (C, exact branch and bound for i and mu*)
checked against `brute.py` (independent exhaustive Python) on 130 graphs: C_3..C_12 and
120 random r-regular graphs (r = 1..5, n <= 12). 0 mismatches, 0 counterexamples.
i(C_n) = mu*(C_n) = ceil(n/3) for n = 3..12, as in the problem file.
