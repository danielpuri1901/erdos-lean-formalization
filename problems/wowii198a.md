# Graffiti.pc 198a: Hamiltonian path

- id: `wowii198a`
- source: `.lake/packages/formal_conjectures/FormalConjectures/WrittenOnTheWallII/GraphConjecture198a.lean`
- theorem: `conjecture198a`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
WOWII [Conjecture 198a](http://cms.dt.uh.edu/faculty/delavinae/research/wowII/)

For a simple connected graph `G`, if `b(G) ≤ 2 + ecc_avg(G)`, then `G` has a Hamiltonian path.
Here `b(G)` is the number of vertices in a largest induced bipartite subgraph, and
`ecc_avg(G)` is the average eccentricity of `G`.
A Hamiltonian path is a walk visiting every vertex exactly once.
-/
@[category research open, AMS 5]
theorem conjecture198a (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G) :
    ∃ a b : α, ∃ p : G.Walk a b, p.IsHamiltonian := by
  sorry
```

## Plain statement

If a connected graph is 'nearly bipartite' (its largest 2-colourable induced piece has at most 2 + the average eccentricity vertices), then it has a path visiting every vertex exactly once.

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
Claim 198a: if b(G) <= 2 + avgEcc(G) then G has a Hamiltonian path (a path through all n vertices).

## Checked so far (Python, 2026-10-04, not a proof)

Python, exact: all 273,192 connected graphs on 2..9 vertices (1,2,6,21,112,853,11,117,261,080 per n): 0 failures. On n<=8, 516 graphs satisfy the hypothesis and all have a Hamiltonian path. 16 structured larger graphs (C5[K2], C5[K3], C7[K2], Petersen, Q4, Paley13, grids, circulants ...): 0 failures.

## Attack ideas

Counterexample search: connected graphs with no Hamiltonian path (stars, trees, double-broom graphs, cut-vertex joins) while keeping b small relative to average eccentricity; or prove that the hypothesis forces few cut vertices.

## Risks and notes

Machine-generated (Graffiti.pc) conjecture, status open. Lean 'Walk.IsHamiltonian' is a Hamiltonian path (count of each vertex in support is 1). Statement carries Nontrivial (n>=2).
