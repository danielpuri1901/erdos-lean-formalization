import FormalConjectures.Wikipedia.AgohGiuga

/-! Solution for the giugacarmichael target. See `TASK.md` and `NOTES.md`. -/

namespace GiugaSol

open Finset

/-- Sum over `range p` equals sum over `ZMod p`. -/
lemma sum_range_eq_sum_zmod (p : Nat) [NeZero p] (f : ZMod p → ZMod p) :
    ∑ i ∈ range p, f (i : ZMod p) = ∑ x : ZMod p, f x := by
  refine Finset.sum_bij' (fun i _ => (i : ZMod p)) (fun x _ => x.val) ?_ ?_ ?_ ?_ ?_
  · intros; exact mem_univ _
  · intro x _; exact mem_range.mpr (ZMod.val_lt x)
  · intro i hi; exact ZMod.val_cast_of_lt (mem_range.mp hi)
  · intro x _; exact ZMod.natCast_zmod_val x
  · intros; rfl

/-- Power sums over `ZMod p`. -/
lemma sum_pow_zmod (p : Nat) [hp : Fact p.Prime] (k : Nat) (hk : k ≠ 0) :
    ∑ x : ZMod p, x ^ k = if p - 1 ∣ k then -1 else 0 := by
  classical
  have h := FiniteField.sum_pow_units (ZMod p) k
  rw [ZMod.card] at h
  rw [← h]
  let φ : (ZMod p)ˣ ↪ ZMod p := ⟨fun x ↦ x, Units.val_injective⟩
  have hφ : univ.map φ = univ \ {0} := by
    ext x
    simpa only [mem_map, mem_univ, Function.Embedding.coeFn_mk, true_and, mem_sdiff,
      mem_singleton, φ] using! isUnit_iff_ne_zero
  calc
    ∑ x : ZMod p, x ^ k = ∑ x ∈ univ \ {(0 : ZMod p)}, x ^ k := by
      rw [← sum_sdiff ({0} : Finset (ZMod p)).subset_univ, sum_singleton, zero_pow hk, add_zero]
    _ = ∑ x : (ZMod p)ˣ, ((x : ZMod p) ^ k) := by simp [φ, ← hφ, univ.sum_map φ]

/-- Periodicity of the power sum modulo `p`. -/
lemma sum_range_mul (p : Nat) [NeZero p] (k m : Nat) :
    ∑ i ∈ range (p * m), (i : ZMod p) ^ k = m * ∑ x : ZMod p, x ^ k := by
  induction m with
  | zero => simp
  | succ m ih =>
    rw [mul_add, mul_one, Finset.sum_range_add, ih, ← sum_range_eq_sum_zmod p (fun x => x ^ k)]
    push_cast
    simp only [ZMod.natCast_self, zero_mul, zero_add]
    ring

/-- The Giuga sum modulo a prime factor. -/
lemma cast_giuga_sum (p a : Nat) [hp : Fact p.Prime] (hpa : p ∣ a) (ha : 2 ≤ a) :
    (((1 + ∑ i ∈ Ioo 0 a, i ^ (a - 1) : Nat)) : ZMod p) =
      1 + ((a / p : Nat) : ZMod p) * (if p - 1 ∣ a - 1 then -1 else 0) := by
  push_cast
  have hIoo : ∑ i ∈ Ioo 0 a, (i : ZMod p) ^ (a - 1) = ∑ i ∈ range a, (i : ZMod p) ^ (a - 1) := by
    rw [Finset.range_eq_Ico, Finset.sum_eq_sum_Ico_succ_bot (by omega)]
    simp [zero_pow (show a - 1 ≠ 0 by omega)]
    rfl
  rw [hIoo, ← sum_pow_zmod p (a - 1) (by omega)]
  obtain ⟨m, rfl⟩ := hpa
  rw [sum_range_mul, Nat.mul_div_cancel_left _ hp.out.pos]

/-- The local condition at a prime factor. -/
lemma dvd_giuga_iff (p a : Nat) (hp : p.Prime) (hpa : p ∣ a) (ha : 2 ≤ a) :
    p ∣ 1 + ∑ i ∈ Ioo 0 a, i ^ (a - 1) ↔ (p - 1 ∣ a - 1 ∧ p ∣ a / p - 1) := by
  have : Fact p.Prime := ⟨hp⟩
  have hm : 1 ≤ a / p := by
    obtain ⟨m, rfl⟩ := hpa
    rw [Nat.mul_div_cancel_left _ hp.pos]
    rcases m with _ | m
    · omega
    · omega
  rw [← ZMod.natCast_eq_zero_iff, cast_giuga_sum p a hpa ha,
    ← ZMod.natCast_eq_zero_iff (a / p - 1) p, Nat.cast_sub hm]
  split_ifs with h
  · simp only [h, true_and, Nat.cast_one]
    constructor <;> intro h' <;> linear_combination -h'
  · simp [h]

/-- `p ∣ a / p - 1` at every prime factor forces `a` squarefree. -/
lemma squarefree_of_local {a : Nat} (ha : a ≠ 0) (h : ∀ p ∈ a.primeFactors, p ∣ a / p - 1) :
    Squarefree a := by
  rw [Nat.squarefree_iff_prime_squarefree]
  intro p hp hpp
  have hpa : p ∣ a := dvd_of_mul_left_dvd hpp
  have h1 := h p (Nat.mem_primeFactors.mpr ⟨hp, hpa, ha⟩)
  obtain ⟨c, hc⟩ := hpp
  have h2 : p ∣ a / p := by
    rw [hc, mul_assoc, Nat.mul_div_cancel_left _ hp.pos]; exact dvd_mul_right _ _
  have h3 : 1 ≤ a / p := by
    rw [hc, mul_assoc, Nat.mul_div_cancel_left _ hp.pos]
    rcases c with _ | c
    · simp at hc; exact absurd hc ha
    · exact Nat.one_le_iff_ne_zero.mpr (Nat.mul_ne_zero hp.ne_zero (Nat.succ_ne_zero _))
  have h4 : p ∣ a / p - (a / p - 1) := Nat.dvd_sub h2 h1
  rw [Nat.sub_sub_self h3] at h4
  exact hp.one_lt.ne' (Nat.dvd_one.mp h4)

/-- A squarefree number divides every multiple of all its prime factors. -/
lemma dvd_of_squarefree {a N : Nat} (ha : Squarefree a) (h : ∀ p ∈ a.primeFactors, p ∣ N) :
    a ∣ N := by
  rw [← Nat.prod_primeFactors_of_squarefree ha]
  exact Finset.prod_primes_dvd N (fun p hp => (Nat.prime_of_mem_primeFactors hp).prime) h

/-- Strong Giuga in terms of local conditions. -/
lemma strong_iff_local {a : Nat} (ha : a.Composite) :
    AgohGiuga.IsStrongGiuga a ↔ ∀ p ∈ a.primeFactors, (p - 1 ∣ a - 1 ∧ p ∣ a / p - 1) := by
  have ha2 : 2 ≤ a := ha.1
  constructor
  · rintro ⟨-, h⟩ p hp
    have hpa := Nat.dvd_of_mem_primeFactors hp
    exact (dvd_giuga_iff p a (Nat.prime_of_mem_primeFactors hp) hpa ha2).mp (hpa.trans h)
  · intro h
    refine ⟨ha, dvd_of_squarefree (squarefree_of_local (by omega) fun p hp => (h p hp).2) ?_⟩
    intro p hp
    exact (dvd_giuga_iff p a (Nat.prime_of_mem_primeFactors hp) (Nat.dvd_of_mem_primeFactors hp)
      ha2).mpr (h p hp)

end GiugaSol

theorem strong_giuga_is_carmichael : type_of% @AgohGiuga.agoh_giuga.variants.isStrongGiuga_implies_isCarmichael := by
  intro a ha
  have hc : a.Composite := ha.1
  have h := (GiugaSol.strong_iff_local hc).mp ha
  rw [AgohGiuga.korselts_criterion a hc]
  refine ⟨GiugaSol.squarefree_of_local (by have := hc.1; omega) fun p hp => (h p hp).2, ?_⟩
  intro p hp hpa
  exact (h p (Nat.mem_primeFactors.mpr ⟨hp, hpa, by have := hc.1; omega⟩)).1
