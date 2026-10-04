# Graffiti.pc 40: induced forest bound

- id: `wowii40`
- source: `.lake/packages/formal_conjectures/FormalConjectures/WrittenOnTheWallII/GraphConjecture40.lean`
- theorem: `conjecture40`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
WOWII [Conjecture 40](http://cms.dt.uh.edu/faculty/delavinae/research/wowII/)

For a nontrivial connected graph `G` the size `f(G)` of a largest induced forest
satisfies `f(G) ≥ ceil((p(G) + b(G) + 1)/2)` where `p(G)` is the path cover
number and `b(G)` is the largest induced bipartite subgraph size.
-/
@[category research open, AMS 5]
theorem conjecture40 (h_conn : G.Connected) (h_nontrivial : 1 < Fintype.card α) :
    ⌈(((pathCoverNumber G : ℝ) + b G + 1) / 2)⌉ ≤  G.largestInducedForestSize := by
  sorry
```

## Plain statement

In a connected graph with at least 2 vertices, the biggest set of dots containing no cycle is at least half of (the fewest paths covering all dots + the biggest 2-colourable induced piece + 1), rounded up.

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
Claim 40: f(G) >= ceil( (pathCover(G) + b(G) + 1) / 2 ).

## Checked so far (Python, 2026-10-04, not a proof)

Python, exact: all 273,192 connected graphs on 2..9 vertices: 0 failures (n<=8: 832 of 12,112 graphs are tight, i.e. equality).

## Attack ideas

Counterexample search among larger graphs (n=10-14) using a fast exact solver, or random/structured graphs with a large path cover number (stars, spiders) and small induced forests; a proof would bound pathCover by f.

## Risks and notes

Machine-generated, open. Lean uses sSup/sInf definitions; these were re-implemented from the Lean source (path cover = vertex-disjoint paths, single vertices allowed).
