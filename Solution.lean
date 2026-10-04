import FormalConjectures.GreensOpenProblems.«66»

/-! Solution for the green66 target. See `TASK.md` and `NOTES.md`. -/

namespace Green66Sol

/-- The greatest square below a nonnegative real is within `2 √r + 1` of it. -/
lemma floor_sq (r : ℝ) (hr : 0 ≤ r) :
    ∃ v : ℕ, (v : ℝ) ^ 2 ≤ r ∧ r - (v : ℝ) ^ 2 ≤ 2 * Real.sqrt r + 1 := by
  refine ⟨⌊Real.sqrt r⌋₊, ?_, ?_⟩
  · have h1 : (⌊Real.sqrt r⌋₊ : ℝ) ≤ Real.sqrt r := Nat.floor_le (Real.sqrt_nonneg r)
    have h0 : (0 : ℝ) ≤ (⌊Real.sqrt r⌋₊ : ℝ) := Nat.cast_nonneg _
    have hs : Real.sqrt r ^ 2 = r := Real.sq_sqrt hr
    nlinarith
  · have h1 : (⌊Real.sqrt r⌋₊ : ℝ) ≤ Real.sqrt r := Nat.floor_le (Real.sqrt_nonneg r)
    have h2 : Real.sqrt r < (⌊Real.sqrt r⌋₊ : ℝ) + 1 := Nat.lt_floor_add_one _
    have hs : Real.sqrt r ^ 2 = r := Real.sq_sqrt hr
    have h3 : (0 : ℝ) ≤ Real.sqrt r := Real.sqrt_nonneg r
    nlinarith

/-- Facts about `t = X ^ (1/4)` for `X ≥ 1`. -/
lemma quarter_facts (X : ℝ) (hX : 1 ≤ X) :
    1 ≤ X ^ (1 / 4 : ℝ) ∧ Real.sqrt X ≤ (X ^ (1 / 4 : ℝ)) ^ 2 := by
  sorry

lemma main_bound (X : ℝ) (hX : 1 ≤ X) :
    ∃ n : ℕ, Green66.IsSumOfTwoSquares n ∧
      (n : ℝ) ∈ Set.Icc (X - 5 * X ^ (1 / 4 : ℝ)) X := by
  sorry

end Green66Sol

theorem green66_trivial_bound : type_of% @Green66.green_66.variants.trivial_bound :=
  ⟨5, by norm_num, Filter.eventually_atTop.mpr ⟨1, fun X hX => Green66Sol.main_bound X hX⟩⟩
