# txgraffiti3 sweep notes

```
result: partial
claim: For every finite simple graph G that is r-regular with r >= 1 (n = |V|):
  (a) if r = 1 then i(G) <= mu*(G);
  (b) if 2(2r-1)(n-r) <= n r, in particular if 4r >= 3n, then i(G) <= mu*(G).
  Also proved along the way: i(G) <= n - r (V nonempty), and n r <= 2|M|(2r-1) for every
  maximal matching M (so mu*(G) >= nr/(2(2r-1)), the bound quoted in the problem file).
  Proved on paper only: the case r = 2 (all 2-regular graphs), see C3.
lean: Solution.lean, namespace Txgraffiti3Sweep: tx3_regular_one, tx3_dense,
  tx3_three_quarters, with lemmas indepDominationNumber_le_card_sub,
  card_mul_le_of_isMaximalEdgeMatching, exists_isMaximalEdgeMatching and the *_of_one lemmas.
  `lake build Solution` passes with no sorry; #print axioms gives only propext,
  Classical.choice, Quot.sound for all three theorems.
computed: no counterexample. Exact i and mu* by branch and bound (`eval.h`, checked against
  brute force on 130 graphs; the count of minimum sets checked on 60 more). Local searches:
  cubic graphs in the extremal family (mu* <= m, n = 10m/3) for m = 9, 12, 15, 18 (n = 30..60);
  4-regular extremal family m = 8, 12 (n = 28, 42); general cubic graphs n = 16, 20, 22.
  Iteration counts in the Phase B table. Best found: i = mu* (never i > mu*).
  Near miss: cubic graph on 40 vertices (`near22.txt`) with i = mu* = 12 and exactly one
  minimum independent dominating set. Exhaustive scan: none of its single double-edge swaps
  has i > mu*.
next idea: In the cubic extremal family, counterexamples correspond to unsatisfiable 3-CNF
  formulas in which every literal occurs exactly twice (4m/3 clauses on m variables, see C5),
  plus a weaker condition ruling out mixed sets. Random such formulas have about 1.67^m
  satisfying assignments, and local search only reached 1 (m = 12). Next: build an
  unsatisfiable formula of this kind on purpose, either with the construction from the
  (3,B2)-SAT NP-completeness proof (from memory, unverified: Berman-Karpinski-Scott) or with a
  SAT-solver-guided search. Then compute i on the resulting graph; this needs an evaluator for
  more than 64 vertices (bitsets wider than u64). Smaller separate step: formalize r = 2 (C3).
  It needs an orientation of each cycle, e.g. Hall's theorem
  (`Finset.all_card_le_biUnion_card_iff_exists_injective`) to choose one incident edge per
  vertex, injectively.
dead ends: random members of the extremal family have i = m - 1 or m - 2, far from i > m.
  Plain hill climbing on i - m (mode 0) stalls at i = m. The count objective (mode 2) gets
  down to 1 minimum set but no further: 2 seeds reached 1, and restarts from the near miss
  (graph search and SAT search) did not reach 0. SAT local search from a random start stalls
  at 16 (m = 12) and 69 (m = 15) satisfying assignments. A quick paper proof for the
  extremal family via a perfect matching of the clause multigraph H fails because of
  fix-up vertices (C4). Lemma B is tight in the extremal family, so the dense method cannot
  go past 2(2r-1)(n-r) <= nr without a better upper bound on i than n - r.
confidence: high for the Lean claims, because they build with no sorry and only standard
  axioms. Low that a counterexample exists below 64 vertices in the families searched,
  because many searches stall at the same floor (exactly one minimum set).
```


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

## Phase C: proofs

### C1. r = 1 (proved in Lean: `Txgraffiti3Sweep.tx3_regular_one`)
A 1-regular graph is a perfect matching. Every edge lies in every maximal matching (two edges
sharing a vertex are equal, so inserting a missing edge keeps a matching). With a linear
order on V, D = {v : v < its neighbour} is independent and dominating, and v -> s(v, nbr v)
maps D injectively into any maximal matching M. So i(G) <= |M| for every maximal M.

### C2. Dense case (proved in Lean: `Txgraffiti3Sweep.tx3_dense`, `tx3_three_quarters`)
Lemma A (proved, Lean `indepDominationNumber_le_card_sub`): if G is r-regular and V is
nonempty, then i(G) <= n - r. A maximal independent set through a vertex v is independent
dominating and avoids the r neighbours of v.
Lemma B (proved, Lean `card_mul_le_of_isMaximalEdgeMatching`): for every maximal matching M
of an r-regular graph, n r <= 2 |M| (2r - 1). U = uncovered vertices, W = covered vertices,
|W| <= 2|M|; every neighbour of a U vertex is in W (maximality); every w in W has its partner
in W, so at most r - 1 neighbours in U; double counting gives |U| r <= |W| (r - 1), so
n r = (|U| + |W|) r <= |W| (2r - 1) <= 2 |M| (2r - 1).
Theorem: if 2(2r-1)(n-r) <= n r (n = |V|, natural-number subtraction), then
i(G) <= n - r <= |M| for every maximal matching, so i(G) <= mu*(G). The hypothesis holds
whenever 3n <= 4r (with d = n - r: 3d <= r gives 2(2r-1)d <= 3rd + rd <= r^2 + rd).
Covers e.g. K_n (n >= 4), K_n minus a perfect matching (n >= 8), and every r-regular graph
with r >= 3n/4. Does not cover K_{r,r} (there n - r = r but Lemma B only gives about r/2).

### C3. r = 2 (proved on paper only, not in Lean)
G is a disjoint union of cycles. Orient every cycle. Let M be any maximal matching. For an
M-edge {x, y} with y after x, the vertex after y is either uncovered or the first vertex of
the next M-edge, and the vertex after an uncovered vertex is the first vertex of an M-edge
(uncovered vertices are pairwise non-adjacent). Let D be the set of second vertices.
D is independent (the neighbours of a second vertex are its first vertex and the next
vertex, which is uncovered or a first vertex), dominating (a first vertex is adjacent to its
partner; an uncovered vertex u has prev(u) covered by the edge {prev(prev(u)), prev(u)}, so
prev(u) is in D), and |D| = |M|. So i(G) <= mu*(G) for all 2-regular graphs.
Not formalized: it needs an orientation of each cycle of a 2-regular graph, which is the hard
part in Lean. Decision: spend the time on the dense case instead.

### C4. The extremal family (r = 3) does not obviously give a counterexample
In the family of Phase B, write each matched vertex z as an edge of a multigraph H on U
(z joins its two U-neighbours). H is cubic on 4m/3 vertices with 2m edges, grouped in m
pairs {x_j, y_j}. If H has a perfect matching P (2m/3 edges), keep one edge of P from each
pair class: a set T of at least m/3 matched vertices, from distinct pairs, with pairwise
disjoint U-neighbourhoods. D = T plus (U minus N(T)) is independent of size
|T| + 4m/3 - 2|T| <= m, but it may miss pair vertices whose two U-neighbours are both in
N(T); each such pair costs one more vertex. So the argument is incomplete (plausible, not
proved). Computation: i = m - 1 or m - 2 for random members, and i <= m in every member evaluated.

### C5. SAT view of the extremal family (r = 3), found during Phase B
In the extremal family, an independent dominating set made of one endpoint from every pair is
the same as a satisfying assignment of the 3-CNF F whose variables are the pairs (x_j = +j,
y_j = -j) and whose clauses are the U vertices (the three matched neighbours of u).
F has 4m/3 clauses, 3 distinct variables per clause, and every literal occurs exactly twice.
Conversely every such formula gives a cubic graph in the family. So:
- A counterexample in the family needs (1) F unsatisfiable, and (2) no mixed independent
  dominating set of size <= m (k pairs left out, at most k clause vertices used, and both
  literal vertices of every left-out pair adjacent to a used clause vertex).
- Leaving out a single pair never gives a set of size <= m (on paper: both literal vertices
  of the pair need a used clause vertex, and no clause holds both, so at least 2 clause vertices
  are used). Leaving out k >= 2 pairs can work, so (2) is a real extra condition.
- A random formula of this kind has about 2^m (7/8)^(4m/3) = 1.673^m satisfying assignments,
  so unsatisfiable ones are rare and structured.
- The near miss `near22.txt` is such a formula on m = 12 variables with exactly 1 satisfying
  assignment (checked by `satsearch` and separately in Python). Its unique minimum
  independent dominating set is that assignment (`showset`).
- From memory, unverified: Berman, Karpinski and Scott (around 2003) studied "(3,B2)-SAT"
  (3 literals per clause, every literal exactly twice) and showed it NP-complete; if right,
  unsatisfiable instances exist, but possibly only with many more than 19 variables.

`satsearch.c`: local search over such formulas, minimising the number of satisfying
assignments (exhaustive count over 2^m), and computing i(G) for any unsatisfiable formula found.
