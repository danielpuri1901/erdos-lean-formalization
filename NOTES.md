# NOTES: sqtuples (`maximalLength_ge_of_isSquare`)

## Argument

Let n = m^2, so `n.sqrt = m`.
Index triples by (x, y, z) ∈ {0..m-1}^3 in lexicographic order and put

  T(x, y, z) = (m x + y + 1, m x + z + 1, m y + z + 1).

Every entry lies in 1..m^2, since m x + y + 1 ≤ m x + m = m (x + 1) ≤ m^2.
For (x, y, z) <lex (x', y', z'):

- x < x': coordinates 0 and 1 grow (m x + y < m (x + 1) ≤ m x').
- x = x', y < y': coordinates 0 and 2 grow.
- x = x', y = y', z < z': coordinates 1 and 2 grow.

So the list has length m^3 and is 2-increasing.
Checked by computation for m = 1..5 (`scratchpad/check.py`, all pairs).

`maximalLength n` is `sSup S` in ℕ, so `le_csSup` needs `BddAbove S`.
The bound: every element of S is at most n^2 (for n ≥ 2 by the pigeonhole lemma
`exists_pair_of_mem_Icc` from the problem file, as in its proof of `maximalLength_le`).
The cases m = 0 (trivial) and m = 1 (`maximalLength_one`) are separate.

## Plan

1. `T`, `L m` (nested `List.flatMap` over `List.range m`).
2. Lemmas: `length_L`, `range_L`, three `lt₂` lemmas, `pairwise_L` via `List.pairwise_flatMap`.
3. `bdd`: `BddAbove S` for n ≥ 2.
4. Main theorem: `obtain ⟨m, rfl⟩ := h`, `Nat.sqrt_eq`, cases on m.

## State

- Proof complete in `Solution.lean`; `lake build Solution` passes with no warnings (about 11 s).
- `#print axioms increasing_triples_square`: `[propext, Classical.choice, Quot.sound]`.
- `example : type_of% @increasing_triples_square = type_of% @Arxiv.«1609.08688».maximalLength_ge_of_isSquare := rfl` checks.
- No `decide`, so no large kernel checks; memory is not a concern.
- Submitted: commit `b3b3a7b6db898492cbcfe343bbee287f2a110866` (`submit(sqtuples): ...`), pushed to `run/sqtuples`.
- Verdict: not polled. The checker was paused on 2026-10-04, so per the user's instruction this session did not poll
  `comparator/sqtuples`. The status on that commit is unknown; the next session should read it with
  `gh api repos/danielpuri1901/erdos-lean-formalization/commits/b3b3a7b6db898492cbcfe343bbee287f2a110866/status`
  and, on failure, read the description, fix and resubmit.
- Nothing is missing on the Lean side: there is no `sorry` and the build is clean.
