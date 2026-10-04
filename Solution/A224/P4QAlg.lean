import Solution.A224.P3QAlg

/-! a000224 deep attempt, family p⁴q, the k = 16 case: equation (E4) with k = 16 has no solution
(discriminant strictly between consecutive squares). This is the only infinite-family algebra left in the
uniform route Q4 of the notebook. -/

namespace A224Deep

/-- Helper (large `p`): the (E4) discriminant for `k = 16` is not a square when `P ≥ 12`. -/
theorem q4_disc_large {P s : ℤ} (hP : 12 ≤ P)
    (hs : s ^ 2 = 16 * P ^ 16 - 32 * P ^ 15 + 48 * P ^ 14 - 64 * P ^ 13 + 48 * P ^ 12 - 32 * P ^ 11
      + 16 * P ^ 10 - 96 * P ^ 7 + 144 * P ^ 6 - 192 * P ^ 5 + 336 * P ^ 4 - 288 * P ^ 3 + 240 * P ^ 2
      - 192 * P + 192) : False := by
  have hP0 : (0 : ℤ) ≤ P := by linarith
  have ha : 0 ≤ 4 * P ^ 8 - 4 * P ^ 7 + 4 * P ^ 6 - 4 * P ^ 5 - 1 := by
    have h5 : (1 : ℤ) ≤ P ^ 5 := one_le_pow₀ (by linarith)
    have k1 : 0 ≤ P ^ 7 * (P - 1) := mul_nonneg (pow_nonneg hP0 7) (by linarith)
    have k2 : 0 ≤ P ^ 5 * (P - 12) := mul_nonneg (pow_nonneg hP0 5) (by linarith)
    have e : 4 * P ^ 8 - 4 * P ^ 7 + 4 * P ^ 6 - 4 * P ^ 5 - 1
        = 4 * (P ^ 7 * (P - 1)) + 4 * (P ^ 5 * (P - 12)) + 44 * P ^ 5 - 1 := by ring
    linarith
  refine q2_no_sq_between (a := 4 * P ^ 8 - 4 * P ^ 7 + 4 * P ^ 6 - 4 * P ^ 5 - 1) ha ?_ ?_ hs
  · have k1 : 0 ≤ P ^ 6 * ((P - 12) * (P - 1)) :=
      mul_nonneg (pow_nonneg hP0 6) (mul_nonneg (by linarith) (by linarith))
    have k2 : 0 ≤ P ^ 5 * (P - 12) := mul_nonneg (pow_nonneg hP0 5) (by linarith)
    have k3 : 0 ≤ P ^ 5 := pow_nonneg hP0 5
    have k4 : 0 ≤ P ^ 3 * (P - 12) := mul_nonneg (pow_nonneg hP0 3) (by linarith)
    have k5 : 0 ≤ P ^ 3 := pow_nonneg hP0 3
    have k6 : 0 ≤ P * (P - 12) := mul_nonneg hP0 (by linarith)
    have e : 16 * P ^ 16 - 32 * P ^ 15 + 48 * P ^ 14 - 64 * P ^ 13 + 48 * P ^ 12 - 32 * P ^ 11
      + 16 * P ^ 10 - 96 * P ^ 7 + 144 * P ^ 6 - 192 * P ^ 5 + 336 * P ^ 4 - 288 * P ^ 3 + 240 * P ^ 2
      - 192 * P + 192 - (4 * P ^ 8 - 4 * P ^ 7 + 4 * P ^ 6 - 4 * P ^ 5 - 1) ^ 2
        = 8 * (P ^ 6 * ((P - 12) * (P - 1))) + 56 * (P ^ 5 * (P - 12)) + 472 * P ^ 5
          + 336 * (P ^ 3 * (P - 12)) + 3744 * P ^ 3 + 240 * (P * (P - 12)) + 2688 * P + 191 := by
      ring
    linarith
  · have k1 : 0 ≤ P ^ 6 * (2 * P - 3) := mul_nonneg (pow_nonneg hP0 6) (by linarith)
    have k2 : 0 ≤ P ^ 4 * (4 * P - 7) := mul_nonneg (pow_nonneg hP0 4) (by linarith)
    have k3 : 0 ≤ P ^ 2 * (6 * P - 5) := mul_nonneg (pow_nonneg hP0 2) (by linarith)
    have e : (4 * P ^ 8 - 4 * P ^ 7 + 4 * P ^ 6 - 4 * P ^ 5 - 1 + 1) ^ 2
      - (16 * P ^ 16 - 32 * P ^ 15 + 48 * P ^ 14 - 64 * P ^ 13 + 48 * P ^ 12 - 32 * P ^ 11
      + 16 * P ^ 10 - 96 * P ^ 7 + 144 * P ^ 6 - 192 * P ^ 5 + 336 * P ^ 4 - 288 * P ^ 3 + 240 * P ^ 2
      - 192 * P + 192)
        = 48 * (P ^ 6 * (2 * P - 3)) + 48 * (P ^ 4 * (4 * P - 7)) + 48 * (P ^ 2 * (6 * P - 5))
          + 192 * (P - 1) := by
      ring
    linarith

/-- Helper (small `p`): the (E4) discriminant for `k = 16` is not a square when `3 ≤ p ≤ 11`. -/
theorem q4_disc_small {p : ℕ} {s : ℤ} (hp3 : 3 ≤ p) (hp : p < 12)
    (hs : s ^ 2 = 16 * (p : ℤ) ^ 16 - 32 * (p : ℤ) ^ 15 + 48 * (p : ℤ) ^ 14 - 64 * (p : ℤ) ^ 13
      + 48 * (p : ℤ) ^ 12 - 32 * (p : ℤ) ^ 11 + 16 * (p : ℤ) ^ 10 - 96 * (p : ℤ) ^ 7
      + 144 * (p : ℤ) ^ 6 - 192 * (p : ℤ) ^ 5 + 336 * (p : ℤ) ^ 4 - 288 * (p : ℤ) ^ 3
      + 240 * (p : ℤ) ^ 2 - 192 * (p : ℤ) + 192) : False := by
  interval_cases p <;> norm_num at hs
  · exact q2_no_sq_between (a := 19436) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 208893) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 1299997) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 5754238) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 20168398) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 59637758) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 154944574) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 363599998) (by norm_num) (by norm_num) (by norm_num) hs
  · exact q2_no_sq_between (a := 785928878) (by norm_num) (by norm_num) (by norm_num) hs

/-- Helper: `2 * ((p^4 - p^3 + p^2 - p + 2) / 2) = p^4 - p^3 + p^2 - p + 2` (the numerator is always even). -/
theorem q4_two_mul_half (p : ℕ) :
    2 * ((p ^ 4 - p ^ 3 + p ^ 2 - p + 2) / 2) = p ^ 4 - p ^ 3 + p ^ 2 - p + 2 := by
  rcases Nat.lt_or_ge p 1 with h0 | h1
  · interval_cases p; norm_num
  have h43 : p ^ 3 ≤ p ^ 4 := Nat.pow_le_pow_right h1 (by norm_num)
  have h21 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  obtain ⟨t, ht⟩ := Nat.even_or_odd' p
  rcases ht with ht | ht
  · have e4 : p ^ 4 = 16 * t ^ 4 := by rw [ht]; ring
    have e3 : p ^ 3 = 8 * t ^ 3 := by rw [ht]; ring
    have e2 : p ^ 2 = 4 * t ^ 2 := by rw [ht]; ring
    omega
  · have e4 : p ^ 4 = 16 * t ^ 4 + 32 * t ^ 3 + 24 * t ^ 2 + 8 * t + 1 := by rw [ht]; ring
    have e3 : p ^ 3 = 8 * t ^ 3 + 12 * t ^ 2 + 6 * t + 1 := by rw [ht]; ring
    have e2 : p ^ 2 = 4 * t ^ 2 + 4 * t + 1 := by rw [ht]; ring
    omega

/-- (k = 16, e = 4). (E4) with `k = 16` has no solution with `p ≥ 3`, `w ≥ 2`. -/
theorem q4_k16_e4 {p w : ℕ} (hp3 : 3 ≤ p) (hw : 2 ≤ w)
    (hE : (4 * p ^ 8 - 16 * ((p ^ 4 - p ^ 3 + p ^ 2 - p + 2) / 2) ^ 2) * w ^ 2 + (p ^ 8 - 1)
      = (4 * p ^ 8 - 16 * ((p ^ 4 - p ^ 3 + p ^ 2 - p + 2) / 2)) * w) :
    False := by
  have hA := q4_two_mul_half p
  generalize hAdef : (p ^ 4 - p ^ 3 + p ^ 2 - p + 2) / 2 = A at hE hA
  have h43 : p ^ 3 ≤ p ^ 4 := Nat.pow_le_pow_right (by omega) (by norm_num)
  have h32 : p ^ 2 < p ^ 3 := Nat.pow_lt_pow_right (by omega) (by norm_num)
  have h21 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  have hC : 2 * A < p ^ 4 := by omega
  have hA2 : 2 * A + p ^ 3 + p = p ^ 4 + p ^ 2 + 2 := by omega
  have h1 : 16 * A ^ 2 ≤ 4 * p ^ 8 := by
    have := Nat.pow_lt_pow_left hC (two_ne_zero)
    have e : (p ^ 4) ^ 2 = p ^ 8 := by ring
    rw [e] at this
    nlinarith [this]
  have h2 : 16 * A ≤ 4 * p ^ 8 := by
    nlinarith [h1, Nat.le_self_pow two_ne_zero A]
  have h3 : 1 ≤ p ^ 8 := Nat.one_le_pow _ _ (by omega)
  zify [h1, h2, h3] at hE
  have hA' : 2 * (A : ℤ) = (p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2 := by
    have h : (2 * A + p ^ 3 + p : ℤ) = (p : ℤ) ^ 4 + (p : ℤ) ^ 2 + 2 := by exact_mod_cast hA2
    linarith
  have e1 : 16 * (A : ℤ) ^ 2 = 4 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2) ^ 2 := by
    linear_combination (4 * (2 * (A : ℤ) + ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2))) * hA'
  have e2 : 16 * (A : ℤ) = 8 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2) := by
    linear_combination 8 * hA'
  have hE' : (4 * (p : ℤ) ^ 8 - 4 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2) ^ 2) * (w : ℤ) ^ 2
      + ((p : ℤ) ^ 8 - 1)
      = (4 * (p : ℤ) ^ 8 - 8 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2)) * (w : ℤ) := by
    linear_combination hE + (w : ℤ) ^ 2 * e1 - (w : ℤ) * e2
  have hs : (2 * (4 * (p : ℤ) ^ 8 - 4 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2) ^ 2) * (w : ℤ)
      - (4 * (p : ℤ) ^ 8 - 8 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2))) ^ 2
      = 16 * (p : ℤ) ^ 16 - 32 * (p : ℤ) ^ 15 + 48 * (p : ℤ) ^ 14 - 64 * (p : ℤ) ^ 13
        + 48 * (p : ℤ) ^ 12 - 32 * (p : ℤ) ^ 11 + 16 * (p : ℤ) ^ 10 - 96 * (p : ℤ) ^ 7
        + 144 * (p : ℤ) ^ 6 - 192 * (p : ℤ) ^ 5 + 336 * (p : ℤ) ^ 4 - 288 * (p : ℤ) ^ 3
        + 240 * (p : ℤ) ^ 2 - 192 * (p : ℤ) + 192 := by
    linear_combination (4 * (4 * (p : ℤ) ^ 8 - 4 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2) ^ 2)) * hE'
  generalize (2 * (4 * (p : ℤ) ^ 8 - 4 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2) ^ 2) * (w : ℤ)
      - (4 * (p : ℤ) ^ 8 - 8 * ((p : ℤ) ^ 4 - (p : ℤ) ^ 3 + (p : ℤ) ^ 2 - p + 2))) = s at hs
  rcases le_or_gt 12 p with h12 | h12
  · exact q4_disc_large (P := (p : ℤ)) (by exact_mod_cast h12) hs
  · exact q4_disc_small hp3 h12 hs

end A224Deep
