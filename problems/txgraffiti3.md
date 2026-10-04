# Independent domination versus saturation number in regular graphs

- id: `txgraffiti3`
- source: `.lake/packages/formal_conjectures/FormalConjectures/Arxiv/2507.17780/3.lean`
- theorem: `tx_graffiti_conjecture_3`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
TxGraffiti [Conjecture 3](https://arxiv.org/abs/2507.17780):
for every $r$-regular graph $G$ ($r \ge 1$),
$$i(G) \le \mu^*(G).$$

This conjecture is **open**.
-/
@[category research open, AMS 5]
theorem tx_graffiti_conjecture_3 (V : Type) [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) [DecidableRel G.Adj]
    (r : ℕ) (_hReg : ∀ v, G.degree v = r) (_hr : 1 ≤ r) :
    G.indepDominationNumber ≤ G.saturationNumber := by
  sorry
```

## Plain statement

In a graph where every dot has the same number r (at least 1) of neighbours, the smallest group of dots that are pairwise unconnected yet touch every other dot is never bigger than the smallest 'stuck' set of disjoint edges (a set of edges sharing no dot, to which no further edge can be added).

## Definitions

G finite simple graph, every vertex has degree r >= 1 (G need not be connected). i(G): minimum |D| over sets D with no edge inside D and every vertex outside D having a neighbour in D. mu*(G) (saturation number): minimum |M| over maximal matchings M, i.e. sets of pairwise vertex-disjoint edges such that every edge of G shares an endpoint with an edge of M. Claim: i(G) <= mu*(G). For the cycle C_n (r=2) both equal ceil(n/3).

## Checked so far (Python, 2026-10-04, not a proof)

Python: all regular graphs with r>=1 on at most 9 vertices (65 isomorphism classes, disconnected included): 0 failures. 40,560 random regular graphs (r=3,4,5,6,7, n=10..16): 0 failures. i(C_n)=mu*(C_n) for n=3..12 (equality).

## Attack ideas

Search regular graphs (cubic graphs on 18+ vertices with geng-like generation, random 4- and 5-regular graphs, structured families) for i(G) > mu*(G). Useful bound: mu*(G) >= n*r/(2(2r-1)) for r-regular graphs (derived by counting edges at uncovered vertices); a proof would compare it with a matching upper bound on i(G).

## Risks and notes

Machine-generated, open since 2020. Equality for cycles suggests the bound is delicate. Exact i and mu* are NP-hard but fine at demo size.
