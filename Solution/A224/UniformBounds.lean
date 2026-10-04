import FormalConjectures.OEIS.«224»

/-! a000224 deep attempt, uniform bounds for the family `p^e q` (route Q4 in the notebook): with
`X = p^e`, `2(p+1)A = pX + c`, `c ≤ 2p + 1`, the quotient `k` and the parameter `w = (q+1)/2` satisfy
`k ≤ 28`; `k ≥ 17 → p ≤ 32`; `k ≤ 15 → w ≤ 15`; `k = 16 → 2w ≤ p + 5` (for `X ≥ p^4`). -/

namespace A224Deep

/-- 1. `k ≤ 28`. -/
theorem q4_k_le_28 {p X A k c : ℕ} (hp3 : 3 ≤ p) (hA : 2 * (p + 1) * A = p * X + c) (hX : 1 ≤ X)
    (hδ : k * A ^ 2 < 4 * X ^ 2) : k ≤ 28 := by
  by_contra hk
  push Not at hk
  have h1 : p * X ≤ 2 * (p + 1) * A := hA ▸ Nat.le_add_right _ _
  have h2 : (p * X) ^ 2 ≤ (2 * (p + 1) * A) ^ 2 := Nat.pow_le_pow_left h1 2
  have h3 : k * (p * X) ^ 2 < 16 * (p + 1) ^ 2 * X ^ 2 := by
    calc k * (p * X) ^ 2 ≤ k * (2 * (p + 1) * A) ^ 2 := Nat.mul_le_mul_left _ h2
      _ = 4 * (p + 1) ^ 2 * (k * A ^ 2) := by ring
      _ < 4 * (p + 1) ^ 2 * (4 * X ^ 2) := mul_lt_mul_of_pos_left hδ (by positivity)
      _ = 16 * (p + 1) ^ 2 * X ^ 2 := by ring
  have h4 : (k * p ^ 2) * X ^ 2 < (16 * (p + 1) ^ 2) * X ^ 2 := by
    have e1 : k * (p * X) ^ 2 = (k * p ^ 2) * X ^ 2 := by ring
    rw [← e1]; exact h3
  have h5 : k * p ^ 2 < 16 * (p + 1) ^ 2 := Nat.lt_of_mul_lt_mul_right h4
  have h6 : 29 * p ^ 2 ≤ k * p ^ 2 := Nat.mul_le_mul_right _ hk
  nlinarith

/-- 2. `k ≥ 17 → p ≤ 32`. -/
theorem q4_p_le_32 {p X A k c : ℕ} (hp3 : 3 ≤ p) (hA : 2 * (p + 1) * A = p * X + c) (hX : 1 ≤ X)
    (hk : 17 ≤ k) (hδ : k * A ^ 2 < 4 * X ^ 2) : p ≤ 32 := by
  by_contra hp
  push Not at hp
  have h1 : p * X ≤ 2 * (p + 1) * A := hA ▸ Nat.le_add_right _ _
  have h2 : (p * X) ^ 2 ≤ (2 * (p + 1) * A) ^ 2 := Nat.pow_le_pow_left h1 2
  have h3 : k * (p * X) ^ 2 < 16 * (p + 1) ^ 2 * X ^ 2 := by
    calc k * (p * X) ^ 2 ≤ k * (2 * (p + 1) * A) ^ 2 := Nat.mul_le_mul_left _ h2
      _ = 4 * (p + 1) ^ 2 * (k * A ^ 2) := by ring
      _ < 4 * (p + 1) ^ 2 * (4 * X ^ 2) := mul_lt_mul_of_pos_left hδ (by positivity)
      _ = 16 * (p + 1) ^ 2 * X ^ 2 := by ring
  have h4 : (k * p ^ 2) * X ^ 2 < (16 * (p + 1) ^ 2) * X ^ 2 := by
    have e1 : k * (p * X) ^ 2 = (k * p ^ 2) * X ^ 2 := by ring
    rw [← e1]; exact h3
  have h5 : k * p ^ 2 < 16 * (p + 1) ^ 2 := Nat.lt_of_mul_lt_mul_right h4
  have h6 : 17 * p ^ 2 ≤ k * p ^ 2 := Nat.mul_le_mul_right _ hk
  nlinarith

/-- 3. `k ≤ 15 → w ≤ 15`. -/
theorem q4_w_le_15 {p X A k c w : ℕ} (hp3 : 3 ≤ p) (hA : 2 * (p + 1) * A = p * X + c)
    (hc : c ≤ 2 * p + 1) (hX : 2 * p + 1 < X) (hk : k ≤ 15)
    (hwb : (4 * X ^ 2 - k * A ^ 2) * w < 4 * X ^ 2 - k * A) : w ≤ 15 := by
  have h2A : 2 * A < X := by
    have : (p + 1) * (2 * A) < (p + 1) * X := by nlinarith
    exact Nat.lt_of_mul_lt_mul_left this
  have hA2 : 4 * A ^ 2 < X ^ 2 := by nlinarith
  have hkA : k * A ^ 2 ≤ 15 * A ^ 2 := Nat.mul_le_mul_right _ hk
  have hD : X ^ 2 ≤ 4 * (4 * X ^ 2 - k * A ^ 2) := by omega
  have h1 : (4 * X ^ 2 - k * A ^ 2) * w < 4 * X ^ 2 := lt_of_lt_of_le hwb (Nat.sub_le _ _)
  have h2 : X ^ 2 * w ≤ 4 * (4 * X ^ 2 - k * A ^ 2) * w := Nat.mul_le_mul_right w hD
  rw [mul_assoc] at h2
  have h3 : X ^ 2 * w < X ^ 2 * 16 := by omega
  have := Nat.lt_of_mul_lt_mul_left h3
  omega

/-- 4. `k = 16 → 2w ≤ p + 5` when `X ≥ p^4`. -/
theorem q4_k16_w_bound {p X A c w : ℕ} (hp3 : 3 ≤ p) (hA : 2 * (p + 1) * A = p * X + c)
    (hc : c ≤ 2 * p + 1) (hX : p ^ 4 ≤ X)
    (hwb : (4 * X ^ 2 - 16 * A ^ 2) * w < 4 * X ^ 2 - 16 * A) : 2 * w ≤ p + 5 := by
  have hp3' : 27 ≤ p ^ 3 := by
    calc 27 = 3 ^ 3 := by norm_num
      _ ≤ p ^ 3 := Nat.pow_le_pow_left hp3 3
  have hp4 : 27 * p ≤ p ^ 4 := by
    have e : p ^ 4 = p ^ 3 * p := by ring
    rw [e]; exact Nat.mul_le_mul_right p hp3'
  have hX' : 2 * p + 1 < X := by omega
  have h2A : 2 * A < X := by
    have : (p + 1) * (2 * A) < (p + 1) * X := by nlinarith
    exact Nat.lt_of_mul_lt_mul_left this
  have hA2 : 16 * A ^ 2 ≤ 4 * X ^ 2 := by nlinarith
  have hAA : A ≤ A ^ 2 := Nat.le_self_pow two_ne_zero A
  have hA1 : 16 * A ≤ 4 * X ^ 2 := by omega
  zify [hA2, hA1] at hwb
  by_contra hw
  push Not at hw
  have hw6 : p + 6 ≤ 2 * w := by omega
  have hw' : (p : ℤ) + 6 ≤ 2 * (w : ℤ) := by exact_mod_cast hw6
  have hAz : 2 * ((p : ℤ) + 1) * A = p * X + c := by exact_mod_cast hA
  have hcz : (c : ℤ) ≤ 2 * p + 1 := by exact_mod_cast hc
  have hXz : (p : ℤ) ^ 4 ≤ X := by exact_mod_cast hX
  have hX'z : 2 * (p : ℤ) + 1 < X := by exact_mod_cast hX'
  have hp3z : (3 : ℤ) ≤ p := by exact_mod_cast hp3
  have hp0 : (0 : ℤ) ≤ p := by positivity
  have hA0 : (0 : ℤ) ≤ A := by positivity
  have hw0 : (0 : ℤ) ≤ w := by positivity
  have hc0 : (0 : ℤ) ≤ c := by positivity
  have hD : ((p : ℤ) + 1) * (X - 2 * A) = X - c := by linear_combination (-1 : ℤ) * hAz
  have hS : ((p : ℤ) + 1) * (X + 2 * A) = (2 * p + 1) * X + c := by linear_combination hAz
  have hδeq : ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2 - 16 * A ^ 2)
      = 4 * (X - c) * ((2 * p + 1) * X + c) := by
    have e : ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2 - 16 * A ^ 2)
        = 4 * (((p : ℤ) + 1) * (X - 2 * A)) * (((p : ℤ) + 1) * (X + 2 * A)) := by ring
    rw [e, hD, hS]
  have hlow : ((X : ℤ) - 2 * p - 1) * ((2 * p + 1) * X) ≤ (X - c) * ((2 * p + 1) * X + c) :=
    mul_le_mul (by linarith) (by linarith) (by positivity) (by linarith)
  have hδw : (4 * (X : ℤ) ^ 2 - 16 * A ^ 2) * w < 4 * X ^ 2 := lt_of_lt_of_le hwb (by linarith)
  have s1 : ((p : ℤ) + 1) ^ 2 * ((4 * (X : ℤ) ^ 2 - 16 * A ^ 2) * w)
      < ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2) := mul_lt_mul_of_pos_left hδw (by positivity)
  have s2 : 4 * (((X : ℤ) - 2 * p - 1) * ((2 * p + 1) * X)) * w
      ≤ ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2 - 16 * A ^ 2) * w := by
    calc 4 * (((X : ℤ) - 2 * p - 1) * ((2 * p + 1) * X)) * w
        ≤ 4 * (((X : ℤ) - c) * ((2 * p + 1) * X + c)) * w := by
          have := mul_le_mul_of_nonneg_right hlow hw0
          linarith
      _ = ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2 - 16 * A ^ 2) * w := by rw [hδeq]; ring
  have hQ : (0 : ℤ) ≤ ((X : ℤ) - 2 * p - 1) * ((2 * p + 1) * X) := by
    apply mul_nonneg <;> [linarith; positivity]
  have hint := mul_le_mul_of_nonneg_left hw' hQ
  have s3 : ((X : ℤ) - 2 * p - 1) * ((2 * p + 1) * X) * (p + 6) < 2 * ((p : ℤ) + 1) ^ 2 * X ^ 2 := by
    linarith
  have s4 : (X : ℤ) * (((X : ℤ) - 2 * p - 1) * (2 * p + 1) * (p + 6))
      < (X : ℤ) * (2 * ((p : ℤ) + 1) ^ 2 * X) := by linarith
  have s5 := lt_of_mul_lt_mul_left s4 (by positivity)
  have s6 : (9 * (p : ℤ) + 4) * p ^ 4 ≤ (9 * (p : ℤ) + 4) * X :=
    mul_le_mul_of_nonneg_left hXz (by positivity)
  have a1 : 3 * (p : ℤ) ≤ p ^ 2 := by
    have := mul_le_mul_of_nonneg_right hp3z hp0; linarith
  have a2 : 3 * (p : ℤ) ^ 2 ≤ p ^ 3 := by
    have := mul_le_mul_of_nonneg_right hp3z (sq_nonneg (p : ℤ)); linarith
  have a3 : 3 * (p : ℤ) ^ 3 ≤ p ^ 4 := by
    have := mul_le_mul_of_nonneg_right hp3z (pow_nonneg hp0 3); linarith
  have a4 : 3 * (p : ℤ) ^ 4 ≤ p ^ 5 := by
    have := mul_le_mul_of_nonneg_right hp3z (pow_nonneg hp0 4); linarith
  linarith

end A224Deep
