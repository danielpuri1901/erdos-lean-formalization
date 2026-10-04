import FormalConjectures.OEIS.«76495»

/-! Sweep work for a076495: σ(x) mod x = 5.

Fully proved here:
* `sigma_ne_add_five`: σ(x) ≠ x + 5 (5 is untouchable).
* `sq_or_two_sq_of_odd_sigma`: σ(n) odd → n is a square or twice a square.
* `reduction`: σ(x) mod x = 5 with x > 0 → x is a square, twice a square,
  or x is odd with σ(x) ≥ 3x + 5.
* `a5_zero_or_special`: the same statement for `OeisA76495.a 5`.
* `small_check`: no x < 300 has σ(x) mod x = 5 (kernel `decide`).

The open conjecture `OeisA76495.conjecture` itself is NOT proved.
See `sweep/a076495/NOTES.md` for the paper proofs and the computer search. -/

open ArithmeticFunction

namespace A076495Sweep

/-- Lemma 1: 5 is untouchable, i.e. σ(x) ≠ x + 5. -/
theorem sigma_ne_add_five (x : Nat) : sigma 1 x ≠ x + 5 := by
  intro hx
  have hdec : ∀ y, y < 17 → sigma 1 y ≠ y + 5 := by decide
  rcases Nat.lt_or_ge x 2 with h2 | h2
  · exact hdec x (by omega) hx
  have hx' := hx
  rw [sigma_one_apply, Nat.sum_divisors_eq_sum_properDivisors_add_self] at hx'
  have hp5 : ∑ i ∈ x.properDivisors, i = 5 := by omega
  by_cases hpr : x.Prime
  · rw [hpr.properDivisors] at hp5
    simp at hp5
  · set p := x.minFac with hpdef
    have hp2 : p ^ 2 ≤ x := Nat.minFac_sq_le_self (by omega) hpr
    have hpd : p ∣ x := Nat.minFac_dvd x
    have hp1 : 2 ≤ p := (Nat.minFac_prime (by omega)).two_le
    set q := x / p with hqdef
    have hqx : x = p * q := (Nat.mul_div_cancel' hpd).symm
    have hpq : p ≤ q := by nlinarith
    have hq_mem : q ∈ x.properDivisors :=
      Nat.mem_properDivisors.mpr ⟨Nat.div_dvd_of_dvd hpd, by nlinarith⟩
    have h1_mem : 1 ∈ x.properDivisors :=
      Nat.mem_properDivisors.mpr ⟨one_dvd _, by omega⟩
    have hq1 : (1 : Nat) ≠ q := by omega
    have hsub : ({1, q} : Finset Nat) ⊆ x.properDivisors := by
      intro d hd
      simp only [Finset.mem_insert, Finset.mem_singleton] at hd
      rcases hd with rfl | rfl <;> assumption
    have hle := Finset.sum_le_sum_of_subset (f := fun i : Nat => i) hsub
    rw [Finset.sum_pair hq1, hp5] at hle
    have hx16 : x < 17 := by nlinarith
    exact hdec x hx16 hx

/-- Lemma 2: if σ(n) is odd then n is a square or twice a square.
Proof: n = 2^k m with m odd; if m is not a square, pair each odd divisor d with m / d;
this involution has no fixed point, so σ(n) is even (sum in `ZMod 2`). -/
theorem sq_or_two_sq_of_odd_sigma (n : Nat) (hn : n ≠ 0) (h : Odd (sigma 1 n)) :
    ∃ m, n = m ^ 2 ∨ n = 2 * m ^ 2 := by
  obtain ⟨k, m, hm, rfl⟩ := Nat.exists_eq_two_pow_mul_odd hn
  have hsq : ∃ j, m = j * j := by
    by_contra hns
    push Not at hns
    apply Nat.not_even_iff_odd.mpr h
    rw [← ZMod.natCast_eq_zero_iff_even, sigma_one_apply, Nat.cast_sum]
    -- odd divisors of 2^k * m divide m
    have hodd_dvd : ∀ d, d ∣ 2 ^ k * m → d % 2 = 1 → d ∣ m := by
      intro d hd hd2
      have hco : d.Coprime (2 ^ k) :=
        Nat.Coprime.pow_right k (Nat.coprime_two_right.mpr (Nat.odd_iff.mpr hd2))
      exact hco.dvd_of_dvd_mul_left hd
    refine Finset.sum_involution (fun d _ => if d % 2 = 1 then m / d else d) ?_ ?_ ?_ ?_
    · intro d hd
      have hd' := Nat.dvd_of_mem_divisors hd
      by_cases hd2 : d % 2 = 1
      · simp only [hd2, if_true]
        have hdm := hodd_dvd d hd' hd2
        have hmd : m = d * (m / d) := (Nat.mul_div_cancel' hdm).symm
        have hq : Odd (m / d) := by
          rw [hmd] at hm
          exact (Nat.odd_mul.mp hm).2
        rw [ZMod.natCast_eq_one_iff_odd.mpr (Nat.odd_iff.mpr hd2),
          ZMod.natCast_eq_one_iff_odd.mpr hq]
        decide
      · simp only [hd2, if_false]
        have : (d : ZMod 2) = 0 :=
          ZMod.natCast_eq_zero_iff_even.mpr (Nat.even_iff.mpr (by omega))
        rw [this, add_zero]
    · intro d hd hne
      have hd' := Nat.dvd_of_mem_divisors hd
      by_cases hd2 : d % 2 = 1
      · simp only [hd2, if_true]
        intro heq
        have hdm := hodd_dvd d hd' hd2
        have hmd : m = d * (m / d) := (Nat.mul_div_cancel' hdm).symm
        rw [heq] at hmd
        exact hns d hmd
      · exfalso
        exact hne (ZMod.natCast_eq_zero_iff_even.mpr (Nat.even_iff.mpr (by omega)))
    · intro d hd
      have hd' := Nat.dvd_of_mem_divisors hd
      by_cases hd2 : d % 2 = 1
      · simp only [hd2, if_true]
        have hdm := hodd_dvd d hd' hd2
        exact Nat.mem_divisors.mpr
          ⟨(Nat.div_dvd_of_dvd hdm).trans (Dvd.intro_left _ rfl), hn⟩
      · simpa [hd2] using hd
    · intro d hd
      have hd' := Nat.dvd_of_mem_divisors hd
      by_cases hd2 : d % 2 = 1
      · have hdm := hodd_dvd d hd' hd2
        have hmd : m = d * (m / d) := (Nat.mul_div_cancel' hdm).symm
        have hq : (m / d) % 2 = 1 := by
          have h' := hm
          rw [hmd] at h'
          exact Nat.odd_iff.mp (Nat.odd_mul.mp h').2
        have hm0 : m ≠ 0 := by rintro rfl; simp at hm
        simp only [hd2, if_true, hq]
        exact Nat.div_div_self hdm hm0
      · simp [hd2]
  obtain ⟨j, rfl⟩ := hsq
  rcases Nat.even_or_odd k with ⟨i, rfl⟩ | ⟨i, rfl⟩
  · exact ⟨2 ^ i * j, Or.inl (by ring)⟩
  · exact ⟨2 ^ i * j, Or.inr (by ring)⟩

/-- Reduction: every solution of σ(x) mod x = 5 is a square, twice a square,
or odd with σ(x) ≥ 3x + 5. Write σ(x) = kx + 5. If σ(x) is odd use Lemma 2.
If σ(x) is even then kx is odd, so x and k are odd; k ≠ 1 by Lemma 1, so k ≥ 3. -/
theorem reduction (x : Nat) (hx : 0 < x) (h : sigma 1 x % x = 5) :
    (∃ m, x = m ^ 2 ∨ x = 2 * m ^ 2) ∨ (Odd x ∧ 3 * x + 5 ≤ sigma 1 x) := by
  have hdiv := Nat.div_add_mod (sigma 1 x) x
  rw [h] at hdiv
  rcases Nat.even_or_odd (sigma 1 x) with hs | hs
  · right
    have hodd : Odd (x * (sigma 1 x / x)) := by
      rw [← hdiv] at hs
      rcases hs with ⟨r, hr⟩
      exact ⟨r - 3, by omega⟩
    rcases Nat.odd_mul.mp hodd with ⟨hxo, hko⟩
    refine ⟨hxo, ?_⟩
    have hk1 : sigma 1 x / x ≠ 1 := by
      intro hk
      rw [hk, mul_one] at hdiv
      exact sigma_ne_add_five x hdiv.symm
    have hk3 : 3 ≤ sigma 1 x / x := by
      rcases hko with ⟨r, hr⟩
      omega
    calc 3 * x + 5 ≤ x * (sigma 1 x / x) + 5 := by nlinarith
      _ = sigma 1 x := hdiv
  · left
    exact sq_or_two_sq_of_odd_sigma x hx.ne' hs

/-- Consequence for the OEIS sequence: `a 5` is `0`, a square, twice a square,
or an odd number `x` with `σ(x) ≥ 3x + 5`. -/
theorem a5_zero_or_special :
    OeisA76495.a 5 = 0 ∨ (∃ m, OeisA76495.a 5 = m ^ 2 ∨ OeisA76495.a 5 = 2 * m ^ 2) ∨
      (Odd (OeisA76495.a 5) ∧ 3 * OeisA76495.a 5 + 5 ≤ sigma 1 (OeisA76495.a 5)) := by
  classical
  unfold OeisA76495.a
  split_ifs with h
  · right
    obtain ⟨hpos, hmod⟩ := Nat.find_spec h
    exact reduction _ hpos hmod
  · left; rfl

/-- Finite check: no x < 300 has σ(x) mod x = 5. -/
theorem small_check : ∀ x, x < 300 → sigma 1 x % x ≠ 5 := by decide +kernel

end A076495Sweep

