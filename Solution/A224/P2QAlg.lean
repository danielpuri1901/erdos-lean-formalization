import FormalConjectures.OEIS.«224»

/-! a000224 deep attempt, route Q2 (family p²q), algebraic lemmas: the mod-p divisibility forced by (E),
and the impossibility of (E) for k = 16 (discriminant strictly between consecutive squares). -/

namespace A224Deep

/-- Q2.4 (mod p). If (E) holds and `p` is odd, then `p ∣ k w (w − 1) + 1`. -/
theorem q2_dvd {p k w : ℕ} (hp3 : 3 ≤ p) (hodd : p % 2 = 1) (hw : 1 ≤ w)
    (hδ : k * ((p ^ 2 - p + 2) / 2) ^ 2 < 4 * p ^ 4)
    (hE : (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) * w ^ 2 + (p ^ 4 - 1)
      = (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2)) * w) :
    p ∣ k * w * (w - 1) + 1 := by
  obtain ⟨t, rfl⟩ : ∃ t, p = 2 * t + 1 := ⟨p / 2, by omega⟩
  have hA : ((2 * t + 1) ^ 2 - (2 * t + 1) + 2) / 2 = 2 * t ^ 2 + t + 1 := by
    have : (2 * t + 1) ^ 2 = 4 * t ^ 2 + 4 * t + 1 := by ring
    omega
  rw [hA] at hδ hE
  have h1 : k * (2 * t ^ 2 + t + 1) ^ 2 ≤ 4 * (2 * t + 1) ^ 4 := hδ.le
  have h2 : k * (2 * t ^ 2 + t + 1) ≤ 4 * (2 * t + 1) ^ 4 :=
    le_trans (Nat.mul_le_mul_left k (Nat.le_self_pow two_ne_zero _)) h1
  have h3 : 1 ≤ (2 * t + 1) ^ 4 := Nat.one_le_pow _ _ (by omega)
  zify [h1, h2, h3] at hE
  rw [← Int.natCast_dvd_natCast]
  push_cast [Nat.cast_sub hw]
  exact ⟨4 * (2 * (t : ℤ) + 1) ^ 3 * (w : ℤ) ^ 2 - 4 * (2 * (t : ℤ) + 1) ^ 3 * w
      + (2 * (t : ℤ) + 1) ^ 3 - k * t * (2 * (t : ℤ) ^ 2 + t + 1 + 1) * (w : ℤ) ^ 2
      + k * t * w, by linear_combination (-1 : ℤ) * hE⟩

/-- Helper: no integer square strictly between consecutive squares. -/
theorem q2_no_sq_between {D a s : ℤ} (ha : 0 ≤ a) (h1 : a ^ 2 < D) (h2 : D < (a + 1) ^ 2)
    (hs : s ^ 2 = D) : False := by
  have hl : |a| < |s| := sq_lt_sq.mp (by rw [hs]; exact h1)
  have hu : |s| < |a + 1| := sq_lt_sq.mp (by rw [hs]; exact h2)
  rw [abs_of_nonneg ha] at hl
  rw [abs_of_nonneg (by linarith : (0 : ℤ) ≤ a + 1)] at hu
  have := Int.add_one_le_of_lt hl
  linarith

/-- Q2.3 (k = 16). (E) with `k = 16` has no solution with `p ≥ 3`, `w ≥ 2`. -/
theorem q2_k16 {p w : ℕ} (hp3 : 3 ≤ p) (hw : 2 ≤ w)
    (hE : (4 * p ^ 4 - 16 * ((p ^ 2 - p + 2) / 2) ^ 2) * w ^ 2 + (p ^ 4 - 1)
      = (4 * p ^ 4 - 16 * ((p ^ 2 - p + 2) / 2)) * w) :
    False := by
  generalize hAdef : (p ^ 2 - p + 2) / 2 = A at hE
  have hp2 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  have hA : 2 * A = p ^ 2 - p + 2 := by
    obtain ⟨r, hr⟩ : Even (p * (p - 1)) := Nat.even_mul_pred_self p
    have hpp : p ^ 2 - p = p * (p - 1) := by rw [Nat.mul_sub_one, sq]
    omega
  have hA2 : 2 * A ≤ p ^ 2 := by omega
  have h1 : 16 * A ^ 2 ≤ 4 * p ^ 4 := by
    have := Nat.pow_le_pow_left hA2 2
    nlinarith [this]
  have h2 : 16 * A ≤ 4 * p ^ 4 := by
    nlinarith [h1, Nat.le_self_pow two_ne_zero A]
  have h3 : 1 ≤ p ^ 4 := Nat.one_le_pow _ _ (by omega)
  zify [h1, h2, h3] at hE
  have hA' : 2 * (A : ℤ) = (p : ℤ) ^ 2 - p + 2 := by
    have := hA
    zify [hp2] at this
    linarith
  have e1 : 16 * (A : ℤ) ^ 2 = 4 * ((p : ℤ) ^ 2 - p + 2) ^ 2 := by
    linear_combination (4 * (2 * (A : ℤ) + ((p : ℤ) ^ 2 - p + 2))) * hA'
  have e2 : 16 * (A : ℤ) = 8 * ((p : ℤ) ^ 2 - p + 2) := by
    linear_combination 8 * hA'
  have hE' : (4 * (p : ℤ) ^ 4 - 4 * ((p : ℤ) ^ 2 - p + 2) ^ 2) * (w : ℤ) ^ 2 + ((p : ℤ) ^ 4 - 1)
      = (4 * (p : ℤ) ^ 4 - 8 * ((p : ℤ) ^ 2 - p + 2)) * (w : ℤ) := by
    linear_combination hE + (w : ℤ) ^ 2 * e1 - (w : ℤ) * e2
  have hs : (2 * (4 * (p : ℤ) ^ 4 - 4 * ((p : ℤ) ^ 2 - p + 2) ^ 2) * (w : ℤ)
      - (4 * (p : ℤ) ^ 4 - 8 * ((p : ℤ) ^ 2 - p + 2))) ^ 2
      = 16 * (p : ℤ) ^ 8 - 32 * (p : ℤ) ^ 7 + 16 * (p : ℤ) ^ 6 - 96 * (p : ℤ) ^ 3
        + 240 * (p : ℤ) ^ 2 - 192 * (p : ℤ) + 192 := by
    linear_combination (4 * (4 * (p : ℤ) ^ 4 - 4 * ((p : ℤ) ^ 2 - p + 2) ^ 2)) * hE'
  generalize (2 * (4 * (p : ℤ) ^ 4 - 4 * ((p : ℤ) ^ 2 - p + 2) ^ 2) * (w : ℤ)
      - (4 * (p : ℤ) ^ 4 - 8 * ((p : ℤ) ^ 2 - p + 2))) = s at hs
  rcases le_or_gt 11 p with h11 | h11
  · have hP : (11 : ℤ) ≤ p := by exact_mod_cast h11
    have hP0 : (0 : ℤ) ≤ p := by linarith
    have ha : 0 ≤ 4 * (p : ℤ) ^ 4 - 4 * (p : ℤ) ^ 3 - 1 := by
      nlinarith [mul_nonneg (pow_nonneg hP0 3) (by linarith : (0 : ℤ) ≤ p - 2),
        pow_le_pow_left₀ (by norm_num : (0 : ℤ) ≤ 3) (by linarith : (3 : ℤ) ≤ p) 3]
    refine q2_no_sq_between (a := 4 * (p : ℤ) ^ 4 - 4 * (p : ℤ) ^ 3 - 1) ha ?_ ?_ hs
    · nlinarith [mul_nonneg (sq_nonneg (p : ℤ))
        (mul_nonneg (by linarith : (0 : ℤ) ≤ p - 11) (by linarith : (0 : ℤ) ≤ p - 2)),
        mul_nonneg hP0 (by linarith : (0 : ℤ) ≤ p - 3)]
    · nlinarith [mul_nonneg (sq_nonneg (p : ℤ)) (by linarith : (0 : ℤ) ≤ 2 * p - 5)]
  · interval_cases p <;> norm_num at hs
    · exact q2_no_sq_between (a := 214) (by norm_num) (by norm_num) (by norm_num) hs
    · exact q2_no_sq_between (a := 766) (by norm_num) (by norm_num) (by norm_num) hs
    · exact q2_no_sq_between (a := 1998) (by norm_num) (by norm_num) (by norm_num) hs
    · exact q2_no_sq_between (a := 4318) (by norm_num) (by norm_num) (by norm_num) hs
    · exact q2_no_sq_between (a := 8230) (by norm_num) (by norm_num) (by norm_num) hs
    · exact q2_no_sq_between (a := 14334) (by norm_num) (by norm_num) (by norm_num) hs
    · exact q2_no_sq_between (a := 23326) (by norm_num) (by norm_num) (by norm_num) hs
    · exact q2_no_sq_between (a := 35998) (by norm_num) (by norm_num) (by norm_num) hs

end A224Deep
