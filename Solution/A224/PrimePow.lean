import Solution.A224.Recursion
import Solution.A224.Sweep

/-! a000224 deep attempt, R4–R6: closed forms for `a (p^k)`, odd prime `p`, and the conjecture for
odd prime powers `p^k`, `k ≥ 2` (both sides false). -/

namespace A224Deep
open OeisA224

/-- R4a. -/
theorem a_prime_pow_odd {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (j : ℕ) :
    2 * (p + 1) * a (p ^ (2 * j + 1)) = p ^ (2 * j + 2) + 2 * p + 1 := by
  have hp3 : 3 ≤ p := by have := hp.two_le; omega
  have hodd : p % 2 = 1 := Nat.odd_iff.mp (hp.odd_of_ne_two hp2)
  induction j with
  | zero =>
    simp only [Nat.mul_zero, Nat.zero_add, pow_one]
    rw [A224Sweep.a_prime hp hp2]
    obtain ⟨t, rfl⟩ : ∃ t, p = 2 * t + 1 := ⟨p / 2, by omega⟩
    have e : (2 * t + 1 + 1) / 2 = t + 1 := by omega
    rw [e]; ring
  | succ j ih =>
    have h := two_mul_a_prime_pow_succ_succ hp hp2 (2 * j + 1)
    have e1 : 2 * j + 1 + 2 = 2 * (j + 1) + 1 := by ring
    have e2 : 2 * j + 1 + 1 = 2 * j + 2 := by ring
    rw [e1, e2] at h
    have hle : p ^ (2 * j + 2) ≤ p ^ (2 * (j + 1) + 1) := Nat.pow_le_pow_right hp.pos (by omega)
    zify [hle] at h ih ⊢
    linear_combination ((p : ℤ) + 1) * h + ih

/-- R4b. -/
theorem a_prime_pow_even {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (j : ℕ) :
    2 * (p + 1) * a (p ^ (2 * j)) = p ^ (2 * j + 1) + p + 2 := by
  induction j with
  | zero =>
    simp only [Nat.mul_zero, pow_zero, Nat.zero_add, pow_one, OeisA224.a_1]
    ring
  | succ j ih =>
    have h := two_mul_a_prime_pow_succ_succ hp hp2 (2 * j)
    have e1 : 2 * j + 2 = 2 * (j + 1) := by ring
    rw [e1] at h
    have hle : p ^ (2 * j + 1) ≤ p ^ (2 * (j + 1)) := Nat.pow_le_pow_right hp.pos (by omega)
    zify [hle] at h ih ⊢
    linear_combination ((p : ℤ) + 1) * h + ih

/-- R5. For an odd prime power `p^k` with `k ≥ 2` the congruence fails. -/
theorem not_modEq_prime_pow {p k : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (hk : 2 ≤ k) :
    ¬ (p ^ k) ^ 2 ≡ 1 [MOD a (p ^ k) * (a (p ^ k) - 1)] := by
  intro h
  have hp3 : 3 ≤ p := by have := hp.two_le; omega
  have h1 : 1 ≤ (p ^ k) ^ 2 :=
    Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (pow_ne_zero _ hp.ne_zero))
  have hM := (Nat.modEq_iff_dvd' h1).mp h.symm
  have hD : a (p ^ k) - 1 ∣ (p ^ k) ^ 2 - 1 := Dvd.dvd.trans (Dvd.intro_left _ rfl) hM
  obtain ⟨j, rfl | rfl⟩ : ∃ j, k = 2 * j ∨ k = 2 * j + 1 := ⟨k / 2, by omega⟩
  · have hj : 1 ≤ j := by omega
    have hA := a_prime_pow_even hp hp2 j
    set A := a (p ^ (2 * j)) with hAdef
    have hA1 : 1 ≤ A := by
      rcases Nat.eq_zero_or_pos A with h0 | h0
      · rw [h0] at hA; simp at hA
      · exact h0
    have hdvdZ : (p : ℤ) ∣ 2 * ((A : ℤ) - 1) := ⟨(p : ℤ) ^ (2 * j) + 1 - 2 * A, by
      have hAZ : (2 : ℤ) * ((p : ℤ) + 1) * (A : ℤ) = (p : ℤ) ^ (2 * j + 1) + p + 2 := by
        exact_mod_cast hA
      linear_combination hAZ⟩
    have hdvdN : p ∣ 2 * (A - 1) := by
      have e : ((2 * (A - 1) : ℕ) : ℤ) = 2 * ((A : ℤ) - 1) := by
        push_cast [Nat.cast_sub hA1]; ring
      rw [← e] at hdvdZ
      exact Int.natCast_dvd_natCast.mp hdvdZ
    have hcop : Nat.Coprime p 2 := (Nat.coprime_primes hp Nat.prime_two).mpr hp2
    have hpA : p ∣ A - 1 := hcop.dvd_of_dvd_mul_left hdvdN
    have h2 : p ∣ (p ^ (2 * j)) ^ 2 - 1 := hpA.trans hD
    have h3 : p ∣ (p ^ (2 * j)) ^ 2 := Dvd.dvd.pow (dvd_pow_self p (by omega)) (by norm_num)
    have h4 : p ∣ (p ^ (2 * j)) ^ 2 - ((p ^ (2 * j)) ^ 2 - 1) := Nat.dvd_sub h3 h2
    rw [Nat.sub_sub_self h1] at h4
    have := Nat.le_of_dvd one_pos h4
    omega
  · have hj : 1 ≤ j := by omega
    have hA := a_prime_pow_odd hp hp2 j
    set A := a (p ^ (2 * j + 1)) with hAdef
    have hA1 : 1 ≤ A := by
      rcases Nat.eq_zero_or_pos A with h0 | h0
      · rw [h0] at hA; simp at hA
      · exact h0
    have q1 : 1 ≤ p ^ (2 * j + 2) := Nat.one_le_pow _ _ hp.pos
    have q2 : 1 ≤ p ^ (2 * j) := Nat.one_le_pow _ _ hp.pos
    have q3 : 1 ≤ p ^ 2 := Nat.one_le_pow _ _ hp.pos
    have hDeq : 2 * (p + 1) * (A - 1) = p ^ (2 * j + 2) - 1 := by
      zify [hA1, q1] at hA ⊢
      linear_combination hA
    have hD2 : A - 1 ∣ p ^ (2 * j + 2) - 1 := ⟨2 * (p + 1), by rw [← hDeq]; ring⟩
    have hD3 : A - 1 ∣ p ^ (2 * j) - 1 := by
      have iden : (p ^ (2 * j + 1)) ^ 2 - 1
          = p ^ (2 * j) * (p ^ (2 * j + 2) - 1) + (p ^ (2 * j) - 1) := by
        have q4 : 1 ≤ (p ^ (2 * j + 1)) ^ 2 := Nat.one_le_pow _ _ (pow_pos hp.pos _)
        zify [q1, q2, q4]
        ring
      rw [iden] at hD
      exact (Nat.dvd_add_right (dvd_mul_of_dvd_right hD2 _)).mp hD
    have hD4 : A - 1 ∣ p ^ 2 - 1 := by
      have iden : p ^ (2 * j + 2) - 1 = p ^ 2 * (p ^ (2 * j) - 1) + (p ^ 2 - 1) := by
        zify [q1, q2, q3]
        ring
      rw [iden] at hD2
      exact (Nat.dvd_add_right (dvd_mul_of_dvd_right hD3 _)).mp hD2
    have hpos : 0 < p ^ 2 - 1 := by
      have : 9 ≤ p ^ 2 := by nlinarith
      omega
    have hDle : A - 1 ≤ p ^ 2 - 1 := Nat.le_of_dvd hpos hD4
    have hP4 : p ^ 4 ≤ p ^ (2 * j + 2) := Nat.pow_le_pow_right hp.pos (by omega)
    zify [hA1, q1, q3] at hDeq hDle
    have hP4Z : (p : ℤ) ^ 4 ≤ (p : ℤ) ^ (2 * j + 2) := by exact_mod_cast hP4
    have hp3Z : (3 : ℤ) ≤ p := by exact_mod_cast hp3
    have k1 : 2 * ((p : ℤ) + 1) * ((A : ℤ) - 1) ≤ 2 * ((p : ℤ) + 1) * ((p : ℤ) ^ 2 - 1) := by
      apply mul_le_mul_of_nonneg_left hDle
      positivity
    have k2 : 2 * ((p : ℤ) + 1) * ((p : ℤ) ^ 2 - 1) < (p : ℤ) ^ 4 - 1 := by
      have := mul_pos (show (0 : ℤ) < (p : ℤ) ^ 2 - 1 by nlinarith)
        (show (0 : ℤ) < (p : ℤ) ^ 2 - 2 * p - 1 by nlinarith)
      nlinarith
    nlinarith

/-- R6. The conjecture holds for odd prime powers `p^k`, `k ≥ 2` (both sides are false). -/
theorem conjecture_prime_pow {p k : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (hk : 2 ≤ k) :
    ((p ^ k).Prime ∧ p ^ k ≠ 2) ↔ (p ^ k) ^ 2 ≡ 1 [MOD a (p ^ k) * (a (p ^ k) - 1)] := by
  have hp3 : 3 ≤ p := by have := hp.two_le; omega
  constructor
  · rintro ⟨hpr, -⟩
    exfalso
    rcases hpr.eq_one_or_self_of_dvd p (dvd_pow_self p (by omega)) with h1 | h1
    · omega
    · have h5 : p ^ 2 ≤ p ^ k := Nat.pow_le_pow_right hp.pos hk
      have h6 : p < p ^ 2 := by nlinarith
      omega
  · intro h
    exact absurd h (not_modEq_prime_pow hp hp2 hk)


end A224Deep
