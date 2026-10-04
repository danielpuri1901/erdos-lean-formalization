# ramsey34 notes

Goal: `SimpleGraph.classicalRamsey 3 4 = 9`, via `RamseyNumbers.classicalRamsey_eq_sInf`
(`= sInf {n | IsGraphRamsey n 3 4}`).

## Argument

Upper bound (`IsGraphRamsey 9 3 4`), reused from `origin/run/ramsey35` (`Solution/Upper.lean`).
One graph `G` on a type `V`, finsets `S`. `Indep G I`: no edge inside `I`.
`HasIndep G k m`: every `S` with `m ≤ #S` has an independent `I ⊆ S` with `#I = k`.
Assume `G` triangle-free.

- `step`: `HasIndep G k m → HasIndep G (k+1) (m+k+1)` (split `S.erase v` into neighbours and
  non-neighbours of `v`; neighbours are independent).
- `HasIndep G 1 1`, then `HasIndep G 2 3`, `HasIndep G 3 6`.
- `HasIndep G 4 9`: `#S ≥ 10` by `step`; `#S = 9` with no independent 4-set forces every vertex
  to have exactly 3 neighbours in `S` (≤ 3 neighbours, ≤ 5 non-neighbours), so the degree sum
  is 27, odd, but it counts ordered adjacent pairs, which is even.
- Apply to `univ : Finset (Fin 9)`.

Lower bound (`¬ IsGraphRamsey 8 3 4`): circulant graph on `Fin 8`, `i ~ j` iff
`(j - i) mod 8 ∈ {1, 4, 7}`. Checked in Python first: triangle-free, independence number 3.
In Lean: `decide +kernel` on nested pruned `∀` statements, bridged from `CliqueFree` via
`cliqueFree_iff` (pattern of `origin/run/ramsey35` `Solution/Lower.lean`). Only 8 vertices,
so the kernel checks are tiny.

`sInf`: `9 ∈ set` gives `≤`; for `n < 9` in the set, `IsGraphRamsey.succ` lifts it to 8.

## Decisions

- Reuse the ramsey35 files with the namespace `R34`, drop the R(3,5) step.
- Kernel checks in `Solution/Lower.lean`, upper bound in `Solution/Upper.lean`.
