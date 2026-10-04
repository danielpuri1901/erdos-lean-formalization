import Solution.A224.Uniform

/-! a000224 deep attempt, route Q4 helper lemmas: mod-`p` reductions of `X ∣ F`, a bound on `|F|`,
the resulting bound on `e`, and the bounds `p ≤ 26` (k = 16) and `w < 34848` (large `X`). -/

namespace A224Deep

/-- 1. mod-p reduction, even e (c = p + 2): p ∣ k w (w − 1) + 1. -/
theorem q4_dvd_N_even {p X A k w : ℕ} (hodd : p % 2 = 1) (hpX : p ∣ X) (hw : 1 ≤ w)
    (hA : 2 * (p + 1) * A = p * X + (p + 2)) (hA1 : 1 ≤ A) (hX : 1 ≤ X)
    (hδ : k * A ^ 2 < 4 * X ^ 2)
    (hE : (4 * X ^ 2 - k * A ^ 2) * w ^ 2 + (X ^ 2 - 1) = (4 * X ^ 2 - k * A) * w) :
    p ∣ k * w * (w - 1) + 1 := by
  have hF := q4_dvd_F hA hA1 hX hδ hE
  have hpF := dvd_trans (Int.natCast_dvd_natCast.mpr hpX) hF
  push_cast at hpF
  have h4 : (p : ℤ) ∣ 4 * ((k : ℤ) * w ^ 2 - k * w + 1) := by
    have h2 := dvd_sub hpF (dvd_mul_right (p : ℤ)
      ((k : ℤ) * w ^ 2 * (p + 4) - 2 * k * w * (p + 3) + 4 * (p + 2)))
    convert h2 using 1
    all_goals first | ring | rfl
  have h4N : p ∣ 4 * (k * w * (w - 1) + 1) := by
    rw [← Int.natCast_dvd_natCast]
    push_cast [Nat.cast_sub hw]
    convert h4 using 1
    ring
  have hcop : Nat.Coprime p 4 := by
    have h : p % 4 = 1 ∨ p % 4 = 3 := by omega
    rw [Nat.coprime_comm, Nat.Coprime, Nat.gcd_rec]
    rcases h with h | h <;> rw [h] <;> rfl
  exact hcop.dvd_of_dvd_mul_left h4N

/-- 2. mod-p reduction, odd e (c = 2p + 1): p ∣ k w (w − 2) + 4. -/
theorem q4_dvd_N_odd {p X A k w : ℕ} (hodd : p % 2 = 1) (hpX : p ∣ X) (hw : 2 ≤ w)
    (hA : 2 * (p + 1) * A = p * X + (2 * p + 1)) (hA1 : 1 ≤ A) (hX : 1 ≤ X)
    (hδ : k * A ^ 2 < 4 * X ^ 2)
    (hE : (4 * X ^ 2 - k * A ^ 2) * w ^ 2 + (X ^ 2 - 1) = (4 * X ^ 2 - k * A) * w) :
    p ∣ k * w * (w - 2) + 4 := by
  have hF := q4_dvd_F hA hA1 hX hδ hE
  have hpF := dvd_trans (Int.natCast_dvd_natCast.mpr hpX) hF
  push_cast at hpF
  have h4 : (p : ℤ) ∣ (k : ℤ) * w ^ 2 - 2 * k * w + 4 := by
    have h2 := dvd_sub hpF (dvd_mul_right (p : ℤ)
      (4 * (k : ℤ) * (p + 1) * w ^ 2 - 2 * k * w * (2 * p + 3) + 4 * (p + 2)))
    convert h2 using 1
    all_goals first | ring | rfl
  rw [← Int.natCast_dvd_natCast]
  push_cast [Nat.cast_sub hw]
  convert h4 using 1
  ring

/-- 3. |F| is at most the sum of the absolute values of its terms. -/
theorem q4_absF_le (p k w c : ℕ) :
    |(k : ℤ) * c ^ 2 * w ^ 2 - 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2|
      ≤ ((k * c ^ 2 * w ^ 2 + 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2 : ℕ) : ℤ) := by
  push_cast
  have h1 : (0 : ℤ) ≤ (k : ℤ) * c ^ 2 * w ^ 2 := by positivity
  have h2 : (0 : ℤ) ≤ (k : ℤ) * (p + 1) * c * w := by positivity
  have h3 : (0 : ℤ) ≤ ((p : ℤ) + 1) ^ 2 := by positivity
  rw [abs_le]
  constructor <;> linarith

/-- 4. e-bound from X ≤ |F| and numeric bounds on k, p, w, c. -/
theorem q4_e_bound {p e k w c K P W C E : ℕ} (hp3 : 3 ≤ p)
    (hXF : ((p ^ e : ℕ) : ℤ) ≤ |(k : ℤ) * c ^ 2 * w ^ 2 - 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2|)
    (hk : k ≤ K) (hp : p ≤ P) (hw : w ≤ W) (hc : c ≤ C)
    (hM : K * C ^ 2 * W ^ 2 + 2 * K * (P + 1) * C * W + 4 * (P + 1) ^ 2 < 3 ^ E) : e < E := by
  have h1 := le_trans hXF (q4_absF_le p k w c)
  have h2 : p ^ e ≤ k * c ^ 2 * w ^ 2 + 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2 :=
    Nat.cast_le.mp h1
  have h3 : k * c ^ 2 * w ^ 2 + 2 * k * (p + 1) * c * w + 4 * (p + 1) ^ 2
      ≤ K * C ^ 2 * W ^ 2 + 2 * K * (P + 1) * C * W + 4 * (P + 1) ^ 2 := by gcongr
  have h4 : 3 ^ e ≤ p ^ e := Nat.pow_le_pow_left hp3 e
  have h5 : 3 ^ e < 3 ^ E := lt_of_le_of_lt h4 (lt_of_le_of_lt h2 (lt_of_le_of_lt h3 hM))
  by_contra h
  push Not at h
  have h6 : 3 ^ E ≤ 3 ^ e := Nat.pow_le_pow_right (by norm_num) h
  exact absurd h5 (not_lt.mpr h6)

/-- 5. k = 16, e ≥ 5 forces p ≤ 26. -/
theorem q4_k16_p_le {p X w c : ℕ} (hp3 : 3 ≤ p) (hc : c ≤ 2 * p + 1) (hw : 2 * w ≤ p + 5)
    (hX5 : p ^ 5 ≤ X)
    (hXF : (X : ℤ) ≤ |(16 : ℤ) * c ^ 2 * w ^ 2 - 2 * 16 * (p + 1) * c * w + 4 * (p + 1) ^ 2|) :
    p ≤ 26 := by
  have hp0 : (0 : ℤ) ≤ p := by positivity
  have hcz : (c : ℤ) ≤ 2 * p + 1 := by exact_mod_cast hc
  have hwz : 2 * (w : ℤ) ≤ p + 5 := by exact_mod_cast hw
  have hXz : (p : ℤ) ^ 5 ≤ X := by exact_mod_cast hX5
  have habs : |(16 : ℤ) * c ^ 2 * w ^ 2 - 2 * 16 * (p + 1) * c * w + 4 * (p + 1) ^ 2|
      ≤ 16 * (c : ℤ) ^ 2 * w ^ 2 + 32 * (p + 1) * c * w + 4 * (p + 1) ^ 2 := by
    have h1 : (0 : ℤ) ≤ (c : ℤ) ^ 2 * w ^ 2 := by positivity
    have h2 : (0 : ℤ) ≤ ((p : ℤ) + 1) * c * w := by positivity
    have h3 : (0 : ℤ) ≤ ((p : ℤ) + 1) ^ 2 := by positivity
    rw [abs_le]
    constructor <;> linarith
  have hcu : (c : ℤ) * (2 * w) ≤ (2 * p + 1) * (p + 5) :=
    mul_le_mul hcz hwz (by positivity) (by positivity)
  have hcu2 : ((c : ℤ) * (2 * w)) * ((c : ℤ) * (2 * w)) ≤ ((2 * p + 1) * (p + 5)) * ((2 * p + 1) * (p + 5)) :=
    mul_le_mul hcu hcu (by positivity) (by positivity)
  have hcu3 : ((p : ℤ) + 1) * ((c : ℤ) * (2 * w)) ≤ ((p : ℤ) + 1) * ((2 * p + 1) * (p + 5)) :=
    mul_le_mul_of_nonneg_left hcu (by positivity)
  have hG : (p : ℤ) ^ 5 ≤ 16 * p ^ 4 + 208 * p ^ 3 + 776 * p ^ 2 + 704 * p + 184 := by
    linarith
  by_contra hp
  push Not at hp
  have hp27 : (27 : ℤ) ≤ p := by exact_mod_cast hp
  have a0 : (0 : ℤ) ≤ p - 27 := by linarith
  have a1 := mul_nonneg (pow_nonneg hp0 4) a0
  have a2 := mul_nonneg (pow_nonneg hp0 3) a0
  have a3 := mul_nonneg (pow_nonneg hp0 2) a0
  have a4 := mul_nonneg hp0 a0
  linarith

/-- 6. k ≤ 28, p ≤ 32, X ≥ 262144: w < 34848. -/
theorem q4_w_bound_large {p X A k c w : ℕ} (hp3 : 3 ≤ p) (hp : p ≤ 32)
    (hA : 2 * (p + 1) * A = p * X + c) (hc : c ≤ 2 * p + 1) (hk : k ≤ 28) (hX : 262144 ≤ X)
    (hδ : k * A ^ 2 < 4 * X ^ 2)
    (hwb : (4 * X ^ 2 - k * A ^ 2) * w < 4 * X ^ 2 - k * A) : w < 34848 := by
  -- (a) k p² < 16 (p+1)²
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
  have h6 : k * p * c ≤ 28 * 32 * 65 := Nat.mul_le_mul (Nat.mul_le_mul hk hp) (by omega)
  have h7 : k * c ^ 2 ≤ 28 * 65 ^ 2 := Nat.mul_le_mul hk (Nat.pow_le_pow_left (by omega) 2)
  have hAA : A ≤ A ^ 2 := Nat.le_self_pow two_ne_zero A
  have hkA : k * A ≤ 4 * X ^ 2 := le_trans (Nat.mul_le_mul_left k hAA) hδ.le
  zify [hδ.le, hkA] at hwb
  have hδz : (k : ℤ) * A ^ 2 < 4 * X ^ 2 := by exact_mod_cast hδ
  have h5z : (k : ℤ) * p ^ 2 + 1 ≤ 16 * ((p : ℤ) + 1) ^ 2 := by exact_mod_cast h5
  have h6z : (k : ℤ) * p * c ≤ 58240 := by exact_mod_cast h6
  have h7z : (k : ℤ) * c ^ 2 ≤ 118300 := by exact_mod_cast h7
  have hAz : 2 * ((p : ℤ) + 1) * A = p * X + c := by exact_mod_cast hA
  have hXz : (262144 : ℤ) ≤ X := by exact_mod_cast hX
  have hpz : (p : ℤ) ≤ 32 := by exact_mod_cast hp
  have hp0 : (0 : ℤ) ≤ p := by positivity
  have hw0 : (0 : ℤ) ≤ w := by positivity
  have hX0 : (0 : ℤ) ≤ X := by positivity
  have hkA0 : (0 : ℤ) ≤ (k : ℤ) * A := by positivity
  -- identity
  have hid : 4 * ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2 - k * A ^ 2)
      = (16 * ((p : ℤ) + 1) ^ 2 - k * p ^ 2) * X ^ 2 - 2 * (k * p * c) * X - k * c ^ 2 := by
    have e : 4 * ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2 - k * A ^ 2)
        = 16 * ((p : ℤ) + 1) ^ 2 * X ^ 2 - k * (2 * ((p : ℤ) + 1) * A) ^ 2 := by ring
    rw [e, hAz]; ring
  have s1 : (X : ℤ) ^ 2 ≤ (16 * ((p : ℤ) + 1) ^ 2 - k * p ^ 2) * X ^ 2 := by
    have := mul_le_mul_of_nonneg_right (by linarith : (1 : ℤ) ≤ 16 * ((p : ℤ) + 1) ^ 2 - k * p ^ 2)
      (sq_nonneg (X : ℤ))
    linarith
  have s2 : 2 * ((k : ℤ) * p * c) * X ≤ 116480 * X := by
    have := mul_le_mul_of_nonneg_right h6z hX0
    linarith
  have s3 : (X : ℤ) * 29184 ≤ X * (X - 232960) :=
    mul_le_mul_of_nonneg_left (by linarith) hX0
  have hX2 : (X : ℤ) ^ 2 ≤ 8 * ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2 - k * A ^ 2) := by
    nlinarith
  have hδw : (4 * (X : ℤ) ^ 2 - k * A ^ 2) * w < 4 * X ^ 2 := by linarith
  have t1 := mul_le_mul_of_nonneg_right hX2 hw0
  have t2 : 8 * ((p : ℤ) + 1) ^ 2 * ((4 * (X : ℤ) ^ 2 - k * A ^ 2) * w)
      < 8 * ((p : ℤ) + 1) ^ 2 * (4 * X ^ 2) := mul_lt_mul_of_pos_left hδw (by positivity)
  have hp1 : ((p : ℤ) + 1) * (p + 1) ≤ 33 * 33 :=
    mul_le_mul (by linarith) (by linarith) (by positivity) (by norm_num)
  by_contra hw
  push Not at hw
  have hwz : (34848 : ℤ) ≤ w := by exact_mod_cast hw
  have t3 := mul_le_mul_of_nonneg_left hwz (sq_nonneg (X : ℤ))
  have t4 := mul_le_mul_of_nonneg_left hp1 (sq_nonneg (X : ℤ))
  nlinarith
