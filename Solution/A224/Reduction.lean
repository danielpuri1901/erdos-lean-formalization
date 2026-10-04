import Solution.A224.Sweep

/-! a000224 deep attempt, Q1: Diophantine structure of a putative counterexample `n = m * q`,
`q` an odd prime not dividing `m`. With `A = a m`, `w = (q+1)/2`, `n = m (2w-1)`, `a n = A w`,
and `n^2 - 1 = k · Aw (Aw - 1)`, the congruence is the quadratic
`(4m² − kA²) w² − (4m² − kA) w + (m² − 1) = 0`, and this forces `kA² < 4m²`. -/

namespace A224Deep
open OeisA224

/-- Q1 (pure Diophantine core). -/
theorem reduction_core {m A w k : ℕ} (hm : 2 ≤ m) (hA : 2 ≤ A) (hw : 2 ≤ w)
    (hk : (m * (2 * w - 1)) ^ 2 - 1 = k * (A * w) * (A * w - 1)) :
    k * A ^ 2 < 4 * m ^ 2 ∧ k * A < 4 * m ^ 2 ∧ w ∣ m ^ 2 - 1 ∧
    (4 * m ^ 2 - k * A ^ 2) * w ^ 2 + (m ^ 2 - 1) = (4 * m ^ 2 - k * A) * w ∧
    (4 * m ^ 2 - k * A ^ 2) * w < 4 * m ^ 2 - k * A := by
  have h1 : 1 ≤ 2 * w := by omega
  have h2 : 1 ≤ A * w := Nat.one_le_iff_ne_zero.mpr (Nat.mul_ne_zero (by omega) (by omega))
  have h3 : 1 ≤ (m * (2 * w - 1)) ^ 2 :=
    Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (Nat.mul_ne_zero (by omega) (by omega)))
  have hm1 : 1 ≤ m ^ 2 := Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (by omega))
  zify [h1, h2, h3] at hk
  have hM : (2:ℤ) ≤ m := by exact_mod_cast hm
  have hAz : (2:ℤ) ≤ A := by exact_mod_cast hA
  have hW : (2:ℤ) ≤ w := by exact_mod_cast hw
  have hK : (0:ℤ) ≤ k := by positivity
  have E : (4 * (m:ℤ) ^ 2 - k * A ^ 2) * w ^ 2 - (4 * (m:ℤ) ^ 2 - k * A) * w
      + ((m:ℤ) ^ 2 - 1) = 0 := by
    linear_combination hk
  have hKA0 : (0:ℤ) ≤ k * A := by positivity
  have hKA2 : 2 * ((k:ℤ) * A) ≤ k * A ^ 2 := by nlinarith
  have hiiZ : (k:ℤ) * A < 4 * (m:ℤ) ^ 2 := by
    by_contra hc
    push Not at hc
    have hY : (0:ℤ) ≤ k * A - 4 * m ^ 2 := by linarith
    have hX : (k:ℤ) * A ≤ k * A ^ 2 - 4 * m ^ 2 := by linarith
    have hXW : (k:ℤ) * A * w ^ 2 ≤ (k * A ^ 2 - 4 * m ^ 2) * w ^ 2 :=
      mul_le_mul_of_nonneg_right hX (by positivity)
    have hYW : ((k:ℤ) * A - 4 * m ^ 2) * w ≤ ((k:ℤ) * A - 4 * m ^ 2) * w ^ 2 := by
      have : (w:ℤ) ≤ (w:ℤ) ^ 2 := by nlinarith
      exact mul_le_mul_of_nonneg_left this hY
    have hMW : (m:ℤ) ^ 2 ≤ (m:ℤ) ^ 2 * w ^ 2 := by
      have : (1:ℤ) ≤ (w:ℤ) ^ 2 := by nlinarith
      nlinarith
    nlinarith
  have hiZ : (k:ℤ) * A ^ 2 < 4 * (m:ℤ) ^ 2 := by
    by_contra hc
    push Not at hc
    have hX : (0:ℤ) ≤ k * A ^ 2 - 4 * m ^ 2 := by linarith
    have hB : (0:ℤ) < 4 * m ^ 2 - k * A := by linarith
    have hX4 : 4 * ((k:ℤ) * A ^ 2 - 4 * m ^ 2) ≤ (k * A ^ 2 - 4 * m ^ 2) * w ^ 2 := by
      have : (4:ℤ) ≤ (w:ℤ) ^ 2 := by nlinarith
      nlinarith
    have hB2 : 2 * (4 * (m:ℤ) ^ 2 - k * A) ≤ (4 * m ^ 2 - k * A) * w := by nlinarith
    have hXW0 : (0:ℤ) ≤ (k * A ^ 2 - 4 * m ^ 2) * w ^ 2 := by positivity
    have hBW0 : (0:ℤ) ≤ (4 * m ^ 2 - k * A) * w := by positivity
    nlinarith
  have hi : k * A ^ 2 < 4 * m ^ 2 := by exact_mod_cast hiZ
  have hii : k * A < 4 * m ^ 2 := by exact_mod_cast hiiZ
  have hiv : (4 * m ^ 2 - k * A ^ 2) * w ^ 2 + (m ^ 2 - 1) = (4 * m ^ 2 - k * A) * w := by
    zify [hi.le, hii.le, hm1]
    linear_combination E
  have hiii : w ∣ m ^ 2 - 1 := by
    have : (w:ℤ) ∣ ((m ^ 2 - 1 : ℕ) : ℤ) := by
      refine ⟨(4 * (m:ℤ) ^ 2 - k * A) - (4 * (m:ℤ) ^ 2 - k * A ^ 2) * w, ?_⟩
      push_cast [Nat.cast_sub hm1]
      linear_combination E
    exact Int.natCast_dvd_natCast.mp this
  have hv : (4 * m ^ 2 - k * A ^ 2) * w < 4 * m ^ 2 - k * A := by
    zify [hi.le, hii.le]
    have hW0 : (0:ℤ) < w := by linarith
    have hlt : (4 * (m:ℤ) ^ 2 - k * A ^ 2) * w * w < (4 * (m:ℤ) ^ 2 - k * A) * w := by
      have : (0:ℤ) < (m:ℤ) ^ 2 - 1 := by nlinarith
      nlinarith
    exact lt_of_mul_lt_mul_right hlt hW0.le
  exact ⟨hi, hii, hiii, hiv, hv⟩

/-- Q1 applied to the conjecture: a counterexample `n = m * q` with `q` an odd prime, `q ∤ m`,
`m ≥ 2`, gives the quotient `k` and the five facts above with `A = a m`, `w = (q+1)/2`. -/
theorem reduction {m q A w : ℕ} (hm : 2 ≤ m) (hq : q.Prime) (hq2 : q ≠ 2) (hqm : ¬ q ∣ m)
    (hA : A = a m) (hw : w = (q + 1) / 2)
    (h : (m * q) ^ 2 ≡ 1 [MOD a (m * q) * (a (m * q) - 1)]) :
    ∃ k, (m * (2 * w - 1)) ^ 2 - 1 = k * (A * w) * (A * w - 1) ∧
      k * A ^ 2 < 4 * m ^ 2 ∧ k * A < 4 * m ^ 2 ∧ w ∣ m ^ 2 - 1 ∧
      (4 * m ^ 2 - k * A ^ 2) * w ^ 2 + (m ^ 2 - 1) = (4 * m ^ 2 - k * A) * w ∧
      (4 * m ^ 2 - k * A ^ 2) * w < 4 * m ^ 2 - k * A := by
  have hcop : Nat.Coprime m q :=
    (Nat.coprime_comm.mp ((Nat.Prime.coprime_iff_not_dvd hq).mpr hqm))
  rw [A224Sweep.a_mul (by omega) hq.ne_zero hcop, A224Sweep.a_prime hq hq2, ← hA, ← hw] at h
  have hqo : q % 2 = 1 := by
    rcases Nat.even_or_odd q with he | ho
    · exact absurd (hq.even_iff.mp he) hq2
    · exact Nat.odd_iff.mp ho
  have hqw : q = 2 * w - 1 := by omega
  have hq3 : 3 ≤ q := by have := hq.two_le; omega
  have hw2 : 2 ≤ w := by omega
  have hA2 : 2 ≤ A := by rw [hA]; exact A224Sweep.two_le_a hm
  have h1 : 1 ≤ (m * q) ^ 2 :=
    Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (Nat.mul_ne_zero (by omega) hq.ne_zero))
  obtain ⟨k, hk⟩ := (Nat.modEq_iff_dvd' h1).mp h.symm
  have hk' : (m * (2 * w - 1)) ^ 2 - 1 = k * (A * w) * (A * w - 1) := by
    rw [← hqw, hk]; ring
  exact ⟨k, hk', reduction_core hm hA2 hw2 hk'⟩

end A224Deep
