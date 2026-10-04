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

## Phase B: search (in progress)

Structured family ("extremal for mu*"): r-regular graphs with a matching M of m edges whose
vertex set induces only M, the other vertices U independent, every matched vertex has r-1
neighbours in U, every U vertex r neighbours in V(M). Then M is maximal, so mu* <= m, and
n = 2m(2r-1)/r, which is the smallest n allowed by the bound mu* >= nr/(2(2r-1)).
A counterexample here only needs i(G) > m. Code: `search.c` mode 0 (random start plus
endpoint-swap hill climbing on i - m, accepting ties and 0.5% of worse moves).

Search code: `search.c` modes 0 to 3 (built as `search`, `search2`, `search3`; same source,
later builds add options without changing older modes' trajectories), `scan.c`
(steepest ascent over all double edge swaps), `eval.h` (exact i, mu*, and a count of
distinct minimum independent dominating sets; the count was checked against brute force
on 60 random regular graphs with n <= 14, `brute_count.py`, 0 mismatches after fixing one
pruning bug).

Mode 2 objective: in the extremal family, -(10^6 (m - i) + #{independent dominating sets of
size i}) ; a counterexample is any graph with i > m.
Mode 3 objective: general r-regular graphs, same with mu* in place of m.

Runs (each run: random start, endpoint swaps, ties accepted, 0.5% worse moves accepted):

| mode | r | size | iterations | seed | result |
|---|---|---|---|---|---|
| 0 | 3 | m=9 (n=30) | 2,000,000 | 11 | best i - m = 0 |
| 0 | 3 | m=12 (n=40) | 2,000,000 | 12 | best i - m = 0 |
| 0 | 3 | m=15 (n=50) | timeout 300 s | 13 | best i - m = 0 |
| 0 | 3 | m=18 (n=60) | timeout 300 s | 14 | best i - m = -1 (slow evaluation) |
| 1 | 3 | n=20 | 400,000 | 23 | best i - mu* = 0 |
| 2 | 3 | m=9 (n=30) | 400,000 | 21 | i = m with 10 minimum sets |
| 2 | 3 | m=12 (n=40) | 400,000 | 22 | i = m with exactly 1 minimum set (near miss) |
| 2 | 4 | m=8 (n=28) | 400,000 | 24 | i = m with 95 minimum sets |
| 3 | 3 | n=16 | 300,000 | 31 | i = mu* with 10 minimum sets |
| 3 | 3 | n=22 | 300,000 | 32 | i = mu* with 16 minimum sets |

Random graphs in the extremal family start at i = m - 1 or m - 2 (6 samples, m = 12, 18).

Near miss (seed 22, reproduced by `search3 2 3 12 190366 22`, saved as `near22.txt`):
a cubic graph on 40 vertices with i = mu* = 12 (checked with `check`: i = 12, mu* = 12,
exactly 1 independent dominating set of size 12). Format: n e followed by the edge list;
edges 0..11 are the matching (2j, 2j+1).
