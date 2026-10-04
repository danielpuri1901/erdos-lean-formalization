# Graffiti.pc 61: induced forest, residue and diameter

- id: `wowii61`
- source: `.lake/packages/formal_conjectures/FormalConjectures/WrittenOnTheWallII/GraphConjecture61.lean`
- theorem: `conjecture61`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
WOWII [Conjecture 61](http://cms.dt.uh.edu/faculty/delavinae/research/wowII/)

For a simple connected graph $G$, the size $f(G)$ of a largest induced forest
satisfies $f(G) \ge \mathrm{residue}(G) + \lceil \mathrm{diam}(G) / 3 \rceil$,
where $\mathrm{residue}(G)$ is the Havel-Hakimi residue and $\mathrm{diam}(G)$
is the diameter of $G$.

See: Favaron, Mahéo, Saclé (1991) for the residue; DeLaVina's Graffiti.pc for the conjecture.
-/
@[category research open, AMS 5]
theorem conjecture61 (G : SimpleGraph α) [DecidableRel G.Adj] (h : G.Connected) :
    (residue G : ℝ) + ⌈(G.diam : ℝ) / 3⌉ ≤ (G.largestInducedForestSize : ℝ) := by
  sorry
```

## Plain statement

In a connected graph, the biggest set of dots with no cycle is at least the 'Havel-Hakimi residue' of the degree list plus the diameter divided by 3 (rounded up).

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
Claim 61: f(G) >= residue(G) + ceil(diam(G)/3).

## Checked so far (Python, 2026-10-04, not a proof)

Python, exact: all 273,192 connected graphs on 2..9 vertices: 0 failures (n<=8: 489 tight). Structured graphs (n=10..16): 0 failures.

## Attack ideas

Counterexample search over graphs with large diameter and large residue (long paths with dense blobs, lollipops, barbells) at n=10-16; residue is a classical lower bound for alpha so the conjecture strengthens alpha <= f.

## Risks and notes

Machine-generated, open. Lean residue defined by well-founded Havel-Hakimi recursion (re-implemented). Note residue(G) <= alpha(G) <= f(G) already, so the extra ceil(diam/3) is the whole content.
