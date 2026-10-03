# Task queue

One line per task. Status is one of: todo, running, blocked, done.

| id | target | scope | status |
|----|--------|-------|--------|
| T0 | trivial | checker pipeline proof | done |
| E105 | erdos105 | prove `erdos_105_sub_four_false` with the lemma plan below | done |
| G72 | green72 | prove `green72_no_three_in_line_le` with the lemma plan below | running |

## erdos105

Theorem: `erdos_105_sub_four_false`, frozen in `Challenge.lean`; the proof goes in `Solution.lean`.

Published proof to formalize: the explicit counterexample by Xichuan (erdosproblems.com forum, thread 105, post 8033).
`data/erdos105.json` stores it with exact integer coordinates: ten points A and six points B.
`python3 scripts/verify_erdos105.py` checks it: A is not collinear, |A| = |B| + 4, A and B are disjoint, and each of the 45 lines through two points of A contains a point of B.
So the universal statement fails for this A and B, which proves its negation.

Lemma plan:

1. Define A and B as `Finset ℝ²` (points of `EuclideanSpace ℝ (Fin 2)`) from `data/erdos105.json`, and prove `Disjoint A B`, `A.card = B.card + 4`, and `¬ Collinear ℝ (A : Set ℝ²)`.
2. Prove a lemma: for p, q, b in ℝ², if b = t • (q -ᵥ p) +ᵥ p for an explicit real t, then b ∈ line[ℝ, p, q].
3. For every pair p ≠ q in A, give the point b of B on their line and its t (the verifier finds them); then assemble `erdos_105_sub_four_false` by applying the universal statement to A and B.

## green72

Theorem: `green72_no_three_in_line_le`, frozen in `Challenge.lean`; the proof goes in `Solution.lean` and new modules under `Solution/`.

Published result to formalize: for every N from 3 to 60 the N by N grid holds 2N points with no three on a line.
The upper bound `Green72.allowedSetSize_le` is already proved in formal-conjectures.
The lower bound is one explicit witness per N: Flammenkamp's no-three-in-line database and Prellberg's Table 1, each witness re-verified with exact integer arithmetic (`data/green72/`, `scripts/witness.py`).
`Solution/Green72/Witnesses.lean` holds the 58 witness lists `w3` to `w60` and a Nat collinearity checker `noThree`; do not edit it, regenerate it with `python3 scripts/witness.py lean`.
`decide +kernel` checks `noThree w60 = true` in about 48 seconds and adds no axiom; `native_decide` is banned.

Lemma plan (the lemma statements are already in `Solution.lean` with `sorry`):

1. `cross_ne_of_noThree`: `noThree l = true` gives `collinear3 a b c = false` for three distinct points of a duplicate-free list.
2. `not_collinear_of_cross`: unequal Nat cross terms mean the three real points are not `Collinear ℝ` in `ℝ × ℝ`.
3. `allowedSet_of_witness`: a duplicate-free list in the grid that passes `noThree` is an `AllowedSet 3 N`.
4. `noKInLineFor_of_allowed`: an allowed set of size 2N gives `AllowedSetSize 3 N = 2 * N`, using `Green72.allowedSetSize_le` and `le_csSup`.
5. For each N, prove `noThree wN = true ∧ inGrid N wN = true ∧ wN.Nodup ∧ wN.length = 2 * N` by `decide +kernel` in its own module `Solution/Green72/W<N>.lean` (so `lake build` checks them in parallel and caches them), then finish `green72_no_three_in_line_le` with `interval_cases N`.
