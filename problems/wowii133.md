# Graffiti.pc 133: radius and induced paths

- id: `wowii133`
- source: `.lake/packages/formal_conjectures/FormalConjectures/WrittenOnTheWallII/GraphConjecture133.lean`
- theorem: `conjecture133`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
WOWII [Conjecture 133](http://cms.dt.uh.edu/faculty/delavinae/research/wowII/):

For a simple connected graph $G$,
$\operatorname{path}(G) \ge \operatorname{rad}(G) +
(\mathrm{avg}_v\, l(v))^{cC_4(G)}$,
where $\operatorname{path}(G)$ is the path number of the graph (number of vertices of a largest induced path),
$\operatorname{rad}(G)$ is the radius (minimum eccentricity, as a natural number),
$\mathrm{avg}_v\, l(v) = l(G)$ is the average independence number of vertex
neighbourhoods, and $cC_4(G)$ is the $C_4$-free characteristic function
(1 if $G$ is $C_4$-free, not necessarily induced, and 0 otherwise).
-/
@[category research open, AMS 5]
theorem conjecture133 (G : SimpleGraph α) [DecidableRel G.Adj] (h : G.Connected) :
    let rad := G.radius.toNat
    let hasC4 := ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a
    let cC4 : ℕ := if hasC4 then 0 else 1
    (rad : ℝ) + l G ^ cC4 ≤ (path G : ℝ) := by
  sorry
```

## Plain statement

In a connected graph, the radius plus a number that is 1 if the graph contains a 4-cycle (otherwise the average 'neighbourhood independence') is at most the length of the longest induced path.

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
Claim 133: rad(G) + (hasC4 ? 1 : l(G)) <= path(G).

## Checked so far (Python, 2026-10-04, not a proof)

Python, exact: all 273,192 connected graphs on 2..9 vertices: 0 failures (n<=8: 126 of 12,112 tight). Structured graphs including C5[K4] (n=20), Petersen, Paley13: 0 failures.

## Attack ideas

Counterexample search in C4-free graphs (trees, girth>=5 graphs, Petersen-like) where l(G) is large but induced paths are short: e.g. high-degree C4-free graphs of small diameter.

## Risks and notes

Machine-generated, open. The exponent cC4 is a natural number in Lean (0 or 1), matching the docstring.
