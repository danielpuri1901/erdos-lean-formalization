# Graffiti.pc 19: induced bipartite bound

- id: `wowii19`
- source: `.lake/packages/formal_conjectures/FormalConjectures/WrittenOnTheWallII/GraphConjecture19.lean`
- theorem: `conjecture19`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
WOWII [Conjecture 19](http://cms.dt.uh.edu/faculty/delavinae/research/wowII/)

If `G` is connected then the size `b(G)` of a largest induced bipartite subgraph
satisfies
`b(G) ≥ FLOOR((∑ ecc(v))/(|V|) + sSup (range (l G)))`, where `ecc(v)` denotes
eccentricity and `l(G)` is the independence number of neighbourhoods.
-/
@[category research open, AMS 5]
theorem conjecture19 (G : SimpleGraph α) [Nontrivial α] (h_conn : G.Connected) :
    ⌊(∑ v ∈ Finset.univ, ((G.eccent v).toNat : ℝ)) / (Fintype.card α : ℝ) +
      sSup (Set.range (indepNeighbors G))⌋ ≤ b G := by
  sorry
```

## Plain statement

In a connected graph, the biggest 2-colourable induced piece is at least the average eccentricity plus the largest 'neighbourhood independence' of any dot, rounded down.

## Definitions

All graphs are simple (no loops, no multi-edges), finite, connected, with at least 2 vertices; n = number of vertices.
alpha(G): size of a largest set of pairwise non-adjacent vertices.
l(v): alpha of the subgraph induced on the neighbours of v (0 if v has no neighbours); maxl = max_v l(v); l(G) = (sum_v l(v))/n (a fraction).
dist(u,v): shortest-path length; ecc(v)=max_u dist(v,u); rad=min_v ecc(v); diam=max_v ecc(v); avgEcc=(sum_v ecc(v))/n.
b(G): largest |S| such that the subgraph induced on S can be 2-coloured (no odd cycle). f(G): largest |S| such that the subgraph induced on S has no cycle.
path(G): largest k such that vertices v1..vk are distinct and vi~vj exactly when |i-j|=1 (induced path; a single vertex counts, k=1).
pathCover(G): fewest vertex-disjoint paths (each a path in G, a single vertex allowed) whose vertex sets together cover all vertices.
residue(G): take the degree list sorted largest first; repeat: if the list is empty return 0; if the first entry is 0 return the length of the list; else remove the first entry d, subtract 1 (not below 0) from the next d entries (all of them if fewer), re-sort largest first.
degL2(complement) = sqrt( sum_v (n-1-deg(v))^2 ).
hasC4: some two vertices have at least 2 common neighbours (a 4-cycle, not necessarily induced).
Claim 19: b(G) >= floor( avgEcc(G) + maxl ).

## Checked so far (Python, 2026-10-04, not a proof)

Python, exact: all 273,192 connected graphs on 2..9 vertices: 0 failures (n<=8: 4,839 of 12,112 tight).

## Attack ideas

Counterexample search on graphs where eccentricities are large and some dot has independent neighbours but induced bipartite pieces are small (dense graphs with a long tail); proof idea: bound b by n - (odd-cycle transversal).

## Risks and notes

Machine-generated, open. Lean uses sSup over range of indepNeighbors (finite, fine).
