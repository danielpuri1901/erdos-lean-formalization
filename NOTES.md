# txgraffiti2: notes

## Graph

`data/txgraffiti2/H24.edgelist`, from M. Fischer, arXiv 2607.23664.
Centre triangle C = {0, 1, 2}; r_j = 3 + j is joined to c_j = j.
Copy k (k = 0..5) of K3 is z = 6 + 3k, a = 7 + 3k, b = 8 + 3k, with z joined to r_(k div 2).
Branch j is B_j = {r_j} ∪ copies 2j and 2j+1 (7 vertices).

## Argument (decision: forts only, no forcing simulation)

A fort is a nonempty F such that every vertex outside F has 0 or at least 2 neighbours in F.
Fort lemma: a zero forcing set S meets every fort.
(If S misses F, induction shows every iterate of `zeroForcingStep` misses F: a vertex v of the
current set forcing w ∈ F lies outside F, so it has a second neighbour u ∈ F, also uncoloured,
and the rule needs u = w.  The closure is `univ`, which meets F.)

Forts used (84):

- Local forts of branch j (12): with T1 = {z1,a1,b1}, T2 = {z2,a2,b2} its two triangles,
  {a1,b1}, {a2,b2}, {a1,b1,a2,b2}, and X1 ∪ X2 for X1 ∈ {z1a1, z1b1, z1a1b1}, X2 likewise.
- E-sets of branch j (4, not forts themselves): {z1,a1}, {z1,b1}, {z2,a2}, {z2,b2}.
- Global forts (48): {c_i, c_j} ∪ e ∪ e' for i < j, e an E-set of branch i, e' one of branch j.
  (c_k, k ≠ i,j, sees 2; r_i sees c_i and z; the third vertex of the triangle of e sees 2.)

Local lemma (128 subsets T of B_j, by `decide`): if T meets the 12 local forts then
|T| ≥ 3 + [T meets all four E-sets of branch j].

Pair lemma: for i < j, from the global forts,
c_i ∈ S ∨ c_j ∈ S ∨ S meets all E-sets of branch i ∨ S meets all E-sets of branch j.

Count: |S| = Σ_j |S ∩ B_j| + |S ∩ C| ≥ Σ_j (3 + [allE_j] + [c_j ∈ S]) and the pair lemma says at
most one j has both brackets 0, so |S| ≥ 9 + 2 = 11.  Python (`check` in the session scratchpad)
confirmed: all 84 forts are forts, the local lemma holds, and no 10-set meets all 84.

Independence: the 9 cliques (6 copies of K3 and the 3 edges c_j r_j) cover V, so α ≤ 9.
Connected: every vertex v ≠ 0 has a neighbour with a smaller label.
Max degree: `decide` on all 24 degrees.

Final: 11 ≤ Z ≤ α + 1 ≤ 10.

## Plan

1. Skeleton in `Solution.lean` with `sorry`s; build.
2. Fill: graph facts, fort lemma, decide lemmas, counting, final.
3. Submit with `submit(txgraffiti2):`.

## Status

`Solution.lean` is complete: no `sorry`, axioms `propext`, `Classical.choice`, `Quot.sound`;
`lake build Solution` takes about 20 s.
All finite checks are `decide +kernel` on `Bool` functions over `List Nat` (forts as label lists,
adjacency as bitmasks, branch subsets as `List.sublists`), bridged to `Finset (Fin 24)` by
`fortB_sound`, `sb`, `card_eq`.
A first try with `Finset (Fin 24)` literals and `powerset` inside `decide +kernel` hit
"(kernel) deep recursion" and took 388 s; it was dropped.

Checker verdict on commit 054976a (`submit(txgraffiti2):`): `comparator/txgraffiti2` success, "Your solution is okay!".
