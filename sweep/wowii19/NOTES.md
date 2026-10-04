# wowii19 sweep notes

start: 1791105190 (date -u +%s)

## Phase A: statement

Lean (`WrittenOnTheWallII.GraphConjecture19.conjecture19`):
for `α` finite, `DecidableEq`, `Nontrivial`, `G : SimpleGraph α` connected,

  ⌊ (Σ_v (G.eccent v).toNat) / |α|  +  sSup (range (indepNeighbors G)) ⌋  ≤  b G

Definitions read from the Lean source:
- `G.eccent v : ℕ∞ := ⨆ u, G.edist v u` (Mathlib `Diam.lean`). For connected G every
  edist is finite, so `.toNat` is the true eccentricity.
- `indepNeighbors G v : ℝ := ((G.induce (G.neighborSet v)).indepNum : ℝ)`,
  `indepNum H := sSup {n | ∃ s, H.IsNIndepSet n s}`. So l(v) = α(G[N(v)]).
- `b G : ℝ := (largestInducedBipartiteSubgraphSize G : ℝ)`,
  `largestInducedBipartiteSubgraphSize G := sSup {n | ∃ s : Finset α, (G.induce s).IsBipartite ∧ s.card = n}`.
  The repo already has the bridge `largestInducedBipartiteSubgraphSize_eq_computable`
  and `induce_isBipartite_iff_exists_coloring` (2-colouring c : α → Fin 2 valid on s).
- `sSup (Set.range indepNeighbors)`: range is finite and nonempty (α nonempty), so it is
  the maximum maxl = max_v l(v).

In words: in a connected graph with n ≥ 2 vertices,
b(G) ≥ ⌊ avgEcc(G) + max_v α(N(v)) ⌋.

Edge cases:
- n ≥ 2 and connected ⇒ every vertex has a neighbour ⇒ l(v) ≥ 1, ecc(v) ≥ 1.
- Division by n: n ≥ 2, no division by zero.
- sSup over a finite nonempty set of reals: fine (it is a max).
- The floor is an integer compared with a real (cast ℤ → ℝ). Fine.
- No hypothesis that can never hold. K_2: avgEcc = 1, maxl = 1, floor = 2 = b. Tight.

statement check: matches (docstring's "l(G)" here is the max over v, as the problem file says).

## Key observation (Phase A, on paper)

Lemma L1 (proved on paper). For every vertex v: b(G) ≥ ecc(v) + l(v).
Proof: BFS layers L_0 = {v}, L_1 = N(v), …, L_e from v, e = ecc(v) ≥ 1.
Let I ⊆ L_1 be independent with |I| = l(v). Let v = p_0, p_1, …, p_e be a shortest path
to a vertex at distance e. Take S = {v} ∪ I ∪ {p_2, …, p_e} (size 1 + l + (e-1) = e + l).
Colour each vertex by the parity of its layer. Edges only join equal or adjacent layers.
Within S: layer 0 and layers ≥ 2 contain one vertex each, layer 1 is I (independent);
so every edge of G[S] joins adjacent layers and has endpoints of different parity. ∎
More generally b(G) ≥ Σ_i α(L_i(v)) for every v (pick a max independent set per layer).

So the conjecture follows whenever some maximiser v* of l has ecc(v*) ≥ ⌊avgEcc⌋.
The hard case: the vertex with the largest l is central (small ecc) while avgEcc is big.

Reproduction (Phase A.6): `small.py 8` (own vertex-addition generator, canonical form by
colour refinement + permutations inside cells, exact Fractions):
n=2..8 connected counts 1,2,6,21,112,853,11117 (total 12112), 0 failures, tight 4839.
Matches the problem file.

## Phase B (short): decision

Instead of a long counterexample search I found a paper proof (below) during Phase A,
so Phase B is only a random check of its two lemmas (`lemmas.py`, n ≤ 12,
2 × 3000 random graphs, see lemmas*.out). Decision: spend the time on Lean.

## Phase C: proof on paper

Notation: d = graph distance, e(v) = ecc(v), D = max_v e(v) (diameter), l(v) = α(G[N(v)]),
n = |V| ≥ 2, G connected.

Lemma 1 (geodesic interpolation; proved on paper). If i ≤ d(v,y) there is w with
d(v,w) = i and d(w,y) = d(v,y) - i. (Take vertex i of a shortest walk.)

Lemma 2 (layer colouring; proved on paper). If S ⊆ V and no two vertices of S at the same
distance from v are adjacent, then G[S] is bipartite: colour w by d(v,w) mod 2; adjacent
vertices have distances differing by ≤ 1, and by hypothesis not by 0.

Lemma 3 (key; proved on paper). For all v, x, y, with a = d(v,x), c = d(v,y),
t = a + c - d(x,y) ≥ 0:   b ≥ l(v) + c + max(0, a - t - 1).
Proof. I ⊆ N(v) independent, |I| = l(v). For 2 ≤ i ≤ c pick y_i with d(v,y_i)=i,
d(y_i,y)=c-i; for t+2 ≤ i ≤ a pick x_i with d(v,x_i)=i, d(x_i,x)=a-i (Lemma 1).
For such i, x_i ≠ y_i and x_i ≁ y_i: otherwise d(x,y) ≤ (a-i)+1+(c-i), i.e. 2i ≤ t+1,
contradicting i ≥ t+2. S = {v} ∪ I ∪ {y_i} ∪ {x_i}. Layers: v is layer 0, I is layer 1
(independent), layer i ≥ 2 contains y_i and possibly x_i (non-adjacent). Lemma 2 ⇒ G[S]
bipartite. The four parts are pairwise disjoint (layers; x_i ≠ y_i), y and x are injective
(distinct layers), so |S| = 1 + l(v) + (c-1)^+ + (a-t-1)^+ ≥ l(v) + c + (a-t-1)^+. ∎

Corollaries: (A) x = v gives b ≥ l(v) + d(v,y). (B) b ≥ l(v) + d(x,y) - 1 for all x, y
(if c ≤ d(x,y): a - t - 1 = d(x,y) - c - 1).

Theorem. Let v* maximise l, and let x, y with d(x,y) = D.
If e(v*) = D: Σ e ≤ nD so ⌊avg + l(v*)⌋ ≤ D + l(v*) ≤ b by (A) with y far from v*.
If e(v*) < D: Σ e ≤ nD - 1 < nD so avg < D, ⌊avg + l⌋ ≤ D - 1 + l ≤ b by (B). ∎
All lemmas: proved on paper. Formalizing.
