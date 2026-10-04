# Zero forcing versus independence number in subcubic graphs

- id: `txgraffiti2`
- source: `.lake/packages/formal_conjectures/FormalConjectures/Arxiv/2507.17780/2.lean`
- theorem: `tx_graffiti_conjecture_2`
- kind: graph

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
TxGraffiti [Conjecture 2](https://arxiv.org/abs/2507.17780):
for every connected graph $G$ with $\Delta(G) \le 3$ and $G \ne K_4$,
$$Z(G) \le \alpha(G) + 1.$$

This conjecture is **open**.
-/
@[category research open, AMS 5]
theorem tx_graffiti_conjecture_2 (V : Type) [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) [DecidableRel G.Adj] (_hConn : G.Connected)
    (_hDeg : G.maxDegree ≤ 3) (_hNotK4 : G = ⊤ → Fintype.card V ≠ 4) :
    zeroForcingNumber G ≤ G.indepNum + 1 := by
  sorry
```

## Plain statement

In a connected graph where no dot has more than 3 neighbours, other than the 4-dot complete graph, the 'zero forcing number' is at most 1 plus the size of the largest group of dots that are pairwise unconnected.

## Definitions

Zero forcing: colour some starting set S of dots black; repeatedly, if a black dot has exactly one non-black neighbour, that neighbour turns black; S is zero forcing if all dots end black. Z(G) = size of the smallest zero forcing set. alpha(G) = size of the largest set of pairwise non-adjacent dots. Claim: connected, max degree <= 3, G not the complete graph on 4 dots => Z(G) <= alpha(G)+1. (K4 has Z=3, alpha=1, which is why it is excluded.)

## Checked so far (Python, 2026-10-04, not a proof)

Python: all 2,570 connected graphs with max degree <= 3 on 1..10 vertices except K4 (counts 1,1,2,5,10,29,64,194,531,1733): 0 failures. K4 itself gives Z=3 > alpha+1=2 as expected.

## Attack ideas

Search connected graphs with maximum degree 3 on 11-16 vertices (geng -D3 style or random cubic/subcubic) for Z(G) > alpha(G)+1; or prove it for cubic graphs by building zero forcing sets from independent sets.

## Risks and notes

Open since 2017. Lean zero forcing uses card V iterations of the colour-change step, which is enough. The exception encoded as 'G = top -> card V <> 4' is exact.
