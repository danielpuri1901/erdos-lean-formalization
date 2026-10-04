# Graffiti.pc 100: independence number bound

- id: `wowii100`
- source: `.lake/packages/formal_conjectures/FormalConjectures/WrittenOnTheWallII/GraphConjecture100.lean`
- theorem: `conjecture100`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
WOWII [Conjecture 100](http://cms.uhd.edu/faculty/delavinae/research/wowII/all.html#conj100)
(status O):

For a simple connected graph `G`,
`α(G) ≤ ⌈(max_v l(v) + 0.5 · degreeL2Norm(Gᶜ)) / 2⌉`
where `α(G) = G.indepNum` is the independence number,
`max_v l(v)` is the maximum over all vertices of the independence number of
the neighbourhood (in `G`), and `degreeL2Norm(Gᶜ)` is the square root of the
sum of the squares of the degrees in the complement `Gᶜ`.
-/
@[category research open, AMS 5]
theorem conjecture100 (G : SimpleGraph α) [DecidableRel G.Adj] (h : G.Connected) :
    let maxL := (Finset.univ.image (indepNeighborsCard G)).max' (by simp)
    (G.indepNum : ℝ) ≤ ⌈((maxL : ℝ) + (1 / 2) * (degreeL2Norm Gᶜ : ℝ)) / 2⌉ := by
  sorry
```

## Plain statement

In a connected graph, the size of the biggest set of pairwise unconnected dots is at most half of (the largest neighbourhood-independence + half the 'length' of the complement graph's degree list), rounded up.

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
Claim 100: alpha(G) <= ceil( (maxl + 0.5*degL2(complement)) / 2 ). Exact test used: with m=maxl and S=sum_v (n-1-deg v)^2, claim holds iff 2*alpha-2-m < 0 or S > 4*(2*alpha-2-m)^2.

## Checked so far (Python, 2026-10-04, not a proof)

Python, exact: all 273,192 connected graphs on 2..9 vertices: 0 failures (n<=8: 784 of 12,112 tight). Structured graphs incl. C5[K2], C5[K3], C5[K4] (n=20), C7[K2], Petersen, Paley13, Q4, Clebsch, grids: 0 failures.

## Attack ideas

Counterexample search with structured graphs (blow-ups such as C5[K4], Kneser graphs, strongly regular graphs) that are known to break similar Graffiti conjectures; or prove via alpha <= n - maxdeg type bounds.

## Risks and notes

Machine-generated, open. Docstring says the source had a dropped overline (length of the complement); the Lean uses the complement, matching the stated reading.
