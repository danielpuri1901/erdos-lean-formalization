import FormalConjectures.Wikipedia.AgohGiuga
import Solution.GiugaIff

/-! Solution for the giuga9 target. See `TASK.md` and `NOTES.md`. -/

namespace Giuga9

open Finset

/-- A strong Giuga number is odd: `2` is not a prime factor. -/
lemma two_not_mem {a : Nat} (ha : a.Composite)
    (h : ∀ p ∈ a.primeFactors, (p - 1 ∣ a - 1 ∧ p ∣ a / p - 1)) : 2 ∉ a.primeFactors := by
  intro h2
  have ha2 : 2 ≤ a := ha.1
  have hodd : 2 ∣ a / 2 - 1 := (h 2 h2).2
  obtain ⟨m, hm⟩ := Nat.dvd_of_mem_primeFactors h2
  have hm' : a / 2 = m := by omega
  rw [hm'] at hodd
  have hm1 : m ≠ 1 := by
    rintro rfl
    exact ha.2 (by rw [hm]; norm_num)
  have hm3 : 3 ≤ m := by omega
  have hq : m.minFac.Prime := Nat.minFac_prime (by omega)
  have hqm : m.minFac ∣ m := Nat.minFac_dvd m
  have hq2 : m.minFac ≠ 2 := by
    intro e
    rw [e] at hqm
    omega
  have hqa : m.minFac ∈ a.primeFactors :=
    Nat.mem_primeFactors.mpr ⟨hq, hm ▸ Dvd.dvd.mul_left hqm 2, by omega⟩
  have hq_odd : 2 ∣ m.minFac - 1 := by
    rcases hq.eq_two_or_odd with e | e
    · exact absurd e hq2
    · omega
  have := hq_odd.trans (h _ hqa).1
  omega

/-- The reciprocal sum of the prime factors of a strong Giuga number is at least `1`. -/
lemma one_le_sum {a : Nat} (ha : a.Composite)
    (h : ∀ p ∈ a.primeFactors, (p - 1 ∣ a - 1 ∧ p ∣ a / p - 1)) :
    1 ≤ ∑ p ∈ a.primeFactors, (1 / p : ℚ) := by
  have ha2 : 2 ≤ a := ha.1
  obtain ⟨n, hn⟩ := (GiugaSol.local_iff_sum ha2).mp fun p hp => (h p hp).2
  have hpr : a.minFac.Prime := Nat.minFac_prime (by omega)
  have hp : a.minFac ∈ a.primeFactors :=
    Nat.mem_primeFactors.mpr ⟨hpr, Nat.minFac_dvd a, by omega⟩
  have hlt : a.minFac < a := by
    rcases (Nat.minFac_le (by omega : 0 < a)).lt_or_eq with h' | h'
    · exact h'
    · exact absurd (h' ▸ hpr) ha.2
  have hpos : (0 : ℚ) < a.minFac := by exact_mod_cast hpr.pos
  have h1 : (1 / a.minFac : ℚ) ≤ ∑ p ∈ a.primeFactors, (1 / p : ℚ) :=
    Finset.single_le_sum (f := fun p : Nat => (1 / p : ℚ)) (fun _ _ => by positivity) hp
  have h2 : (1 / a : ℚ) < 1 / a.minFac := by
    apply one_div_lt_one_div_of_lt hpos
    exact_mod_cast hlt
  have ha0 : (0 : ℚ) < 1 / a := by
    have : (0 : ℚ) < a := by exact_mod_cast (show 0 < a by omega)
    positivity
  have hn0 : (0 : ℚ) < n := by rw [← hn]; linarith
  have hn1 : (1 : ℚ) ≤ n := by
    have : 0 < n := by exact_mod_cast hn0
    exact_mod_cast this
  linarith

/-- At most `8` odd primes have reciprocal sum below `1`. -/
lemma sum_lt_one (S : Finset Nat) (hS : ∀ p ∈ S, p.Prime ∧ p ≠ 2) (hcard : S.card ≤ 8) :
    ∑ p ∈ S, (1 / p : ℚ) < 1 := by
  classical
  set T : Finset Nat := {3, 5, 7, 11, 13, 17, 19, 23} with hT
  set f : Nat → ℚ := fun p => 1 / p - 1 / 29 with hf
  have hge : ∀ p ∈ S, p ∉ T → 29 ≤ p := by
    intro p hp hpT
    obtain ⟨hpr, hp2⟩ := hS p hp
    by_contra hlt
    have hlt' : p < 29 := by omega
    clear hS hcard hp
    interval_cases p <;> first
      | exact hp2 rfl
      | (norm_num at hpr; done)
      | simp [hT] at hpT
  have hsplit : ∑ p ∈ S, (1 / p : ℚ) = ∑ p ∈ S, f p + S.card * (1 / 29) := by
    simp only [hf, Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul]
    ring
  have hf1 : ∑ p ∈ S, f p ≤ ∑ p ∈ S.filter (· ∈ T), f p := by
    rw [← Finset.sum_filter_add_sum_filter_not S (· ∈ T)]
    have : ∑ p ∈ S.filter (fun p => ¬ p ∈ T), f p ≤ 0 := by
      apply Finset.sum_nonpos
      intro p hp
      rw [Finset.mem_filter] at hp
      have h29 : (29 : ℚ) ≤ p := by exact_mod_cast hge p hp.1 hp.2
      simp only [hf, sub_nonpos]
      exact one_div_le_one_div_of_le (by norm_num) h29
    linarith
  have hf2 : ∑ p ∈ S.filter (· ∈ T), f p ≤ ∑ p ∈ T, f p := by
    apply Finset.sum_le_sum_of_subset_of_nonneg
    · intro p hp
      exact (Finset.mem_filter.mp hp).2
    · intro p hp _
      simp only [hT, Finset.mem_insert, Finset.mem_singleton] at hp
      rcases hp with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> norm_num [hf]
  have hTsum : ∑ p ∈ T, f p + 8 * (1 / 29) < 1 := by
    simp only [hT, hf]
    norm_num
  have hc : (S.card : ℚ) ≤ 8 := by exact_mod_cast hcard
  nlinarith

end Giuga9

theorem strong_giuga_nine_primes : type_of% @AgohGiuga.agoh_giuga.variants.le_primeFactors_card_of_isStrongGiuga := by
  intro a ha
  have hc : a.Composite := ha.1
  have h := (GiugaSol.strong_iff_local hc).mp ha
  by_contra hlt
  have h8 : a.primeFactors.card ≤ 8 := by omega
  have h1 := Giuga9.one_le_sum hc h
  have h2 := Giuga9.sum_lt_one a.primeFactors
    (fun p hp => ⟨Nat.prime_of_mem_primeFactors hp, fun e => Giuga9.two_not_mem hc h (e ▸ hp)⟩) h8
  linarith
