import FormalConjectures.Wikipedia.AgohGiuga

/-! Solution for the weakgiuga target. See `TASK.md` and `NOTES.md`. -/

namespace WeakGiugaSol

open Finset
open scoped Nat

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
  let ι : (ZMod p)ˣ ↪ ZMod p := ⟨fun x ↦ x, Units.val_injective⟩
  have hι : univ.map ι = univ \ {0} := by
    ext x
    simpa only [mem_map, mem_univ, Function.Embedding.coeFn_mk, true_and, mem_sdiff,
      mem_singleton, ι] using! isUnit_iff_ne_zero
  calc
    ∑ x : ZMod p, x ^ k = ∑ x ∈ univ \ {(0 : ZMod p)}, x ^ k := by
      rw [← sum_sdiff ({0} : Finset (ZMod p)).subset_univ, sum_singleton, zero_pow hk, add_zero]
    _ = ∑ x : (ZMod p)ˣ, ((x : ZMod p) ^ k) := by simp [ι, ← hι, univ.sum_map ι]

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

/-- The weak Giuga sum modulo a prime factor. -/
lemma cast_weak_sum (p n : Nat) [hp : Fact p.Prime] (hpn : p ∣ n) (hn : 2 ≤ n) :
    (((1 + ∑ i ∈ Ioo 0 n, i ^ φ n : Nat)) : ZMod p) = 1 - ((n / p : Nat) : ZMod p) := by
  have hk : φ n ≠ 0 := (Nat.totient_pos.mpr (by omega)).ne'
  have hdvd : p - 1 ∣ φ n := by
    rw [← Nat.totient_prime hp.out]; exact Nat.totient_dvd_of_dvd hpn
  push_cast
  have hIoo : ∑ i ∈ Ioo 0 n, (i : ZMod p) ^ φ n = ∑ i ∈ range n, (i : ZMod p) ^ φ n := by
    rw [Finset.range_eq_Ico, Finset.sum_eq_sum_Ico_succ_bot (by omega)]
    simp [zero_pow hk]
    rfl
  rw [hIoo]
  obtain ⟨m, rfl⟩ := hpn
  rw [sum_range_mul, sum_pow_zmod p _ hk, if_pos hdvd, Nat.mul_div_cancel_left _ hp.out.pos]
  ring

/-- The local condition at a prime factor. -/
lemma dvd_weak_iff (p n : Nat) (hp : p.Prime) (hpn : p ∣ n) (hn : 2 ≤ n) :
    p ∣ 1 + ∑ i ∈ Ioo 0 n, i ^ φ n ↔ p ∣ n / p - 1 := by
  have : Fact p.Prime := ⟨hp⟩
  have hm : 1 ≤ n / p := Nat.div_pos (Nat.le_of_dvd (by omega) hpn) hp.pos
  rw [← ZMod.natCast_eq_zero_iff (1 + ∑ i ∈ Ioo 0 n, i ^ φ n) p, cast_weak_sum p n hpn hn,
    ← ZMod.natCast_eq_zero_iff (n / p - 1) p, Nat.cast_sub hm, Nat.cast_one]
  constructor <;> intro h <;> linear_combination -h

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

/-- Weak Giuga in terms of local conditions. -/
lemma weak_iff_local {n : Nat} (hn : n.Composite) :
    AgohGiuga.IsWeakGiuga n ↔ ∀ p ∈ n.primeFactors, p ∣ n / p - 1 := by
  have hn2 : 2 ≤ n := hn.1
  constructor
  · rintro ⟨-, h⟩ p hp
    have hpn := Nat.dvd_of_mem_primeFactors hp
    exact (dvd_weak_iff p n (Nat.prime_of_mem_primeFactors hp) hpn hn2).mp (hpn.trans h)
  · intro h
    refine ⟨hn, dvd_of_squarefree (squarefree_of_local (by omega) h) ?_⟩
    intro p hp
    exact (dvd_weak_iff p n (Nat.prime_of_mem_primeFactors hp) (Nat.dvd_of_mem_primeFactors hp)
      hn2).mpr (h p hp)

/-- A prime factor `q` divides `a / p` for every other prime factor `p`. -/
lemma dvd_div_of_ne {a p q : Nat} (hp : p ∈ a.primeFactors) (hq : q ∈ a.primeFactors)
    (hne : p ≠ q) : q ∣ a / p := by
  have hp' := Nat.prime_of_mem_primeFactors hp
  have hq' := Nat.prime_of_mem_primeFactors hq
  have hqa := Nat.dvd_of_mem_primeFactors hq
  rw [← Nat.mul_div_cancel' (Nat.dvd_of_mem_primeFactors hp)] at hqa
  refine ((Nat.Prime.dvd_mul hq').mp hqa).resolve_left ?_
  intro h
  exact hne ((Nat.prime_dvd_prime_iff_eq hq' hp').mp h).symm

/-- The local condition `q ∣ a / q - 1` in terms of `N = ∑ a / p - 1`. -/
lemma dvd_N_iff {a q : Nat} (hq : q ∈ a.primeFactors) :
    q ∣ (∑ p ∈ a.primeFactors, a / p) - 1 ↔ q ∣ a / q - 1 := by
  have hq1 : 1 ≤ a / q := by
    have := Nat.dvd_of_mem_primeFactors hq
    exact Nat.div_pos (Nat.le_of_dvd (Nat.pos_of_ne_zero (Nat.mem_primeFactors.mp hq).2.2) this)
      (Nat.prime_of_mem_primeFactors hq).pos
  rw [← Finset.add_sum_erase _ _ hq]
  have hR : q ∣ ∑ p ∈ a.primeFactors.erase q, a / p :=
    Finset.dvd_sum fun p hp => dvd_div_of_ne (Finset.mem_of_mem_erase hp) hq (Finset.ne_of_mem_erase hp)
  rw [show a / q + ∑ p ∈ a.primeFactors.erase q, a / p - 1 =
    (a / q - 1) + ∑ p ∈ a.primeFactors.erase q, a / p by omega]
  exact (Nat.dvd_add_left hR)

/-- The sum condition in terms of local conditions. -/
lemma local_iff_sum {a : Nat} (ha : 2 ≤ a) :
    (∀ p ∈ a.primeFactors, p ∣ a / p - 1) ↔
      ∃ n : Nat, ∑ p ∈ a.primeFactors, (1 / p : ℚ) - 1 / a = n := by
  set N := (∑ p ∈ a.primeFactors, a / p) - 1 with hN
  have hne : a.primeFactors.Nonempty := Nat.nonempty_primeFactors.mpr (by omega)
  have hS : 1 ≤ ∑ p ∈ a.primeFactors, a / p := by
    obtain ⟨q, hq⟩ := hne
    have hq1 : 1 ≤ a / q :=
      Nat.div_pos (Nat.le_of_dvd (by omega) (Nat.dvd_of_mem_primeFactors hq))
        (Nat.prime_of_mem_primeFactors hq).pos
    exact hq1.trans (Finset.single_le_sum (f := fun p => a / p) (fun _ _ => Nat.zero_le _) hq)
  have hQ : ∑ p ∈ a.primeFactors, (1 / p : ℚ) - 1 / a = (N : ℚ) / a := by
    rw [hN, Nat.cast_sub hS, Nat.cast_sum, sub_div, Finset.sum_div, Nat.cast_one]
    congr 1
    refine Finset.sum_congr rfl fun p hp => ?_
    have hp0 : (p : ℚ) ≠ 0 := by exact_mod_cast (Nat.prime_of_mem_primeFactors hp).ne_zero
    have ha0 : (a : ℚ) ≠ 0 := by exact_mod_cast (show a ≠ 0 by omega)
    rw [Nat.cast_div (Nat.dvd_of_mem_primeFactors hp) hp0]
    field_simp
  rw [hQ]
  have ha0 : (a : ℚ) ≠ 0 := by exact_mod_cast (show a ≠ 0 by omega)
  constructor
  · intro h
    have hsq := squarefree_of_local (by omega) h
    obtain ⟨n, hn⟩ := dvd_of_squarefree hsq fun q hq => (dvd_N_iff hq).mpr (h q hq)
    refine ⟨n, ?_⟩
    have hn' : N = a * n := hn
    rw [hn']; push_cast; field_simp
  · rintro ⟨n, hn⟩ q hq
    rw [div_eq_iff ha0] at hn
    have hn' : N = n * a := by exact_mod_cast hn
    refine (dvd_N_iff hq).mp ?_
    rw [← hN, hn']
    exact dvd_mul_of_dvd_right (Nat.dvd_of_mem_primeFactors hq) _

end WeakGiugaSol

theorem weak_giuga_iff_sum : type_of% @AgohGiuga.isWeakGiuga_iff_sum_primeFactors := by
  intro n hn
  rw [WeakGiugaSol.weak_iff_local hn, WeakGiugaSol.local_iff_sum hn.1]
