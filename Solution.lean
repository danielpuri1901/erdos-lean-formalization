import FormalConjectures.Wikipedia.AgohGiuga

/-! Solution for the weakgiuga target. See `TASK.md` and `NOTES.md`. -/

namespace WeakGiugaSol

open Finset
open scoped Nat

/-- Sum over `range p` equals sum over `ZMod p`. -/
lemma sum_range_eq_sum_zmod (p : Nat) [NeZero p] (f : ZMod p → ZMod p) :
    ∑ i ∈ range p, f (i : ZMod p) = ∑ x : ZMod p, f x := by
  sorry

/-- Power sums over `ZMod p`. -/
lemma sum_pow_zmod (p : Nat) [hp : Fact p.Prime] (k : Nat) (hk : k ≠ 0) :
    ∑ x : ZMod p, x ^ k = if p - 1 ∣ k then -1 else 0 := by
  sorry

/-- Periodicity of the power sum modulo `p`. -/
lemma sum_range_mul (p : Nat) [NeZero p] (k m : Nat) :
    ∑ i ∈ range (p * m), (i : ZMod p) ^ k = m * ∑ x : ZMod p, x ^ k := by
  sorry

/-- The weak Giuga sum modulo a prime factor. -/
lemma cast_weak_sum (p n : Nat) [hp : Fact p.Prime] (hpn : p ∣ n) (hn : 2 ≤ n) :
    (((1 + ∑ i ∈ Ioo 0 n, i ^ φ n : Nat)) : ZMod p) = 1 - ((n / p : Nat) : ZMod p) := by
  sorry

/-- The local condition at a prime factor. -/
lemma dvd_weak_iff (p n : Nat) (hp : p.Prime) (hpn : p ∣ n) (hn : 2 ≤ n) :
    p ∣ 1 + ∑ i ∈ Ioo 0 n, i ^ φ n ↔ p ∣ n / p - 1 := by
  sorry

/-- `p ∣ a / p - 1` at every prime factor forces `a` squarefree. -/
lemma squarefree_of_local {a : Nat} (ha : a ≠ 0) (h : ∀ p ∈ a.primeFactors, p ∣ a / p - 1) :
    Squarefree a := by
  sorry

/-- A squarefree number divides every multiple of all its prime factors. -/
lemma dvd_of_squarefree {a N : Nat} (ha : Squarefree a) (h : ∀ p ∈ a.primeFactors, p ∣ N) :
    a ∣ N := by
  sorry

/-- Weak Giuga in terms of local conditions. -/
lemma weak_iff_local {n : Nat} (hn : n.Composite) :
    AgohGiuga.IsWeakGiuga n ↔ ∀ p ∈ n.primeFactors, p ∣ n / p - 1 := by
  sorry

/-- The sum condition in terms of local conditions. -/
lemma local_iff_sum {a : Nat} (ha : 2 ≤ a) :
    (∀ p ∈ a.primeFactors, p ∣ a / p - 1) ↔
      ∃ n : Nat, ∑ p ∈ a.primeFactors, (1 / p : ℚ) - 1 / a = n := by
  sorry

end WeakGiugaSol

theorem weak_giuga_iff_sum : type_of% @AgohGiuga.isWeakGiuga_iff_sum_primeFactors := by
  intro n hn
  rw [WeakGiugaSol.weak_iff_local hn, WeakGiugaSol.local_iff_sum hn.1]
