import Solution.A224.Sweep
import Solution.A224.PrimePow
import Solution.A224.Reduction
import Solution.A224.P3QCheck
import Solution.A224.P3QAlg

/-! a000224 deep attempt, family p³q assembled: the conjecture holds for `n = p^3 * q`, `p ≠ q` odd primes. -/

namespace A224Deep
open OeisA224

/-- For odd `p`, `p^3 - p^2 + p + 1` is even. -/
theorem q3_two_mul_half {p : ℕ} (hodd : p % 2 = 1) :
    2 * ((p ^ 3 - p ^ 2 + p + 1) / 2) = p ^ 3 - p ^ 2 + p + 1 := by
  obtain ⟨t, rfl⟩ : ∃ t, p = 2 * t + 1 := ⟨p / 2, by omega⟩
  have e3 : (2 * t + 1) ^ 3 = 8 * t ^ 3 + 12 * t ^ 2 + 6 * t + 1 := by ring
  have e2 : (2 * t + 1) ^ 2 = 4 * t ^ 2 + 4 * t + 1 := by ring
  rw [e3, e2]
  omega

/-- `a (p^3) = (p^3 - p^2 + p + 1) / 2` for an odd prime `p`. -/
theorem two_mul_a_cube {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) :
    2 * a (p ^ 3) = p ^ 3 - p ^ 2 + p + 1 := by
  have h := a_prime_pow_odd hp hp2 1
  rw [show 2 * 1 + 1 = 3 from rfl, show 2 * 1 + 2 = 4 from rfl] at h
  have hle : p ^ 2 ≤ p ^ 3 := Nat.pow_le_pow_right hp.pos (by norm_num)
  have key : p ^ 4 + 2 * p + 1 = (p + 1) * (p ^ 3 - p ^ 2 + p + 1) := by
    zify [hle]; ring
  rw [key, show 2 * (p + 1) * a (p ^ 3) = (p + 1) * (2 * a (p ^ 3)) by ring] at h
  exact Nat.eq_of_mul_eq_mul_left (by omega) h

theorem q3_k_le_24 {p k : ℕ} (hp3 : 3 ≤ p) (hodd : p % 2 = 1)
    (h : k * ((p ^ 3 - p ^ 2 + p + 1) / 2) ^ 2 < 4 * p ^ 6) : k ≤ 24 := by
  have hA : 2 * ((p ^ 3 - p ^ 2 + p + 1) / 2) = p ^ 3 - p ^ 2 + p + 1 := q3_two_mul_half hodd
  generalize (p ^ 3 - p ^ 2 + p + 1) / 2 = A at h hA
  have hle : p ^ 2 ≤ p ^ 3 := Nat.pow_le_pow_right (by omega) (by norm_num)
  by_contra hk
  push Not at hk
  have h25 : 25 * A ^ 2 ≤ k * A ^ 2 := Nat.mul_le_mul_right _ (by omega)
  have h100 : 100 * A ^ 2 < 16 * p ^ 6 := by omega
  zify [hle] at hA h100
  have hX : 25 * ((p : ℤ) ^ 3 - p ^ 2 + p + 1) ^ 2 < 16 * (p : ℤ) ^ 6 := by
    have : (25 : ℤ) * ((p : ℤ) ^ 3 - p ^ 2 + p + 1) ^ 2 = 100 * (A : ℤ) ^ 2 := by
      rw [← hA]; ring
    linarith
  rcases Nat.lt_or_ge p 6 with h6 | h6
  · interval_cases p <;> norm_num at hX
  · have hp0 : (0 : ℤ) ≤ p := by positivity
    have h6' : (0 : ℤ) ≤ (p : ℤ) - 6 := by
      have : (6 : ℤ) ≤ p := by exact_mod_cast h6
      linarith
    have h75 : (0 : ℤ) ≤ 75 * (p : ℤ) ^ 2 - 25 := by nlinarith
    nlinarith [mul_nonneg (pow_nonneg hp0 5) h6', mul_nonneg (pow_nonneg hp0 2) h75,
      pow_nonneg hp0 5]

theorem q3_p_le_32 {p k : ℕ} (hp3 : 3 ≤ p) (hodd : p % 2 = 1) (hk : 17 ≤ k)
    (h : k * ((p ^ 3 - p ^ 2 + p + 1) / 2) ^ 2 < 4 * p ^ 6) : p ≤ 32 := by
  have hA : 2 * ((p ^ 3 - p ^ 2 + p + 1) / 2) = p ^ 3 - p ^ 2 + p + 1 := q3_two_mul_half hodd
  generalize (p ^ 3 - p ^ 2 + p + 1) / 2 = A at h hA
  have hle : p ^ 2 ≤ p ^ 3 := Nat.pow_le_pow_right (by omega) (by norm_num)
  by_contra hp
  push Not at hp
  have h17 : 17 * A ^ 2 ≤ k * A ^ 2 := Nat.mul_le_mul_right _ hk
  have h68 : 68 * A ^ 2 < 16 * p ^ 6 := by omega
  zify [hle] at hA h68
  have hX : 17 * ((p : ℤ) ^ 3 - p ^ 2 + p + 1) ^ 2 < 16 * (p : ℤ) ^ 6 := by
    have : (17 : ℤ) * ((p : ℤ) ^ 3 - p ^ 2 + p + 1) ^ 2 = 68 * (A : ℤ) ^ 2 := by
      rw [← hA]; ring
    linarith
  rcases Nat.lt_or_ge p 34 with h34 | h34
  · interval_cases p; norm_num at hX
  · have hp0 : (0 : ℤ) ≤ p := by positivity
    have h34' : (0 : ℤ) ≤ (p : ℤ) - 34 := by
      have : (34 : ℤ) ≤ p := by exact_mod_cast h34
      linarith
    have h51 : (0 : ℤ) ≤ 51 * (p : ℤ) ^ 2 - 17 := by nlinarith
    nlinarith [mul_nonneg (pow_nonneg hp0 5) h34', mul_nonneg (pow_nonneg hp0 2) h51]

theorem q3_w_le_15 {p k w : ℕ} (hp3 : 3 ≤ p) (hodd : p % 2 = 1) (hk : k ≤ 15)
    (hwb : (4 * p ^ 6 - k * ((p ^ 3 - p ^ 2 + p + 1) / 2) ^ 2) * w
      < 4 * p ^ 6 - k * ((p ^ 3 - p ^ 2 + p + 1) / 2)) :
    w ≤ 15 := by
  have hA : 2 * ((p ^ 3 - p ^ 2 + p + 1) / 2) = p ^ 3 - p ^ 2 + p + 1 := q3_two_mul_half hodd
  generalize (p ^ 3 - p ^ 2 + p + 1) / 2 = A at hwb hA
  have hle : p ^ 2 ≤ p ^ 3 := Nat.pow_le_pow_right (by omega) (by norm_num)
  have hp1 : p + 1 ≤ p ^ 2 := by nlinarith
  have hC : 2 * A ≤ p ^ 3 := by omega
  have h4 : 4 * A ^ 2 ≤ p ^ 6 :=
    calc 4 * A ^ 2 = (2 * A) ^ 2 := by ring
      _ ≤ (p ^ 3) ^ 2 := Nat.pow_le_pow_left hC 2
      _ = p ^ 6 := by ring
  have h60 : 60 * A ^ 2 + p ^ 6 ≤ 16 * p ^ 6 := by omega
  have hkA : k * A ^ 2 ≤ 15 * A ^ 2 := Nat.mul_le_mul_right _ hk
  have hD : p ^ 6 ≤ 4 * (4 * p ^ 6 - k * A ^ 2) := by omega
  have h1 : (4 * p ^ 6 - k * A ^ 2) * w < 4 * p ^ 6 := lt_of_lt_of_le hwb (Nat.sub_le _ _)
  have h2 : p ^ 6 * w ≤ 4 * (4 * p ^ 6 - k * A ^ 2) * w := Nat.mul_le_mul_right w hD
  rw [mul_assoc] at h2
  have h3 : p ^ 6 * w < p ^ 6 * 16 := by omega
  have := Nat.lt_of_mul_lt_mul_left h3
  omega

/-- The congruence fails at `n = p^3 * q` for distinct odd primes `p`, `q`. -/
theorem not_modEq_cube_mul_prime {p q : ℕ} (hp : p.Prime) (hq : q.Prime) (hp2 : p ≠ 2) (hq2 : q ≠ 2)
    (hpq : p ≠ q) : ¬ (p ^ 3 * q) ^ 2 ≡ 1 [MOD a (p ^ 3 * q) * (a (p ^ 3 * q) - 1)] := by
  intro h
  have hp3 : 3 ≤ p := by have := hp.two_le; omega
  have hq3 : 3 ≤ q := by have := hq.two_le; omega
  have hodd : p % 2 = 1 := Nat.odd_iff.mp (hp.odd_of_ne_two hp2)
  have hqo : q % 2 = 1 := Nat.odd_iff.mp (hq.odd_of_ne_two hq2)
  have hqm : ¬ q ∣ p ^ 3 := by
    intro hd
    exact hpq ((Nat.prime_dvd_prime_iff_eq hq hp).mp (hq.dvd_of_dvd_pow hd)).symm
  have hA : (p ^ 3 - p ^ 2 + p + 1) / 2 = a (p ^ 3) := by
    have := two_mul_a_cube hp hp2
    omega
  have hw2 : 2 ≤ (q + 1) / 2 := by omega
  have hm2 : 2 ≤ p ^ 3 :=
    calc 2 ≤ p := by omega
      _ ≤ p ^ 3 := Nat.le_self_pow (by norm_num) p
  obtain ⟨k, -, hi, hii, -, hiv, hv⟩ := reduction (m := p ^ 3) (q := q)
    (A := (p ^ 3 - p ^ 2 + p + 1) / 2) (w := (q + 1) / 2) hm2 hq hq2 hqm hA rfl h
  rw [show (p ^ 3) ^ 2 = p ^ 6 by ring] at hi hii hiv hv
  rcases Nat.lt_or_ge k 16 with hk15 | hk16
  · have hw15 := q3_w_le_15 hp3 hodd (by omega) hv
    have hdvd := q3_dvd hp3 hodd hw2 hi hiv
    exact q3_small (by omega) hw15 hp3 hdvd hiv
  · rcases Nat.lt_or_ge k 17 with h17 | h17
    · obtain rfl : k = 16 := by omega
      exact q3_k16 hp3 hodd hw2 hiv
    · have hk24 := q3_k_le_24 hp3 hodd hi
      have hp32 := q3_p_le_32 hp3 hodd h17 hi
      exact q3_large h17 hk24 hp3 hp32 hw2 hi hv hiv

/-- The conjecture holds for `n = p^3 * q`, `p ≠ q` odd primes (both sides false). -/
theorem conjecture_cube_mul_prime {p q : ℕ} (hp : p.Prime) (hq : q.Prime) (hp2 : p ≠ 2) (hq2 : q ≠ 2)
    (hpq : p ≠ q) :
    ((p ^ 3 * q).Prime ∧ p ^ 3 * q ≠ 2) ↔ (p ^ 3 * q) ^ 2 ≡ 1 [MOD a (p ^ 3 * q) * (a (p ^ 3 * q) - 1)] := by
  constructor
  · rintro ⟨hpr, -⟩
    exfalso
    have hp3 : 3 ≤ p := by have := hp.two_le; omega
    have hq1 : 1 ≤ q := hq.one_lt.le
    have hlt : p < p ^ 3 * q := by
      have h1 : p < p ^ 2 := by nlinarith
      have h1' : p ^ 2 ≤ p ^ 3 := Nat.pow_le_pow_right (by omega) (by norm_num)
      have h2 : p ^ 3 ≤ p ^ 3 * q := Nat.le_mul_of_pos_right _ hq1
      omega
    rcases hpr.eq_one_or_self_of_dvd p
        (dvd_mul_of_dvd_left (dvd_pow_self p (by norm_num : (3 : ℕ) ≠ 0)) q) with h | h
    · omega
    · omega
  · intro h
    exact absurd h (not_modEq_cube_mul_prime hp hq hp2 hq2 hpq)

end A224Deep
