# Task queue

One line per task. Status is one of: todo, running, blocked, done.

| id | target | scope | status |
|----|--------|-------|--------|
| T0 | trivial | checker pipeline proof | done |
| E105 | erdos105 | prove `erdos_105_sub_four_false` with the lemma plan below | running |

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
