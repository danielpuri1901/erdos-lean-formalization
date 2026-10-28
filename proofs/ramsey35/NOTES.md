# ramsey35 notes

Goal: `SimpleGraph.classicalRamsey 3 5 = 14`, via `RamseyNumbers.classicalRamsey_eq_sInf`
(`= sInf {n | IsGraphRamsey n 3 5}`).

## Argument

Upper bound (`IsGraphRamsey 14 3 5`). Work with one graph `G` on a type `V` and finsets `S`.
`Indep G I` : no edge inside `I`. `HasIndep G k m` : every `S` with `m ≤ #S` has an independent
`I ⊆ S` with `#I = k`. Assume `G` triangle-free.

- `step`: `HasIndep G k m → HasIndep G (k+1) (m+k+1)`. Pick `v ∈ S`; split `S.erase v` into
  neighbours `N` and non-neighbours `M` of `v`; `#N + #M ≥ m + k`. If `#N ≥ k+1`, `N` is
  independent (triangle-free), take a `k+1` subset. Else `#M ≥ m`, take `I ⊆ M`, add `v`.
- `HasIndep G 1 1` (singletons), so `HasIndep G 2 3`, `HasIndep G 3 6` by `step`.
- `HasIndep G 4 9`: if `#S ≥ 10` use `step` from `(3, 6)`. If `#S = 9` and no independent
  4-set: every `v ∈ S` has `#N_S(v) ≤ 3` and `#M_S(v) ≤ 5` (else R(3,3) in `M` plus `v`), so
  `#N_S(v) = 3`. Then `∑_{v∈S} #N_S(v) = 27`, but this sum is the number of ordered adjacent
  pairs in `S ×ˢ S`, which is even (swap involution, `Finset.sum_involution` in `ZMod 2`).
- `HasIndep G 5 14` by `step` from `(4, 9)`; apply to `univ` on `Fin 14`.

Lower bound (`¬ IsGraphRamsey 13 3 5`): circulant `C` on `Fin 13`, `i ~ j` iff
`(j - i) mod 13 ∈ {1, 5, 8, 12}`. Check triangle-free and no 5-clique in `Cᶜ` with
`decide +kernel` on nested pruned `∀` statements; bridge from `CliqueFree` via
`cliqueFree_iff` (a `Copy` of `K_n` gives `n` pairwise adjacent vertices).
Checked first in Python.

`sInf`: `14 ∈ set` gives `≤`; for `n < 14` in the set, `IsGraphRamsey.succ` lifts it to 13.

## Decisions

- Generic finset formulation instead of induced subgraphs on subtypes (avoids coercions).
- Lower-bound kernel check kept in `Solution/Lower.lean` so edits to the main file do not rerun it.

## Status

All proved, no `sorry`; `#print axioms ramsey_3_5` gives `propext, Classical.choice, Quot.sound`.
Build: `Solution.Lower` 33 s (kernel check), `Solution.Upper` 7 s, `Solution` 6 s.
