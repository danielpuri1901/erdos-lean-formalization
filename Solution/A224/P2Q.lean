import Solution.A224.Sweep
import Solution.A224.PrimePow
import Solution.A224.Reduction
import Solution.A224.P2QCheck
import Solution.A224.P2QAlg

/-! a000224 deep attempt, route Q2 assembled: the conjecture holds for `n = p^2 * q`, `p ≠ q` odd primes. -/

namespace A224Deep
open OeisA224

/-- Q2.0. `a (p^2) = (p^2 - p + 2) / 2` for an odd prime `p`. -/
theorem two_mul_a_sq {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) : 2 * a (p ^ 2) = p ^ 2 - p + 2 := by
  have h := a_prime_pow_even hp hp2 1
  rw [show 2 * 1 = 2 from rfl, show 2 + 1 = 3 from rfl] at h
  have hp1 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  have key : p ^ 3 + p + 2 = (p + 1) * (p ^ 2 - p + 2) := by
    zify [hp1]; ring
  rw [key, show 2 * (p + 1) * a (p ^ 2) = (p + 1) * (2 * a (p ^ 2)) by ring] at h
  exact Nat.eq_of_mul_eq_mul_left (by omega) h

/-- Q2.1. -/
theorem q2_k_le_20 {p k : ℕ} (hp3 : 3 ≤ p) (h : k * ((p ^ 2 - p + 2) / 2) ^ 2 < 4 * p ^ 4) : k ≤ 20 := by
  generalize hAdef : (p ^ 2 - p + 2) / 2 = A at h
  have hp2 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  have hA : 2 * A = p ^ 2 - p + 2 := by
    obtain ⟨r, hr⟩ : Even (p * (p - 1)) := Nat.even_mul_pred_self p
    have hpp : p ^ 2 - p = p * (p - 1) := by rw [Nat.mul_sub_one, sq]
    omega
  by_contra hk
  push Not at hk
  have h21 : 21 * A ^ 2 ≤ k * A ^ 2 := Nat.mul_le_mul_right _ (by omega)
  have h84 : 84 * A ^ 2 < 16 * p ^ 4 := by omega
  zify [hp2] at hA h84
  have hX : 21 * ((p : ℤ) ^ 2 - p + 2) ^ 2 < 16 * (p : ℤ) ^ 4 := by
    have : (21 : ℤ) * ((p : ℤ) ^ 2 - p + 2) ^ 2 = 84 * (A : ℤ) ^ 2 := by
      rw [← hA]; ring
    linarith
  rcases Nat.lt_or_ge p 9 with h9 | h9
  · interval_cases p <;> norm_num at hX
  · have hp0 : (0 : ℤ) ≤ p := by positivity
    have h9' : (0 : ℤ) ≤ (p : ℤ) - 9 := by
      have : (9 : ℤ) ≤ p := by exact_mod_cast h9
      linarith
    have h54 : (0 : ℤ) ≤ 5 * (p : ℤ) - 4 := by linarith
    nlinarith [mul_nonneg (pow_nonneg hp0 3) h9', pow_nonneg hp0 3, mul_nonneg hp0 h54]

/-- Q2.2 (bound). -/
theorem q2_p_le_31 {p k : ℕ} (hp3 : 3 ≤ p) (hk : 17 ≤ k)
    (h : k * ((p ^ 2 - p + 2) / 2) ^ 2 < 4 * p ^ 4) : p ≤ 31 := by
  generalize hAdef : (p ^ 2 - p + 2) / 2 = A at h
  have hp2 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  have hA : 2 * A = p ^ 2 - p + 2 := by
    obtain ⟨r, hr⟩ : Even (p * (p - 1)) := Nat.even_mul_pred_self p
    have hpp : p ^ 2 - p = p * (p - 1) := by rw [Nat.mul_sub_one, sq]
    omega
  by_contra hp
  push Not at hp
  have h17 : 17 * A ^ 2 ≤ k * A ^ 2 := Nat.mul_le_mul_right _ hk
  have h68 : 68 * A ^ 2 < 16 * p ^ 4 := by omega
  zify [hp2] at hA h68
  have hX : 17 * ((p : ℤ) ^ 2 - p + 2) ^ 2 < 16 * (p : ℤ) ^ 4 := by
    have : (17 : ℤ) * ((p : ℤ) ^ 2 - p + 2) ^ 2 = 68 * (A : ℤ) ^ 2 := by
      rw [← hA]; ring
    linarith
  rcases Nat.lt_or_ge p 34 with h34 | h34
  · interval_cases p <;> norm_num at hX
  · have hp0 : (0 : ℤ) ≤ p := by positivity
    have h34' : (0 : ℤ) ≤ (p : ℤ) - 34 := by
      have : (34 : ℤ) ≤ p := by exact_mod_cast h34
      linarith
    have h54 : (0 : ℤ) ≤ 85 * (p : ℤ) - 68 := by linarith
    nlinarith [mul_nonneg (pow_nonneg hp0 3) h34', pow_nonneg hp0 3, mul_nonneg hp0 h54]

/-- Q2.4 (bound). -/
theorem q2_w_le_15 {p k w : ℕ} (hp3 : 3 ≤ p) (hk : k ≤ 15)
    (hwb : (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) * w < 4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2)) :
    w ≤ 15 := by
  generalize hAdef : (p ^ 2 - p + 2) / 2 = A at hwb
  have hp2 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  have hA : 2 * A = p ^ 2 - p + 2 := by
    obtain ⟨r, hr⟩ : Even (p * (p - 1)) := Nat.even_mul_pred_self p
    have hpp : p ^ 2 - p = p * (p - 1) := by rw [Nat.mul_sub_one, sq]
    omega
  have h60 : 60 * A ^ 2 + p ^ 4 ≤ 16 * p ^ 4 := by
    zify [hp2] at hA ⊢
    have e : (60 : ℤ) * (A : ℤ) ^ 2 = 15 * ((p : ℤ) ^ 2 - p + 2) ^ 2 := by
      rw [← hA]; ring
    have hp0 : (0 : ℤ) ≤ p := by positivity
    have h3' : (0 : ℤ) ≤ (p : ℤ) - 3 := by
      have : (3 : ℤ) ≤ p := by exact_mod_cast hp3
      linarith
    nlinarith [mul_nonneg (mul_nonneg hp0 hp0) h3', mul_nonneg hp0 hp0]
  have hkA : k * A ^ 2 ≤ 15 * A ^ 2 := Nat.mul_le_mul_right _ hk
  have hD : p ^ 4 ≤ 4 * (4 * p ^ 4 - k * A ^ 2) := by omega
  have h1 : (4 * p ^ 4 - k * A ^ 2) * w < 4 * p ^ 4 := lt_of_lt_of_le hwb (Nat.sub_le _ _)
  have h2 : p ^ 4 * w ≤ 4 * (4 * p ^ 4 - k * A ^ 2) * w := Nat.mul_le_mul_right w hD
  rw [mul_assoc] at h2
  have h3 : p ^ 4 * w < p ^ 4 * 16 := by omega
  have := Nat.lt_of_mul_lt_mul_left h3
  omega

/-- Q2.5. The congruence fails at `n = p^2 * q` for distinct odd primes `p`, `q`. -/
theorem not_modEq_sq_mul_prime {p q : ℕ} (hp : p.Prime) (hq : q.Prime) (hp2 : p ≠ 2) (hq2 : q ≠ 2)
    (hpq : p ≠ q) : ¬ (p ^ 2 * q) ^ 2 ≡ 1 [MOD a (p ^ 2 * q) * (a (p ^ 2 * q) - 1)] := by
  intro h
  have hp3 : 3 ≤ p := by have := hp.two_le; omega
  have hq3 : 3 ≤ q := by have := hq.two_le; omega
  have hodd : p % 2 = 1 := Nat.odd_iff.mp (hp.odd_of_ne_two hp2)
  have hqo : q % 2 = 1 := Nat.odd_iff.mp (hq.odd_of_ne_two hq2)
  have hqm : ¬ q ∣ p ^ 2 := by
    intro hd
    exact hpq ((Nat.prime_dvd_prime_iff_eq hq hp).mp (hq.dvd_of_dvd_pow hd)).symm
  have hA : (p ^ 2 - p + 2) / 2 = a (p ^ 2) := by
    have := two_mul_a_sq hp hp2
    omega
  have hw2 : 2 ≤ (q + 1) / 2 := by omega
  obtain ⟨k, -, hi, hii, -, hiv, hv⟩ := reduction (m := p ^ 2) (q := q)
    (A := (p ^ 2 - p + 2) / 2) (w := (q + 1) / 2) (by nlinarith) hq hq2 hqm hA rfl h
  rw [show (p ^ 2) ^ 2 = p ^ 4 by ring] at hi hii hiv hv
  rcases Nat.lt_or_ge k 16 with hk15 | hk16
  · have hw15 := q2_w_le_15 hp3 (by omega) hv
    have hdvd := q2_dvd hp3 hodd (by omega) hi hiv
    have hpw := q2_small (by omega) hw15 hp3 hdvd hiv
    exact hpq (by omega)
  · rcases Nat.lt_or_ge k 17 with h17 | h17
    · obtain rfl : k = 16 := by omega
      exact q2_k16 hp3 hw2 hiv
    · have hk20 := q2_k_le_20 hp3 hi
      have hp31 := q2_p_le_31 hp3 h17 hi
      exact q2_large h17 hk20 hp3 hp31 hw2 hi hv hiv

/-- The conjecture holds for `n = p^2 * q`, `p ≠ q` odd primes (both sides false). -/
theorem conjecture_sq_mul_prime {p q : ℕ} (hp : p.Prime) (hq : q.Prime) (hp2 : p ≠ 2) (hq2 : q ≠ 2)
    (hpq : p ≠ q) :
    ((p ^ 2 * q).Prime ∧ p ^ 2 * q ≠ 2) ↔ (p ^ 2 * q) ^ 2 ≡ 1 [MOD a (p ^ 2 * q) * (a (p ^ 2 * q) - 1)] := by
  constructor
  · rintro ⟨hpr, -⟩
    exfalso
    have hp3 : 3 ≤ p := by have := hp.two_le; omega
    have hq1 : 1 ≤ q := hq.one_lt.le
    have hlt : p < p ^ 2 * q := by
      have h1 : p < p ^ 2 := by nlinarith
      have h2 : p ^ 2 ≤ p ^ 2 * q := Nat.le_mul_of_pos_right _ hq1
      omega
    rcases hpr.eq_one_or_self_of_dvd p (dvd_mul_of_dvd_left (dvd_pow_self p two_ne_zero) q) with h | h
    · omega
    · omega
  · intro h
    exact absurd h (not_modEq_sq_mul_prime hp hq hp2 hq2 hpq)

end A224Deep
