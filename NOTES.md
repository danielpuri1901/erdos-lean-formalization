# ramsey44: R(4, 4) = 18

## Statement
`SimpleGraph.classicalRamsey 4 4 = 18`. `RamseyNumbers.classicalRamsey_eq_sInf` turns the left side into
`sInf {n | IsGraphRamsey n 4 4}` with `IsGraphRamsey n k l := ∀ G : SimpleGraph (Fin n), ¬(G.CliqueFree k ∧ Gᶜ.CliqueFree l)`.
So it suffices to show `IsGraphRamsey 18 4 4` and `¬ IsGraphRamsey 17 4 4` (monotonicity via `IsGraphRamsey.succ`).

## Argument
Work inside one graph `G : SimpleGraph V` with finsets. `Good G k l s := (∃ t ⊆ s, G.IsNClique k t) ∨ (∃ t ⊆ s, Gᶜ.IsNClique l t)`.

- `good_mono`: `s ⊆ s'` and `Good G k l s` give `Good G k l s'`.
- `good_symm`: `Good G k l s ↔ Good Gᶜ l k s` (`compl_compl`).
- `good_two`: `l ≤ #s → Good G 2 l s` (an `l`-subset either has an edge or is independent).
- Vertex lemma: for `v ∈ s`, with `N = (s.erase v).filter (G.Adj v)` and `M = (s.erase v).filter (¬ G.Adj v ·)`,
  `Good G k (l+1) N → Good G (k+1) (l+1) s` (insert `v` into a `k`-clique) and
  `Good G (k+1) l M → Good G (k+1) (l+1) s` (insert `v` into an independent `l`-set). `#N + #M = #s - 1`.
- Step: hypotheses for all finsets of size `≥ a` and `≥ b` give `Good G (k+1) (l+1) s` for `#s ≥ a + b`.
- R(3,3) ≤ 6 from `good_two` twice; R(3,4) ≤ 9: in a bad 9-set every vertex has `#N ≤ 3` (R(2,4) ≤ 4)
  and `#M ≤ 5` (R(3,3) ≤ 6), so `#N = 3` for all 9 vertices; the sum of these is 27, but the sum is even
  (count ordered adjacent pairs in `ZMod 2` with `Finset.sum_involution` and `Prod.swap`).
- R(4,4) ≤ 18 from the step with a = b = 9 (and `good_symm` for R(4,3)).
- Lower bound: Paley graph on `Fin 17`, adjacency `(j - i) mod 17 ∈ {1,2,4,8,9,13,15,16}`.
  No 4-clique and no independent 4-set checked by `decide +kernel` on a quantified statement over `Fin 17`,
  and `not_cliqueFree_iff_top_isContained` turns a 4-clique into four pairwise adjacent vertices.

## Decisions
- Finset-level proofs inside one graph (no induced subgraphs), so the step lemma is reused for every bound.
- Paley checks live in `Solution/Paley.lean` so edits to the main file do not rerun them.

## Status
- Checker verdict on 4f8fbae: `comparator/ramsey44` success ("Your solution is okay!").

- Complete: `Solution.lean` (upper bound, sInf argument) and `Solution/Paley.lean` (lower bound) build with no `sorry`;
  `#print axioms ramsey_4_4` gives `propext`, `Classical.choice`, `Quot.sound`.
- Paley checks: Bool checkers `noK4`, `noI4` over `List.range 17` with Nat adjacency `padj` (bitmask 107286),
  `decide +kernel` on `noK4 = true`, then soundness by peeling `List.all_eq_true`.
  The same check stated as `∀ a b c d : Fin 17, ...` with `decide +kernel` peaked at 9.9 GB; the Bool version stays at the
  import baseline (about 7 GB RSS, mostly mmapped oleans; an import-only file shows the same).
