import FormalConjectures.Wikipedia.AgohGiuga
import Solution.GiugaIff

/-! Solution for the giuga9 target. See `TASK.md` and `NOTES.md`. -/

namespace Giuga9

open Finset

/-- A strong Giuga number is odd: `2` is not a prime factor. -/
lemma two_not_mem {a : Nat} (ha : a.Composite)
    (h : ∀ p ∈ a.primeFactors, (p - 1 ∣ a - 1 ∧ p ∣ a / p - 1)) : 2 ∉ a.primeFactors := by
  sorry

/-- The reciprocal sum of the prime factors of a strong Giuga number is at least `1`. -/
lemma one_le_sum {a : Nat} (ha : a.Composite)
    (h : ∀ p ∈ a.primeFactors, (p - 1 ∣ a - 1 ∧ p ∣ a / p - 1)) :
    1 ≤ ∑ p ∈ a.primeFactors, (1 / p : ℚ) := by
  sorry

/-- At most `8` odd primes have reciprocal sum below `1`. -/
lemma sum_lt_one (S : Finset Nat) (hS : ∀ p ∈ S, p.Prime ∧ p ≠ 2) (hcard : S.card ≤ 8) :
    ∑ p ∈ S, (1 / p : ℚ) < 1 := by
  sorry

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
