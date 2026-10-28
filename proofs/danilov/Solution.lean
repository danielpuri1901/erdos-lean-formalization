import FormalConjectures.Wikipedia.Hall

/-! Solution for the danilov target. See `TASK.md` and `NOTES.md`. -/

namespace DanilovSol

/-- Solutions of `z ^ 2 + 1 = 5 * w ^ 2` with arbitrarily large `z`. -/
theorem pell_exists (N : Nat) :
    ∃ z w : ℤ, (N : ℤ) ≤ z ∧ 1 ≤ z ∧ 1 ≤ w ∧ z ^ 2 + 1 = 5 * w ^ 2 := by
  induction N with
  | zero => exact ⟨2, 1, by norm_num, by norm_num, by norm_num, by norm_num⟩
  | succ n ih =>
    obtain ⟨z, w, hn, hz, hw, h⟩ := ih
    refine ⟨9 * z + 20 * w, 4 * z + 9 * w, ?_, ?_, ?_, ?_⟩
    · push_cast; omega
    · omega
    · omega
    · linear_combination 1 * h

theorem key (z w : ℤ) (h : z ^ 2 + 1 = 5 * w ^ 2) :
    (25 * w * (z ^ 2 + 9 * z + 19)) ^ 2 - (5 * (z ^ 2 + 6 * z + 4)) ^ 3 = 3375 * (2 * z + 11) := by
  linear_combination (-125 * (z ^ 2 + 9 * z + 19) ^ 2) * h

end DanilovSol

open DanilovSol in
theorem hall_danilov : type_of% @Hall.danilov := by
  intro δ hδ ⟨C, hC, hI⟩
  obtain ⟨M, hM⟩ := Filter.eventually_atTop.mp
    ((tendsto_rpow_atTop hδ).eventually (Filter.eventually_ge_atTop (43875 / C)))
  obtain ⟨z, w, hzM, hz1, hw, hzw⟩ := pell_exists ⌈M⌉₊
  have hk := key z w hzw
  have hne : (25 * w * (z ^ 2 + 9 * z + 19)) ^ 2 ≠ (5 * (z ^ 2 + 6 * z + 4)) ^ 3 := by
    intro he; omega
  have h := hI (5 * (z ^ 2 + 6 * z + 4)) (25 * w * (z ^ 2 + 9 * z + 19)) hne
  rw [hk, abs_of_pos (by omega)] at h
  push_cast at h
  have hzr : (1 : ℝ) ≤ z := by exact_mod_cast hz1
  have hMz : M ≤ (z : ℝ) := by
    have h1 : M ≤ (⌈M⌉₊ : ℝ) := Nat.le_ceil M
    have h2 : ((⌈M⌉₊ : ℤ) : ℝ) ≤ (z : ℝ) := by exact_mod_cast hzM
    push_cast at h2
    linarith
  set X : ℝ := |5 * ((z : ℝ) ^ 2 + 6 * z + 4)| with hX
  have hX' : X = 5 * ((z : ℝ) ^ 2 + 6 * z + 4) := by
    rw [hX, abs_of_pos (by positivity)]
  have hXpos : 0 < X := by rw [hX']; positivity
  have hXz : (z : ℝ) ^ 2 ≤ X := by rw [hX']; nlinarith
  have hXM : M ≤ X := by nlinarith
  have hsq : (z : ℝ) ≤ X ^ (2⁻¹ : ℝ) := by
    have he : X ^ (2⁻¹ : ℝ) = √X := by rw [Real.sqrt_eq_rpow]; norm_num
    rw [he]
    exact Real.le_sqrt_of_sq_le hXz
  have hd : 43875 / C ≤ X ^ δ := hM X hXM
  have hsplit : X ^ (2⁻¹ + δ) = X ^ (2⁻¹ : ℝ) * X ^ δ := Real.rpow_add hXpos _ _
  rw [hsplit] at h
  have h43 : C * (43875 / C) = 43875 := by field_simp
  have hprod : (z : ℝ) * (43875 / C) ≤ X ^ (2⁻¹ : ℝ) * X ^ δ :=
    mul_le_mul hsq hd (by positivity) (by positivity)
  nlinarith
