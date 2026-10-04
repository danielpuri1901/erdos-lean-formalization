import Solution.A224.Sweep
import Solution.A224.PrimePow
import Solution.A224.Reduction
import Solution.A224.Uniform
import Solution.A224.UniformBounds
import Solution.A224.UniformE
import Solution.A224.P4QAlg
import Solution.A224.P4QCheck

/-! a000224 deep attempt, route Q4 assembled: the conjecture holds for `n = p^e * q`, `p ≠ q` odd primes,
for every `e ≥ 4`. With `X = p^e`, `A = a (p^e)`, `2 (p+1) A = p X + c` (`c = q4c p e`), the reduction gives
`k`, `w = (q+1)/2` and equation (E); then `k ≤ 15` (w ≤ 15, p ∣ q4N e k w, e ≤ 23: `q4_small`),
`k = 16` (2w ≤ p+5; e = 4 by the discriminant squeeze `q4_k16_e4`, e ≥ 5 forces p ≤ 26, e ≤ 14:
`q4_k16_small_p`), `k ≥ 17` (k ≤ 28, p ≤ 32, e ≤ 29: `q4_large`). -/

namespace A224Deep
open OeisA224


/-- `2 (p+1) a (p^e) = p * p^e + q4c p e` for an odd prime `p` (R4a/R4b in one statement). -/
theorem two_mul_a_pow {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (e : ℕ) :
    2 * (p + 1) * a (p ^ e) = p * p ^ e + q4c p e := by
  obtain ⟨j, hj | hj⟩ := Nat.even_or_odd' e
  · subst hj
    have h := a_prime_pow_even hp hp2 j
    have hc : q4c p (2 * j) = p + 2 := by
      unfold q4c; rw [if_pos (by omega)]
    rw [hc, h]; ring
  · subst hj
    have h := a_prime_pow_odd hp hp2 j
    have hc : q4c p (2 * j + 1) = 2 * p + 1 := by
      unfold q4c; rw [if_neg (by omega)]
    rw [hc, h]; ring

/-- `q4A p e = a (p^e)` for an odd prime `p`. -/
theorem q4A_eq {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (e : ℕ) : q4A p e = a (p ^ e) := by
  unfold q4A
  rw [← two_mul_a_pow hp hp2 e]
  exact Nat.mul_div_cancel_left _ (by positivity)

/-- The `e = 4` bridge: `a (p^4) = (p^4 - p^3 + p^2 - p + 2) / 2`. -/
theorem q4_A4 {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) :
    a (p ^ 4) = (p ^ 4 - p ^ 3 + p ^ 2 - p + 2) / 2 := by
  have h := two_mul_a_pow hp hp2 4
  have hc : q4c p 4 = p + 2 := by unfold q4c; rw [if_pos (by norm_num)]
  rw [hc] at h
  have h43 : p ^ 3 ≤ p ^ 4 := Nat.pow_le_pow_right hp.pos (by norm_num)
  have h21 : p ≤ p ^ 2 := Nat.le_self_pow two_ne_zero p
  have hle2 : p ≤ p ^ 4 - p ^ 3 + p ^ 2 := by omega
  have key : p * p ^ 4 + (p + 2) = (p + 1) * (p ^ 4 - p ^ 3 + p ^ 2 - p + 2) := by
    zify [h43, hle2]; ring
  rw [key, show 2 * (p + 1) * a (p ^ 4) = (p + 1) * (2 * a (p ^ 4)) by ring] at h
  have h2 := Nat.eq_of_mul_eq_mul_left (by omega) h
  omega

/-- Q4. The congruence fails at `n = p^e * q` for distinct odd primes `p`, `q` and every `e ≥ 4`. -/
theorem not_modEq_pow_mul_prime {p q e : ℕ} (hp : p.Prime) (hq : q.Prime) (hp2 : p ≠ 2) (hq2 : q ≠ 2)
    (hpq : p ≠ q) (he : 4 ≤ e) :
    ¬ (p ^ e * q) ^ 2 ≡ 1 [MOD a (p ^ e * q) * (a (p ^ e * q) - 1)] := by
  intro h
  have hp3 : 3 ≤ p := by have := hp.two_le; omega
  have hodd : p % 2 = 1 := Nat.odd_iff.mp (hp.odd_of_ne_two hp2)
  have hqo : q % 2 = 1 := Nat.odd_iff.mp (hq.odd_of_ne_two hq2)
  have hqm : ¬ q ∣ p ^ e := fun hd =>
    hpq ((Nat.prime_dvd_prime_iff_eq hq hp).mp (hq.dvd_of_dvd_pow hd)).symm
  have hA := two_mul_a_pow hp hp2 e
  have hAq := q4A_eq hp hp2 e
  have hc1 : p + 2 ≤ q4c p e := by unfold q4c; split_ifs <;> omega
  have hc2 : q4c p e ≤ 2 * p + 1 := by unfold q4c; split_ifs <;> omega
  have hX4 : p ^ 4 ≤ p ^ e := Nat.pow_le_pow_right hp.pos he
  have hp27 : 27 ≤ p ^ 3 :=
    calc 27 = 3 ^ 3 := by norm_num
      _ ≤ p ^ 3 := Nat.pow_le_pow_left hp3 3
  have hp4 : 27 * p ≤ p ^ 4 :=
    calc 27 * p ≤ p ^ 3 * p := Nat.mul_le_mul_right p hp27
      _ = p ^ 4 := by ring
  have hX : 2 * p + 1 < p ^ e := by omega
  have hm2 : 2 ≤ p ^ e := by omega
  have hX1 : 1 ≤ p ^ e := by omega
  have hw2 : 2 ≤ (q + 1) / 2 := by have := hq.two_le; omega
  obtain ⟨k, -, hi, hii, -, hiv, hv⟩ := reduction (m := p ^ e) (q := q) (A := a (p ^ e))
    (w := (q + 1) / 2) hm2 hq hq2 hqm rfl rfl h
  generalize hwdef : (q + 1) / 2 = w at hw2 hi hii hiv hv
  rw [← hAq] at hA hi hii hiv hv
  have hA1 : 1 ≤ q4A p e := by
    have := A224Sweep.two_le_a hm2
    omega
  have hcw : p + 1 < q4c p e * w := by nlinarith
  have hXF := q4_X_le hA hA1 hX1 hi hiv hcw
  rcases Nat.lt_or_ge k 16 with hk15 | hk16
  · -- k ≤ 15
    have hw15 : w ≤ 15 := q4_w_le_15 hp3 hA hc2 hX (by omega) hv
    have hpX : p ∣ p ^ e := dvd_pow_self p (by omega)
    have hdvd : p ∣ q4N e k w := by
      unfold q4N
      split_ifs with h0
      · have hc : q4c p e = p + 2 := by unfold q4c; rw [if_pos h0]
        rw [hc] at hA
        exact q4_dvd_N_even hodd hpX (by omega) hA hA1 hX1 hi hiv
      · have hc : q4c p e = 2 * p + 1 := by unfold q4c; rw [if_neg h0]
        rw [hc] at hA
        exact q4_dvd_N_odd hodd hpX hw2 hA hA1 hX1 hi hiv
    have hN1 : k * w * (w - 1) ≤ 15 * 15 * 14 :=
      Nat.mul_le_mul (Nat.mul_le_mul (by omega) hw15) (by omega)
    have hN2 : k * w * (w - 2) ≤ 15 * 15 * 13 :=
      Nat.mul_le_mul (Nat.mul_le_mul (by omega) hw15) (by omega)
    have hN : q4N e k w ≤ 3151 := by unfold q4N; split_ifs <;> omega
    have hNpos : 0 < q4N e k w := by unfold q4N; split_ifs <;> omega
    have hpN : p ≤ 3151 := le_trans (Nat.le_of_dvd hNpos hdvd) hN
    have he24 : e < 24 :=
      q4_e_bound hp3 hXF (by omega : k ≤ 15) hpN hw15 (by omega : q4c p e ≤ 6303) (by norm_num)
    exact q4_small (by omega) hw15 hp3 hodd he (by omega) hdvd hiv
  · rcases Nat.lt_or_ge k 17 with hk17 | hk17
    · -- k = 16
      obtain rfl : k = 16 := by omega
      have hwb : 2 * w ≤ p + 5 := q4_k16_w_bound hp3 hA hc2 hX4 hv
      rcases Nat.lt_or_ge e 5 with he5 | he5
      · obtain rfl : e = 4 := by omega
        have hA4 : q4A p 4 = (p ^ 4 - p ^ 3 + p ^ 2 - p + 2) / 2 := by
          rw [hAq]; exact q4_A4 hp hp2
        rw [hA4, show (p ^ 4) ^ 2 = p ^ 8 by ring] at hiv
        exact q4_k16_e4 hp3 hw2 hiv
      · have hX5 : p ^ 5 ≤ p ^ e := Nat.pow_le_pow_right hp.pos he5
        have hXF' : ((p ^ e : ℕ) : ℤ) ≤ |(16 : ℤ) * (q4c p e) ^ 2 * w ^ 2
            - 2 * 16 * (p + 1) * (q4c p e) * w + 4 * (p + 1) ^ 2| := by
          exact_mod_cast hXF
        have hp26 : p ≤ 26 := q4_k16_p_le hp3 hc2 hwb hX5 hXF'
        have hw15 : w ≤ 15 := by omega
        have he15 : e < 15 :=
          q4_e_bound hp3 hXF (le_refl 16) hp26 hw15 (by omega : q4c p e ≤ 53) (by norm_num)
        exact q4_k16_small_p hp3 hodd hp26 he5 (by omega) hw2 hwb hiv
    · -- k ≥ 17
      have hk28 : k ≤ 28 := q4_k_le_28 hp3 hA hX1 hi
      have hp32 : p ≤ 32 := q4_p_le_32 hp3 hA hX1 hk17 hi
      have he30 : e < 30 := by
        rcases Nat.lt_or_ge (p ^ e) 262144 with hXs | hXl
        · have h3 : 3 ^ e ≤ p ^ e := Nat.pow_le_pow_left hp3 e
          have h12 : 3 ^ e < 3 ^ 12 := lt_of_le_of_lt h3 (lt_trans hXs (by norm_num))
          have := (Nat.pow_lt_pow_iff_right (by norm_num : 1 < 3)).mp h12
          omega
        · have hw' : w < 34848 := q4_w_bound_large hp3 hp32 hA hc2 hk28 hXl hi hv
          exact q4_e_bound hp3 hXF hk28 hp32 (by omega : w ≤ 34847) (by omega : q4c p e ≤ 65)
            (by norm_num)
      exact q4_large hk17 hk28 hp3 hodd hp32 he (by omega) hw2 hi hv hiv

/-- The conjecture holds for `n = p^e * q`, `p ≠ q` odd primes, `e ≥ 4` (both sides false). -/
theorem conjecture_pow_mul_prime {p q e : ℕ} (hp : p.Prime) (hq : q.Prime) (hp2 : p ≠ 2) (hq2 : q ≠ 2)
    (hpq : p ≠ q) (he : 4 ≤ e) :
    ((p ^ e * q).Prime ∧ p ^ e * q ≠ 2) ↔
      (p ^ e * q) ^ 2 ≡ 1 [MOD a (p ^ e * q) * (a (p ^ e * q) - 1)] := by
  constructor
  · rintro ⟨hpr, -⟩
    exfalso
    have hp3 : 3 ≤ p := by have := hp.two_le; omega
    have hq1 : 1 ≤ q := hq.one_lt.le
    have hlt : p < p ^ e * q := by
      have h1 : p < p ^ 2 := by nlinarith
      have h1' : p ^ 2 ≤ p ^ e := Nat.pow_le_pow_right (by omega) (by omega)
      have h2 : p ^ e ≤ p ^ e * q := Nat.le_mul_of_pos_right _ hq1
      omega
    rcases hpr.eq_one_or_self_of_dvd p
        (dvd_mul_of_dvd_left (dvd_pow_self p (by omega : e ≠ 0)) q) with h | h
    · omega
    · omega
  · intro h
    exact absurd h (not_modEq_pow_mul_prime hp hq hp2 hq2 hpq he)


end A224Deep
