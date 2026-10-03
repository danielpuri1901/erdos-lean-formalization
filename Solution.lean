import FormalConjectures.ErdosProblems.«105»

/-! Solution for the erdos105 target: Xichuan's 10 plus 6 point counterexample, stored in `data/erdos105.json`. -/

open EuclideanGeometry

theorem erdos_105_sub_four_false :
    ¬ ∀ A B : Finset ℝ², Disjoint A B → A.card = B.card + 4 →
      ¬ Collinear ℝ (A : Set ℝ²) →
      ∃ p ∈ A, ∃ q ∈ A, p ≠ q ∧ ∀ b ∈ B, b ∉ line[ℝ, p, q] := by
  sorry
