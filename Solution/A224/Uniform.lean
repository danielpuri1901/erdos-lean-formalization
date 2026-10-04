import Solution.A224.P2QAlg

/-! a000224 deep attempt, building blocks for the uniform family `p^e q` (route Q4 in the notebook):
with `X = p^e` and `2(p+1)A = pX + c`, equation (E) forces `X ∣ F`, `F = k c² w² − 2k(p+1)c w + 4(p+1)²`,
and `F ≠ 0`; hence `p^e ≤ |F|`, which bounds `e` once `w` is bounded. -/

namespace A224Deep

/-- L1. `X ∣ F`. -/
theorem q4_dvd_F {p X A k w c : ℕ} (hA : 2 * (p + 1) * A = p * X + c) (hA1 : 1 ≤ A) (hX : 1 ≤ X)
    (hδ : k * A ^ 2 < 4 * X ^ 2)
    (hE : (4 * X ^ 2 - k * A ^ 2) * w ^ 2 + (X ^ 2 - 1) = (4 * X ^ 2 - k * A) * w) :
    (X : ℤ) ∣ (k : ℤ) * c ^ 2 * w ^ 2 - 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2 := by
  have h1 : k * A ^ 2 ≤ 4 * X ^ 2 := hδ.le
  have h2 : k * A ≤ 4 * X ^ 2 :=
    le_trans (Nat.mul_le_mul_left k (Nat.le_self_pow two_ne_zero A)) h1
  have h3 : 1 ≤ X ^ 2 := Nat.one_le_pow _ _ hX
  zify [h1, h2, h3] at hE
  have hA' : (2 * (p + 1) * A : ℤ) = p * X + c := by exact_mod_cast hA
  refine ⟨4 * ((p : ℤ) + 1) ^ 2 * X * (2 * w - 1) ^ 2 - k * p ^ 2 * X * w ^ 2
    - 2 * k * p * c * w ^ 2 + 2 * k * p * (p + 1) * w, ?_⟩
  linear_combination (-4 * ((p : ℤ) + 1) ^ 2) * hE
    - ((k : ℤ) * w ^ 2 * (2 * (p + 1) * A + p * X + c) - 2 * k * (p + 1) * w) * hA'

/-- L2. `F ≠ 0` when `c w > p + 1`. -/
theorem q4_F_ne_zero {p k w c : ℕ} (hc : p + 1 < c * w) :
    (k : ℤ) * c ^ 2 * w ^ 2 - 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2 ≠ 0 := by
  intro hF
  have hc' : ((p : ℤ) + 1) < (c : ℤ) * w := by exact_mod_cast hc
  have hs : 0 < (c : ℤ) * w - (p + 1) := by linarith
  have ht : (0 : ℤ) < (p : ℤ) + 1 := by positivity
  have hid : (k : ℤ) * ((c : ℤ) * w - (p + 1)) ^ 2 + (4 - k) * ((p : ℤ) + 1) ^ 2 = 0 := by
    rw [← hF]; ring
  generalize hS : (c : ℤ) * w - (p + 1) = S at hs hid
  generalize hT : (p : ℤ) + 1 = T at ht hid
  rcases Nat.lt_trichotomy k 4 with hk | hk | hk
  · have hk' : (k : ℤ) ≤ 3 := by exact_mod_cast (by omega : k ≤ 3)
    have hk0 : (0 : ℤ) ≤ k := by positivity
    nlinarith [mul_nonneg hk0 (sq_nonneg S),
      mul_pos (by linarith : (0 : ℤ) < 4 - k) (pow_pos ht 2)]
  · subst hk
    push_cast at hid
    nlinarith [pow_pos hs 2]
  · have hk5 : (5 : ℤ) ≤ k := by exact_mod_cast hk
    have h1 : ((k : ℤ) * S) ^ 2 = (k * (k - 4)) * T ^ 2 := by linear_combination (k : ℤ) * hid
    have h2 : T ∣ (k : ℤ) * S := by
      rw [← Int.pow_dvd_pow_iff two_ne_zero, h1]
      exact Dvd.intro_left _ rfl
    obtain ⟨r, hr⟩ := h2
    have h3 : r ^ 2 = (k : ℤ) * (k - 4) := by
      have hT2 : T ^ 2 ≠ 0 := pow_ne_zero 2 ht.ne'
      apply mul_left_cancel₀ hT2
      rw [hr] at h1
      linear_combination h1
    exact q2_no_sq_between (D := (k : ℤ) * (k - 4)) (a := (k : ℤ) - 3) (by linarith)
      (by nlinarith) (by nlinarith) h3

/-- Consequence: `X ≤ |F|`. -/
theorem q4_X_le {p X A k w c : ℕ} (hA : 2 * (p + 1) * A = p * X + c) (hA1 : 1 ≤ A) (hX : 1 ≤ X)
    (hδ : k * A ^ 2 < 4 * X ^ 2)
    (hE : (4 * X ^ 2 - k * A ^ 2) * w ^ 2 + (X ^ 2 - 1) = (4 * X ^ 2 - k * A) * w)
    (hc : p + 1 < c * w) :
    (X : ℤ) ≤ |(k : ℤ) * c ^ 2 * w ^ 2 - 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2| := by
  have hdvd := q4_dvd_F hA hA1 hX hδ hE
  have hF := q4_F_ne_zero (k := k) hc
  exact Int.le_of_dvd (abs_pos.mpr hF) ((dvd_abs _ _).mpr hdvd)

end A224Deep
