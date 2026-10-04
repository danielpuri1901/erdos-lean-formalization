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
