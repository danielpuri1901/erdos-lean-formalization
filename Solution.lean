import FormalConjectures.Wikipedia.GaussCircleProblem

/-! Solution for the gausscircle target. See `TASK.md` and `NOTES.md`.

Gauss's area argument: the half-open unit squares centred at the lattice points of the closed
disc of radius `r` have total area `N r`, contain the disc of radius `r - √2/2` and lie in the
closed disc of radius `r + √2/2`. -/

open MeasureTheory Metric Filter

open scoped EuclideanGeometry Real

namespace GaussCircleSol

/-- Rounding to the nearest lattice point (halves round up). -/
noncomputable def rnd (x : EuclideanSpace ℝ (Fin 2)) : ℤ × ℤ :=
  (⌊x 0 + 1 / 2⌋, ⌊x 1 + 1 / 2⌋)

/-- The lattice point `z` as a point of the plane. -/
noncomputable def pt (z : ℤ × ℤ) : EuclideanSpace ℝ (Fin 2) := !₂[(z.1 : ℝ), (z.2 : ℝ)]

/-- The lattice points of the closed disc of radius `r`. -/
def P (r : ℝ) : Set (ℤ × ℤ) := {z | pt z ∈ closedBall (0 : EuclideanSpace ℝ (Fin 2)) r}

lemma N_eq (r : ℝ) : GaussCircleProblem.N r = (P r).ncard := by
  sorry

lemma dist_rnd_le (x : EuclideanSpace ℝ (Fin 2)) : ‖x - pt (rnd x)‖ ≤ √2 / 2 := by
  sorry

lemma measurableSet_fibre (z : ℤ × ℤ) : MeasurableSet (rnd ⁻¹' {z}) := by
  sorry

lemma volume_fibre (z : ℤ × ℤ) : volume (rnd ⁻¹' {z}) = 1 := by
  sorry

lemma P_finite (r : ℝ) : (P r).Finite := by
  sorry

lemma volume_preimage_P (r : ℝ) : volume (rnd ⁻¹' P r) = (P r).ncard := by
  sorry

lemma ball_subset (r : ℝ) : ball (0 : EuclideanSpace ℝ (Fin 2)) (r - √2 / 2) ⊆ rnd ⁻¹' P r := by
  sorry

lemma subset_closedBall (r : ℝ) :
    rnd ⁻¹' P r ⊆ closedBall (0 : EuclideanSpace ℝ (Fin 2)) (r + √2 / 2) := by
  sorry

lemma card_le (r : ℝ) (hr : 0 ≤ r) : ((P r).ncard : ℝ) ≤ π * (r + √2 / 2) ^ 2 := by
  sorry

lemma le_card (r : ℝ) (hr : √2 / 2 ≤ r) : π * (r - √2 / 2) ^ 2 ≤ (P r).ncard := by
  sorry

end GaussCircleSol

theorem gauss_circle_error_le : type_of% @GaussCircleProblem.error_le := by
  sorry
