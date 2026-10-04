import Solution.A224.P2QAlg

/-! a000224 deep attempt, family p³q, algebraic lemmas: the mod-p divisibility forced by (E3), and the
impossibility of (E3) for k = 16 (discriminant strictly between consecutive squares). -/

namespace A224Deep

/-- (mod p). If (E3) holds and `p` is odd, then `p ∣ k w (w − 2) + 4`. -/
theorem q3_dvd {p k w : ℕ} (hp3 : 3 ≤ p) (hodd : p % 2 = 1) (hw : 2 ≤ w)
    (hδ : k * ((p ^ 3 - p ^ 2 + p + 1) / 2) ^ 2 < 4 * p ^ 6)
    (hE : (4 * p ^ 6 - k * ((p ^ 3 - p ^ 2 + p + 1) / 2) ^ 2) * w ^ 2 + (p ^ 6 - 1)
      = (4 * p ^ 6 - k * ((p ^ 3 - p ^ 2 + p + 1) / 2)) * w) :
    p ∣ k * w * (w - 2) + 4 := by
  obtain ⟨t, rfl⟩ : ∃ t, p = 2 * t + 1 := ⟨p / 2, by omega⟩
  have hA : ((2 * t + 1) ^ 3 - (2 * t + 1) ^ 2 + (2 * t + 1) + 1) / 2
      = 4 * t ^ 3 + 4 * t ^ 2 + 2 * t + 1 := by
    have e3 : (2 * t + 1) ^ 3 = 8 * t ^ 3 + 12 * t ^ 2 + 6 * t + 1 := by ring
    have e2 : (2 * t + 1) ^ 2 = 4 * t ^ 2 + 4 * t + 1 := by ring
    omega
  rw [hA] at hδ hE
  have h1 : k * (4 * t ^ 3 + 4 * t ^ 2 + 2 * t + 1) ^ 2 ≤ 4 * (2 * t + 1) ^ 6 := hδ.le
  have h2 : k * (4 * t ^ 3 + 4 * t ^ 2 + 2 * t + 1) ≤ 4 * (2 * t + 1) ^ 6 :=
    le_trans (Nat.mul_le_mul_left k (Nat.le_self_pow two_ne_zero _)) h1
  have h3 : 1 ≤ (2 * t + 1) ^ 6 := Nat.one_le_pow _ _ (by omega)
  zify [h1, h2, h3] at hE
  rw [← Int.natCast_dvd_natCast]
  push_cast [Nat.cast_sub hw]
  exact ⟨4 * (2 * (t : ℤ) + 1) ^ 5 * (2 * (w : ℤ) - 1) ^ 2
      - k * (w : ℤ) ^ 2 * (2 * ((2 * (t : ℤ) + 1) ^ 2 - (2 * (t : ℤ) + 1) + 1)
        + (2 * (t : ℤ) + 1) * ((2 * (t : ℤ) + 1) ^ 2 - (2 * (t : ℤ) + 1) + 1) ^ 2)
      + 2 * k * (w : ℤ) * ((2 * (t : ℤ) + 1) ^ 2 - (2 * (t : ℤ) + 1) + 1),
    by linear_combination (-4 : ℤ) * hE⟩

/-- Helper (large `p`): the (E3) discriminant for `k = 16` is not a square when `P ≥ 12`. -/
theorem q3_disc_large {P s : ℤ} (hP : 12 ≤ P)
    (hs : s ^ 2 = 16 * P ^ 12 - 32 * P ^ 11 + 48 * P ^ 10 - 64 * P ^ 9 + 48 * P ^ 8 - 32 * P ^ 7 + 16 * P ^ 6
      - 96 * P ^ 5 + 144 * P ^ 4 - 48 * P ^ 2 + 96 * P + 48) : False := by
  have hP0 : (0 : ℤ) ≤ P := by linarith
  have ha : 0 ≤ 4 * P ^ 6 - 4 * P ^ 5 + 4 * P ^ 4 - 4 * P ^ 3 - 1 := by
    have k1 : 0 ≤ P ^ 5 * (P - 1) := mul_nonneg (pow_nonneg hP0 5) (by linarith)
    have k2 : 0 ≤ P ^ 2 * (P - 12) := mul_nonneg (pow_nonneg hP0 2) (by linarith)
    have k3 : 0 ≤ P * (P - 12) := mul_nonneg hP0 (by linarith)
    have e : 4 * P ^ 6 - 4 * P ^ 5 + 4 * P ^ 4 - 4 * P ^ 3 - 1
        = 4 * (P ^ 5 * (P - 1)) + 4 * (P ^ 4 - P ^ 3) - 1 := by ring
    have k4 : 0 ≤ P ^ 3 * (P - 12) := mul_nonneg (pow_nonneg hP0 3) (by linarith)
    have e2 : P ^ 4 - P ^ 3 = P ^ 3 * (P - 12) + 11 * (P ^ 2 * (P - 12)) + 132 * (P * (P - 12))
        + 1584 * (P - 12) + 19008 := by ring
    linarith
  refine q2_no_sq_between (a := 4 * P ^ 6 - 4 * P ^ 5 + 4 * P ^ 4 - 4 * P ^ 3 - 1) ha ?_ ?_ hs
  · have k1 : 0 ≤ P ^ 4 * ((P - 12) * (P - 1)) :=
      mul_nonneg (pow_nonneg hP0 4) (mul_nonneg (by linarith) (by linarith))
    have k2 : 0 ≤ P ^ 3 * (P - 1) := mul_nonneg (pow_nonneg hP0 3) (by linarith)
    have k3 : 0 ≤ P ^ 2 * (P ^ 2 - 1) := mul_nonneg (pow_nonneg hP0 2) (by nlinarith)
    have e : 16 * P ^ 12 - 32 * P ^ 11 + 48 * P ^ 10 - 64 * P ^ 9 + 48 * P ^ 8 - 32 * P ^ 7 + 16 * P ^ 6
      - 96 * P ^ 5 + 144 * P ^ 4 - 48 * P ^ 2 + 96 * P + 48 - (4 * P ^ 6 - 4 * P ^ 5 + 4 * P ^ 4 - 4 * P ^ 3 - 1) ^ 2
        = 8 * (P ^ 4 * ((P - 12) * (P - 1))) + 8 * (P ^ 3 * (P - 1)) + 48 * (P ^ 2 * (P ^ 2 - 1))
          + 96 * P + 47 := by ring
    linarith
  · have k1 : 0 ≤ P ^ 4 * (P - 12) := mul_nonneg (pow_nonneg hP0 4) (by linarith)
    have k2 : 0 ≤ P * (P - 12) := mul_nonneg hP0 (by linarith)
    have k3 : 0 ≤ P ^ 4 := pow_nonneg hP0 4
    have e : (4 * P ^ 6 - 4 * P ^ 5 + 4 * P ^ 4 - 4 * P ^ 3 - 1 + 1) ^ 2 - (16 * P ^ 12 - 32 * P ^ 11 + 48 * P ^ 10 - 64 * P ^ 9 + 48 * P ^ 8 - 32 * P ^ 7 + 16 * P ^ 6
      - 96 * P ^ 5 + 144 * P ^ 4 - 48 * P ^ 2 + 96 * P + 48)
        = 96 * (P ^ 4 * (P - 12)) + 1008 * P ^ 4 + 48 * (P * (P - 12)) + 480 * (P - 12) + 5712 := by
      ring
    linarith

/-- Helper (small `p`): the (E3) discriminant for `k = 16` is not a square when `3 ≤ p ≤ 11`. -/
theorem q3_disc_small {p : ℕ} {s : ℤ} (hp3 : 3 ≤ p) (hp : p < 12)
    (hs : s ^ 2 = 16 * (p : ℤ) ^ 12 - 32 * (p : ℤ) ^ 11 + 48 * (p : ℤ) ^ 10 - 64 * (p : ℤ) ^ 9
        + 48 * (p : ℤ) ^ 8 - 32 * (p : ℤ) ^ 7 + 16 * (p : ℤ) ^ 6 - 96 * (p : ℤ) ^ 5
        + 144 * (p : ℤ) ^ 4 - 48 * (p : ℤ) ^ 2 + 96 * (p : ℤ) + 48) : False := by
  interval_cases p <;> norm_num at hs
  · exact q2_no_sq_between (a := 2157) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 13053) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 51997) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 159838) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 411598) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 931838) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 1912894) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 3635998) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 6495278) (by norm_num) (by norm_num) (by norm_num) hs

/-- (k = 16). (E3) with `k = 16` has no solution with `p ≥ 3` odd, `w ≥ 2`. -/
theorem q3_k16 {p w : ℕ} (hp3 : 3 ≤ p) (hodd : p % 2 = 1) (hw : 2 ≤ w)
    (hE : (4 * p ^ 6 - 16 * ((p ^ 3 - p ^ 2 + p + 1) / 2) ^ 2) * w ^ 2 + (p ^ 6 - 1)
      = (4 * p ^ 6 - 16 * ((p ^ 3 - p ^ 2 + p + 1) / 2)) * w) :
    False := by
  generalize hAdef : (p ^ 3 - p ^ 2 + p + 1) / 2 = A at hE
  have hp32 : p ^ 2 ≤ p ^ 3 := Nat.pow_le_pow_right (by omega) (by norm_num)
  have hA : 2 * A = p ^ 3 - p ^ 2 + p + 1 := by
    obtain ⟨t, ht⟩ : ∃ t, p = 2 * t + 1 := ⟨p / 2, by omega⟩
    have e3 : p ^ 3 = 8 * t ^ 3 + 12 * t ^ 2 + 6 * t + 1 := by rw [ht]; ring
    have e2 : p ^ 2 = 4 * t ^ 2 + 4 * t + 1 := by rw [ht]; ring
    omega
  have hpp : p + 1 < p ^ 2 := by nlinarith
  have hC : 2 * A < p ^ 3 := by omega
  have h1 : 16 * A ^ 2 ≤ 4 * p ^ 6 := by
    have := Nat.pow_lt_pow_left hC (two_ne_zero)
    have e : (p ^ 3) ^ 2 = p ^ 6 := by ring
    rw [e] at this
    nlinarith [this]
  have h2 : 16 * A ≤ 4 * p ^ 6 := by
    nlinarith [h1, Nat.le_self_pow two_ne_zero A]
  have h3 : 1 ≤ p ^ 6 := Nat.one_le_pow _ _ (by omega)
  zify [h1, h2, h3] at hE
  have hA' : 2 * (A : ℤ) = (p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1 := by
    have := hA
    zify [hp32] at this
    linarith
  have e1 : 16 * (A : ℤ) ^ 2 = 4 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1) ^ 2 := by
    linear_combination (4 * (2 * (A : ℤ) + ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1))) * hA'
  have e2 : 16 * (A : ℤ) = 8 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1) := by
    linear_combination 8 * hA'
  have hE' : (4 * (p : ℤ) ^ 6 - 4 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1) ^ 2) * (w : ℤ) ^ 2
      + ((p : ℤ) ^ 6 - 1)
      = (4 * (p : ℤ) ^ 6 - 8 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1)) * (w : ℤ) := by
    linear_combination hE + (w : ℤ) ^ 2 * e1 - (w : ℤ) * e2
  have hs : (2 * (4 * (p : ℤ) ^ 6 - 4 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1) ^ 2) * (w : ℤ)
      - (4 * (p : ℤ) ^ 6 - 8 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1))) ^ 2
      = 16 * (p : ℤ) ^ 12 - 32 * (p : ℤ) ^ 11 + 48 * (p : ℤ) ^ 10 - 64 * (p : ℤ) ^ 9
        + 48 * (p : ℤ) ^ 8 - 32 * (p : ℤ) ^ 7 + 16 * (p : ℤ) ^ 6 - 96 * (p : ℤ) ^ 5
        + 144 * (p : ℤ) ^ 4 - 48 * (p : ℤ) ^ 2 + 96 * (p : ℤ) + 48 := by
    linear_combination (4 * (4 * (p : ℤ) ^ 6 - 4 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1) ^ 2)) * hE'
  generalize (2 * (4 * (p : ℤ) ^ 6 - 4 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1) ^ 2) * (w : ℤ)
      - (4 * (p : ℤ) ^ 6 - 8 * ((p : ℤ) ^ 3 - (p : ℤ) ^ 2 + p + 1))) = s at hs
  rcases le_or_gt 12 p with h12 | h12
  · exact q3_disc_large (P := (p : ℤ)) (by exact_mod_cast h12) hs
  · exact q3_disc_small hp3 h12 hs

end A224Deep
