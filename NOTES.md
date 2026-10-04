# ramsey33 notes

Goal: `SimpleGraph.classicalRamsey 3 3 = 6`, via `RamseyNumbers.classicalRamsey_eq_sInf`
(`= sInf {n | IsGraphRamsey n 3 3}`).

## Argument

Upper bound (`IsGraphRamsey 6 3 3`), reused from `origin/run/ramsey34` (`Solution/Upper.lean`).
`Indep G I`: no edge inside `I`. `HasIndep G k m`: every `S` with `m ≤ #S` has an independent
`I ⊆ S` with `#I = k`. Assume `G` triangle-free.

- `step`: `HasIndep G k m → HasIndep G (k+1) (m+k+1)` (split `S.erase v` into neighbours and
  non-neighbours of `v`; neighbours are independent).
- `HasIndep G 1 1`, then `HasIndep G 2 3`, `HasIndep G 3 6`.
- Apply to `univ : Finset (Fin 6)`: an independent 3-set is a 3-clique of `Gᶜ`.

Lower bound (`¬ IsGraphRamsey 5 3 3`): the 5-cycle on `Fin 5`, `i ~ j` iff
`(j - i) mod 5 ∈ {1, 4}`. It has no triangle, and its complement (the pentagram, again a 5-cycle)
has no triangle. In Lean: `decide +kernel` on nested pruned `∀` statements over `Fin 5`, bridged
from `CliqueFree` via `cliqueFree_iff` (pattern of `origin/run/ramsey34` `Solution/Lower.lean`).

`sInf`: `6 ∈ set` gives `≤`; for `n < 6` in the set, `IsGraphRamsey.succ` lifts it to 5,
contradicting the lower bound.

## Decisions

- Reuse the ramsey34 files with the namespace `R33`, drop the R(3,4) parity step.
- Kernel checks in `Solution/Lower.lean`, upper bound in `Solution/Upper.lean`.

## Status

All proved, no `sorry`; `#print axioms ramsey_3_3` gives `propext, Classical.choice, Quot.sound`;
`type_of% @RamseyNumbers.ramsey_number_three_three = type_of% @ramsey_3_3` by `rfl`.
Build: `Solution.Lower` 8 s (two tiny `decide +kernel` checks on 5 vertices), `Solution.Upper` 7 s,
`Solution` 6 s.

## Verdict

Submitted commit `3bb9b1387aca7d94ef5c5db5f3995a52e4a13dad`; `comparator/ramsey33` reported
`success` ("Your solution is okay!") on 2026-10-04.
