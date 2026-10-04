import FormalConjectures.Arxiv.«2607.08366».MinModulus

/-!
# Sweep work for `minmodulus`

A proved weaker lower bound: no `n`-subset of `ZMod N` is valid when `N < 2 ^ (n - 1)`.

Paper proof (see `sweep/minmodulus/NOTES.md`):
fix `a₀ ∈ A` and put `A' = A.erase a₀`. The `2 ^ (n - 1)` subsets `S ⊆ A'` are mapped to
`f S = ∑ a ∈ S, (a - a₀)` in `ZMod N`, which has `N < 2 ^ (n - 1)` elements, so two distinct
subsets `S ≠ T` have `f S = f T`. Say `#(T \ S) ≤ #(S \ T)`, and put `D = S \ T`, `P = T \ S`,
`j = #D - #P`. Then `∑ D = ∑ P + j • a₀`, and the multiset that drops `D`, doubles `P` and adds
`j` extra copies of `a₀` has size `#A` and sum `∑ A`, but it is not all ones.
-/

open Finset

namespace MinModulusSweep

open Arxiv.«2607.08366»

variable {N : ℕ}

/-- Key step: a set `D` of elements (not containing `a₀`) whose sum equals the sum of a set `P`
disjoint from it plus `#D - #P` copies of `a₀` witnesses invalidity. -/
theorem not_isValidMod_of_witness (A : Finset (ZMod N)) (a₀ : ZMod N) (ha₀ : a₀ ∈ A)
    (D P : Finset (ZMod N)) (hD : D ⊆ A.erase a₀) (hP : P ⊆ A.erase a₀)
    (hdisj : Disjoint D P) (hne : D.Nonempty) (hcard : #P ≤ #D)
    (hsum : ∑ a ∈ D, a = ∑ a ∈ P, a + ((#D - #P : ℕ) : ZMod N) * a₀) :
    ¬ IsValidMod A := by
  classical
  intro hv
  set j := #D - #P with hj
  -- the multiset: drop `D`, double `P`, add `j` copies of `a₀`
  let g : ZMod N → ℕ := fun a => if a ∈ P then 2 else if a ∈ D then 0 else 1
  let m : ZMod N → ℕ := fun a => g a + if a = a₀ then j else 0
  have hDA : D ⊆ A := hD.trans (erase_subset _ _)
  have hPA : P ⊆ A := hP.trans (erase_subset _ _)
  -- pointwise: g a + [a ∈ D] = 1 + [a ∈ P]
  have hg : ∀ a, g a + (if a ∈ D then 1 else 0) = 1 + (if a ∈ P then 1 else 0) := by
    intro a
    by_cases haP : a ∈ P
    · have haD : a ∉ D := fun h => disjoint_left.mp hdisj h haP
      simp [g, haP, haD]
    · by_cases haD : a ∈ D <;> simp [g, haP, haD]
  have hgZ : ∀ a : ZMod N, (g a : ZMod N) * a + (if a ∈ D then a else 0)
      = a + (if a ∈ P then a else 0) := by
    intro a
    by_cases haP : a ∈ P
    · have haD : a ∉ D := fun h => disjoint_left.mp hdisj h haP
      simp [g, haP, haD]; ring
    · by_cases haD : a ∈ D <;> simp [g, haP, haD]
  -- size of the multiset
  have h1 : ∑ a ∈ A, m a = #A := by
    have hsplit : ∑ a ∈ A, m a = ∑ a ∈ A, g a + j := by
      simp only [m, sum_add_distrib, sum_ite_eq', ha₀, if_true]
    have hcount := congrArg (fun F : ZMod N → ℕ => ∑ a ∈ A, F a) (funext hg)
    simp only [sum_add_distrib, sum_boole, filter_mem_eq_inter, inter_eq_right.mpr hDA,
      inter_eq_right.mpr hPA, sum_const, smul_eq_mul, mul_one, Nat.cast_id] at hcount
    omega
  -- sum of the multiset
  have h2 : ∑ a ∈ A, (m a : ZMod N) * a = ∑ a ∈ A, a := by
    have hsplit : ∑ a ∈ A, (m a : ZMod N) * a = ∑ a ∈ A, (g a : ZMod N) * a + (j : ZMod N) * a₀ := by
      simp only [m, Nat.cast_add, add_mul, sum_add_distrib]
      congr 1
      rw [sum_eq_single_of_mem a₀ ha₀]
      · simp
      · intro b _ hb; simp [hb]
    have hcount := congrArg (fun F : ZMod N → ZMod N => ∑ a ∈ A, F a) (funext hgZ)
    simp only [sum_add_distrib, sum_ite_mem, inter_eq_right.mpr hDA,
      inter_eq_right.mpr hPA] at hcount
    rw [hsplit]
    linear_combination hcount - hsum
  obtain ⟨d, hd⟩ := hne
  have hdA : d ∈ A := hDA hd
  have hdne : d ≠ a₀ := (mem_erase.mp (hD hd)).1
  have hdP : d ∉ P := fun h => disjoint_left.mp hdisj hd h
  have := hv m h1 h2 d hdA
  simp [m, g, hd, hdP, hdne] at this

/-- Two distinct subsets of `A.erase a₀` with the same shifted sum witness invalidity. -/
theorem not_isValidMod_of_shifted_sum_eq (A : Finset (ZMod N)) (a₀ : ZMod N) (ha₀ : a₀ ∈ A)
    (S T : Finset (ZMod N)) (hS : S ⊆ A.erase a₀) (hT : T ⊆ A.erase a₀) (hST : S ≠ T)
    (heq : ∑ a ∈ S, (a - a₀) = ∑ a ∈ T, (a - a₀)) : ¬ IsValidMod A := by
  classical
  wlog hc : #(T \ S) ≤ #(S \ T) generalizing S T
  · exact this T S hT hS hST.symm heq.symm (by omega)
  have hdiff : ∑ a ∈ S \ T, (a - a₀) = ∑ a ∈ T \ S, (a - a₀) := sum_sdiff_eq_sum_sdiff_iff.mpr heq
  simp only [sum_sub_distrib, sum_const, nsmul_eq_mul] at hdiff
  refine not_isValidMod_of_witness A a₀ ha₀ (S \ T) (T \ S) (sdiff_subset.trans hS)
    (sdiff_subset.trans hT) disjoint_sdiff_sdiff ?_ hc ?_
  · rw [nonempty_iff_ne_empty]
    intro h
    have hTS : T \ S = ∅ := by
      rw [h, card_empty] at hc
      exact card_eq_zero.mp (by omega)
    exact hST (Subset.antisymm (sdiff_eq_empty_iff_subset.mp h) (sdiff_eq_empty_iff_subset.mp hTS))
  · rw [Nat.cast_sub hc]
    linear_combination hdiff

/-- **Weaker lower bound (proved).** For `1 ≤ n` and `0 < N < 2 ^ (n - 1)`, no `n`-element subset
of `ZMod N` is valid. The conjecture asks for `N < 2 ^ n - 2 ^ ⌊log₂ n⌋`. -/
theorem not_isValidMod_of_lt_two_pow_pred (n : ℕ) (hn : 1 ≤ n) (hN : 0 < N)
    (hlt : N < 2 ^ (n - 1)) (A : Finset (ZMod N)) (hA : #A = n) : ¬ IsValidMod A := by
  classical
  have : NeZero N := ⟨by omega⟩
  obtain ⟨a₀, ha₀⟩ : A.Nonempty := card_pos.mp (by omega)
  have hcardA' : #(A.erase a₀) = n - 1 := by rw [card_erase_of_mem ha₀, hA]
  have hc : #(univ : Finset (ZMod N)) < #(A.erase a₀).powerset := by
    rw [card_powerset, hcardA', card_univ, ZMod.card]
    exact hlt
  obtain ⟨S, hS, T, hT, hST, heq⟩ := exists_ne_map_eq_of_card_lt_of_maps_to hc
    (f := fun S : Finset (ZMod N) => ∑ a ∈ S, (a - a₀)) (fun _ _ => mem_coe.mpr (mem_univ _))
  exact not_isValidMod_of_shifted_sum_eq A a₀ ha₀ S T (mem_powerset.mp hS) (mem_powerset.mp hT)
    hST heq

/-- General witness: an integer vector `v` with `v ≥ -1` on `A`, `∑ v = 0`, `∑ v a • a = 0` and
`v ≠ 0` somewhere on `A` gives the multiset `m = 1 + v`, so `A` is not valid. -/
theorem not_isValidMod_of_int_vec (A : Finset (ZMod N)) (v : ZMod N → ℤ)
    (hge : ∀ a ∈ A, -1 ≤ v a) (hsum : ∑ a ∈ A, v a = 0)
    (hlin : ∑ a ∈ A, (v a : ZMod N) * a = 0) (hne : ∃ a ∈ A, v a ≠ 0) :
    ¬ IsValidMod A := by
  intro hv
  let m : ZMod N → ℕ := fun a => (1 + v a).toNat
  have hm : ∀ a ∈ A, ((m a : ℕ) : ℤ) = 1 + v a := fun a ha =>
    Int.toNat_of_nonneg (by linarith [hge a ha])
  have h1 : ∑ a ∈ A, m a = #A := by
    have : ((∑ a ∈ A, m a : ℕ) : ℤ) = #A := by
      push_cast
      rw [sum_congr rfl hm, sum_add_distrib, hsum]
      simp
    exact_mod_cast this
  have h2 : ∑ a ∈ A, (m a : ZMod N) * a = ∑ a ∈ A, a := by
    have hc : ∀ a ∈ A, (m a : ZMod N) = 1 + (v a : ZMod N) := by
      intro a ha
      have := congrArg (fun z : ℤ => (z : ZMod N)) (hm a ha)
      push_cast at this
      exact this
    rw [sum_congr rfl (fun a ha => by rw [hc a ha])]
    simp only [add_mul, one_mul, sum_add_distrib, hlin, add_zero]
  obtain ⟨a, ha, hva⟩ := hne
  have h := hm a ha
  rw [hv m h1 h2 a ha] at h
  omega

/-- A nonzero `z : ZMod N` with `2 * z = 0` is `N / 2`, i.e. `2 * z.val = N`. -/
theorem two_mul_val_eq_of_two_mul_eq_zero (hN : 0 < N) {z : ZMod N} (hz : 2 * z = 0)
    (hz0 : z ≠ 0) : 2 * z.val = N := by
  have : NeZero N := ⟨by omega⟩
  have hcast : ((2 * z.val : ℕ) : ZMod N) = 0 := by
    push_cast
    rw [ZMod.natCast_zmod_val]
    exact hz
  obtain ⟨k, hk⟩ := (ZMod.natCast_eq_zero_iff _ _).mp hcast
  have hlt := ZMod.val_lt z
  have hv0 : z.val ≠ 0 := fun h => hz0 ((ZMod.val_eq_zero z).mp h)
  rcases k with _ | _ | k
  · omega
  · omega
  · nlinarith

/-- `ZMod N` has at most one element of order two. -/
theorem eq_of_two_mul_eq_zero (hN : 0 < N) {x y : ZMod N} (hx : 2 * x = 0) (hy : 2 * y = 0)
    (hx0 : x ≠ 0) (hy0 : y ≠ 0) : x = y := by
  have : NeZero N := ⟨by omega⟩
  apply ZMod.val_injective
  have := two_mul_val_eq_of_two_mul_eq_zero hN hx hx0
  have := two_mul_val_eq_of_two_mul_eq_zero hN hy hy0
  omega

/-- For odd `N`, `2 * x = 0` forces `x = 0`. -/
theorem eq_zero_of_two_mul_eq_zero_of_odd (hN : 0 < N) (hodd : Odd N) {x : ZMod N}
    (hx : 2 * x = 0) : x = 0 := by
  by_contra hx0
  have := two_mul_val_eq_of_two_mul_eq_zero hN hx hx0
  obtain ⟨k, hk⟩ := hodd
  omega

/-- In a valid set, a nonzero `2 • (b - a₀)` is never a shifted subset sum of `A.erase a₀`. -/
theorem shifted_sum_ne_two_mul (A : Finset (ZMod N)) (hv : IsValidMod A) (a₀ : ZMod N)
    (ha₀ : a₀ ∈ A) (b : ZMod N) (hb : b ∈ A.erase a₀) (hb2 : 2 * (b - a₀) ≠ 0)
    (T : Finset (ZMod N)) (hTA' : T ⊆ A.erase a₀) : ∑ a ∈ T, (a - a₀) ≠ 2 * (b - a₀) := by
  classical
  intro hfT
  have hbA : b ∈ A := mem_of_mem_erase hb
  have hba₀ : b ≠ a₀ := (mem_erase.mp hb).1
  let f : Finset (ZMod N) → ZMod N := fun S => ∑ a ∈ S, (a - a₀)
  change f T = 2 * (b - a₀) at hfT
  by_cases hbT : b ∈ T
  · -- `{b}` and `T.erase b` collide
    have hsplit : f T = (b - a₀) + f (T.erase b) := (add_sum_erase T _ hbT).symm
    refine not_isValidMod_of_shifted_sum_eq A a₀ ha₀ {b} (T.erase b)
      (singleton_subset_iff.mpr hb) ((erase_subset _ _).trans hTA') ?_ ?_ hv
    · intro h
      have : b ∈ T.erase b := h ▸ mem_singleton_self b
      simp at this
    · simp only [sum_singleton]
      change b - a₀ = f (T.erase b)
      linear_combination hsplit - hfT
  · by_cases hT0 : T = ∅
    · subst hT0
      exact hb2 (by simpa [f] using hfT.symm)
    · -- drop `T`, add two copies of `b` and `#T - 2` copies of `a₀`
      have hTpos : 1 ≤ #T := card_pos.mpr (nonempty_iff_ne_empty.mpr hT0)
      have hTA : T ⊆ A := hTA'.trans (erase_subset _ _)
      have ha₀T : a₀ ∉ T := fun h => (mem_erase.mp (hTA' h)).1 rfl
      let v : ZMod N → ℤ := fun a => (if a ∈ T then -1 else 0) + (if a = b then 2 else 0) +
        (if a = a₀ then (#T : ℤ) - 2 else 0)
      refine not_isValidMod_of_int_vec A v ?_ ?_ ?_ ⟨b, hbA, ?_⟩ hv
      · intro a _
        by_cases haT : a ∈ T
        · have hab : a ≠ b := fun h => hbT (h ▸ haT)
          have haa : a ≠ a₀ := fun h => ha₀T (h ▸ haT)
          simp [v, haT, hab, haa]
        · by_cases hab : a = b
          · subst hab; simp [v, haT, hba₀]
          · by_cases haa : a = a₀
            · subst haa; simp [v, haT, hab]; omega
            · simp [v, haT, hab, haa]
      · simp only [v, sum_add_distrib, sum_ite_mem, inter_eq_right.mpr hTA, sum_const,
          sum_ite_eq', hbA, ha₀, if_true]
        ring
      · have hfT' : ∑ a ∈ T, a - (#T : ZMod N) * a₀ = 2 * (b - a₀) := by
          have := hfT
          simp only [f, sum_sub_distrib, sum_const, nsmul_eq_mul] at this
          exact this
        simp only [v, Int.cast_add, add_mul, sum_add_distrib]
        have e1 : ∑ a ∈ A, ((if a ∈ T then (-1 : ℤ) else 0 : ℤ) : ZMod N) * a
            = -∑ a ∈ T, a := by
          have hpt : ∀ a ∈ A, ((if a ∈ T then (-1 : ℤ) else 0 : ℤ) : ZMod N) * a
              = -(if a ∈ T then a else 0) := by
            intro a _
            split_ifs <;> simp
          rw [sum_congr rfl hpt, sum_neg_distrib, sum_ite_mem, inter_eq_right.mpr hTA]
        have e2 : ∑ a ∈ A, ((if a = b then (2 : ℤ) else 0 : ℤ) : ZMod N) * a = 2 * b := by
          rw [sum_eq_single_of_mem b hbA]
          · simp
          · intro c _ hc; simp [hc]
        have e3 : ∑ a ∈ A, ((if a = a₀ then (#T : ℤ) - 2 else 0 : ℤ) : ZMod N) * a
            = ((#T : ZMod N) - 2) * a₀ := by
          rw [sum_eq_single_of_mem a₀ ha₀]
          · simp
          · intro c _ hc; simp [hc]
        rw [e1, e2, e3]
        linear_combination -hfT'
      · simp [v, hbT, hba₀]

/-- **Slightly stronger lower bound (proved).** For `3 ≤ n` and `0 < N ≤ 2 ^ (n - 1)`, no
`n`-element subset of `ZMod N` is valid: besides the `2 ^ (n - 1)` distinct shifted subset sums,
the value `2 • (b - a₀)` is also forbidden for a suitable `b`. -/
theorem not_isValidMod_of_le_two_pow_pred (n : ℕ) (hn : 3 ≤ n) (hN : 0 < N)
    (hle : N ≤ 2 ^ (n - 1)) (A : Finset (ZMod N)) (hA : #A = n) : ¬ IsValidMod A := by
  classical
  intro hv
  have : NeZero N := ⟨by omega⟩
  obtain ⟨a₀, ha₀⟩ : A.Nonempty := card_pos.mp (by omega)
  set A' := A.erase a₀ with hA'
  have hcardA' : #A' = n - 1 := by rw [card_erase_of_mem ha₀, hA]
  -- an element `b` of `A'` with `2 * (b - a₀) ≠ 0`
  obtain ⟨b, hb, hb2⟩ : ∃ b ∈ A', 2 * (b - a₀) ≠ 0 := by
    obtain ⟨b, hb, c, hc, hbc⟩ := one_lt_card.mp (show 1 < #A' by omega)
    by_contra hcon
    push Not at hcon
    have hb0 : b - a₀ ≠ 0 := sub_ne_zero.mpr (mem_erase.mp hb).1
    have hc0 : c - a₀ ≠ 0 := sub_ne_zero.mpr (mem_erase.mp hc).1
    have := eq_of_two_mul_eq_zero hN (hcon b hb) (hcon c hc) hb0 hc0
    exact hbc (sub_left_injective this)
  have hbA : b ∈ A := mem_of_mem_erase hb
  have hba₀ : b ≠ a₀ := (mem_erase.mp hb).1
  let f : Finset (ZMod N) → ZMod N := fun S => ∑ a ∈ S, (a - a₀)
  -- `f` is injective on subsets of `A'`
  have hinj : Set.InjOn f (A'.powerset : Set (Finset (ZMod N))) := by
    intro S hS T hT hST
    by_contra hne
    exact not_isValidMod_of_shifted_sum_eq A a₀ ha₀ S T (mem_powerset.mp hS)
      (mem_powerset.mp hT) hne hST hv
  have hmiss : ∀ T ∈ A'.powerset, f T ≠ 2 * (b - a₀) := fun T hT =>
    shifted_sum_ne_two_mul A hv a₀ ha₀ b hb hb2 T (mem_powerset.mp hT)
  -- counting: `2 ^ (n - 1)` distinct values avoid one value of `ZMod N`
  have hsub : A'.powerset.image f ⊆ univ.erase (2 * (b - a₀)) := by
    intro x hx
    obtain ⟨T, hT, rfl⟩ := mem_image.mp hx
    exact mem_erase.mpr ⟨hmiss T hT, mem_univ _⟩
  have hcard := card_le_card hsub
  rw [card_image_of_injOn hinj, card_powerset, hcardA', card_erase_of_mem (mem_univ _),
    card_univ, ZMod.card] at hcard
  omega

/-- **Odd moduli (proved).** For odd `N`, a valid `n`-set needs `N ≥ 2 ^ (n - 1) + (n - 1)`:
the `n - 1` values `2 • (b - a₀)`, `b ∈ A.erase a₀`, are distinct, nonzero, and missed by the
`2 ^ (n - 1)` distinct shifted subset sums. -/
theorem two_pow_add_le_of_odd (n : ℕ) (hn : 1 ≤ n) (hN : 0 < N) (hodd : Odd N)
    (A : Finset (ZMod N)) (hA : #A = n) (hv : IsValidMod A) : 2 ^ (n - 1) + (n - 1) ≤ N := by
  classical
  have : NeZero N := ⟨by omega⟩
  obtain ⟨a₀, ha₀⟩ : A.Nonempty := card_pos.mp (by omega)
  set A' := A.erase a₀ with hA'
  have hcardA' : #A' = n - 1 := by rw [card_erase_of_mem ha₀, hA]
  let f : Finset (ZMod N) → ZMod N := fun S => ∑ a ∈ S, (a - a₀)
  let g : ZMod N → ZMod N := fun b => 2 * (b - a₀)
  have hinj : Set.InjOn f (A'.powerset : Set (Finset (ZMod N))) := by
    intro S hS T hT hST
    by_contra hne
    exact not_isValidMod_of_shifted_sum_eq A a₀ ha₀ S T (mem_powerset.mp hS)
      (mem_powerset.mp hT) hne hST hv
  have hginj : Set.InjOn g (A' : Set (ZMod N)) := by
    intro b _ c _ hbc
    have h2 : 2 * (b - c) = 0 := by
      have : 2 * (b - a₀) = 2 * (c - a₀) := hbc
      linear_combination this
    exact sub_eq_zero.mp (eq_zero_of_two_mul_eq_zero_of_odd hN hodd h2)
  have hsub : A'.powerset.image f ⊆ univ \ A'.image g := by
    intro x hx
    obtain ⟨T, hT, rfl⟩ := mem_image.mp hx
    refine mem_sdiff.mpr ⟨mem_univ _, fun hmem => ?_⟩
    obtain ⟨b, hb, hbT⟩ := mem_image.mp hmem
    have hb2 : 2 * (b - a₀) ≠ 0 := fun h =>
      (mem_erase.mp hb).1 (sub_eq_zero.mp (eq_zero_of_two_mul_eq_zero_of_odd hN hodd h))
    exact shifted_sum_ne_two_mul A hv a₀ ha₀ b hb hb2 T (mem_powerset.mp hT) hbT.symm
  have hcard := card_le_card hsub
  rw [card_image_of_injOn hinj, card_powerset, hcardA', card_sdiff_of_subset (subset_univ _),
    card_univ, ZMod.card, card_image_of_injOn hginj, hcardA'] at hcard
  have : n - 1 ≤ N := by
    have := card_le_univ A'
    rw [hcardA', ZMod.card] at this
    exact this
  omega

/-- **The conjecture for `n = 3` (proved).** No 3-element subset of `ZMod N` is valid for
`0 < N < minModulus 3 = 6`. -/
theorem min_modulus_three (N : ℕ) (hN : 0 < N) (hlt : N < minModulus 3)
    (A : Finset (ZMod N)) (hA : #A = 3) : ¬ IsValidMod A := by
  have hlog : Nat.log 2 3 = 1 := Nat.log_eq_of_pow_le_of_lt_pow (by norm_num) (by norm_num)
  have h6 : minModulus 3 = 6 := by
    simp [minModulus, hlog]
  rw [h6] at hlt
  by_cases h4 : N ≤ 4
  · exact not_isValidMod_of_le_two_pow_pred 3 le_rfl hN (by simpa using h4) A hA
  · intro hv
    have h5 : N = 5 := by omega
    have := two_pow_add_le_of_odd 3 (by norm_num) hN ⟨2, by omega⟩ A hA hv
    omega

/-- Pair witness: `z + w = x + y` with `z ≠ w` and `x, y ∉ {z, w}` (`x = y` allowed) means the
multiset that drops `z, w` and adds `x, y` breaks validity. -/
theorem not_isValidMod_of_pair (A : Finset (ZMod N)) {z w x y : ZMod N} (hz : z ∈ A)
    (hw : w ∈ A) (hx : x ∈ A) (hy : y ∈ A) (hzw : z ≠ w) (hxz : x ≠ z) (hxw : x ≠ w)
    (hyz : y ≠ z) (hyw : y ≠ w) (hsum : z + w = x + y) : ¬ IsValidMod A := by
  classical
  let v : ZMod N → ℤ := fun a => (if a = x then 1 else 0) + (if a = y then 1 else 0)
    - (if a = z then 1 else 0) - (if a = w then 1 else 0)
  have e : ∀ c ∈ A, ∑ a ∈ A, ((if a = c then (1 : ℤ) else 0 : ℤ) : ZMod N) * a = c := by
    intro c hc
    rw [sum_eq_single_of_mem c hc]
    · simp
    · intro b _ hb
      simp [hb]
  refine not_isValidMod_of_int_vec A v ?_ ?_ ?_ ⟨z, hz, ?_⟩
  · intro a _
    simp only [v]
    split_ifs <;> simp_all
  · simp only [v, sum_sub_distrib, sum_add_distrib, sum_ite_eq', hx, hy, hz, hw, if_true]
    norm_num
  · simp only [v, Int.cast_sub, Int.cast_add, sub_mul, add_mul, sum_sub_distrib, sum_add_distrib]
    rw [e x hx, e y hy, e z hz, e w hw]
    linear_combination -hsum
  · simp [v, hxz.symm, hyz.symm, hzw]

/-- Computable check: some pair witness exists inside the list. -/
def hasPair (l : List (ZMod N)) : Bool :=
  l.any fun z => l.any fun w => decide (z ≠ w) && l.any fun x => l.any fun y =>
    decide (x ≠ z) && decide (x ≠ w) && decide (y ≠ z) && decide (y ≠ w) && decide (z + w = x + y)

/-- Computable check: every 4 distinct residues mod `N` contain a pair witness. -/
def allQuads (N : ℕ) : Bool :=
  (List.range N).all fun i => (List.range N).all fun j => (List.range N).all fun k =>
    (List.range N).all fun l =>
      !(decide (i ≠ j) && decide (i ≠ k) && decide (i ≠ l) && decide (j ≠ k) && decide (j ≠ l)
        && decide (k ≠ l)) || hasPair [(i : ZMod N), j, k, l]

theorem allQuads_ten : allQuads 10 = true := by decide +kernel

theorem allQuads_eleven : allQuads 11 = true := by decide +kernel

/-- If `allQuads N` holds, no 4-element subset of `ZMod N` is valid. -/
theorem not_isValidMod_four_of_allQuads (N : ℕ) [NeZero N] (h : allQuads N = true)
    (A : Finset (ZMod N)) (hA : #A = 4) : ¬ IsValidMod A := by
  classical
  obtain ⟨a, b, c, d, hab, hac, had, hbc, hbd, hcd, rfl⟩ := card_eq_four.mp hA
  have hval : ∀ x y : ZMod N, x ≠ y → x.val ≠ y.val := fun x y hxy h =>
    hxy (ZMod.val_injective N h)
  simp only [allQuads, List.all_eq_true, List.mem_range] at h
  have hp := h a.val (ZMod.val_lt a) b.val (ZMod.val_lt b) c.val (ZMod.val_lt c) d.val
    (ZMod.val_lt d)
  simp only [ZMod.natCast_zmod_val, hval a b hab, hval a c hac, hval a d had, hval b c hbc,
    hval b d hbd, hval c d hcd, ne_eq, not_false_eq_true, decide_true, Bool.and_true,
    Bool.not_true, Bool.false_or] at hp
  simp only [hasPair, List.any_eq_true, Bool.and_eq_true, decide_eq_true_eq] at hp
  obtain ⟨z, hz, w, hw, hzw, x, hx, y, hy, ⟨⟨⟨⟨hxz, hxw⟩, hyz⟩, hyw⟩, hs⟩⟩ := hp
  have hmem : ∀ t ∈ [a, b, c, d], t ∈ ({a, b, c, d} : Finset (ZMod N)) := by simp
  exact not_isValidMod_of_pair _ (hmem z hz) (hmem w hw) (hmem x hx) (hmem y hy) hzw hxz hxw
    hyz hyw hs

/-- **The conjecture for `n = 4` (proved).** No 4-element subset of `ZMod N` is valid for
`0 < N < minModulus 4 = 12`. `N ≤ 8`: subset-sum pigeonhole; `N = 9`: odd bound `8 + 3 ≤ N`;
`N = 10, 11`: kernel-checked pair witnesses. -/
theorem min_modulus_four (N : ℕ) (hN : 0 < N) (hlt : N < minModulus 4)
    (A : Finset (ZMod N)) (hA : #A = 4) : ¬ IsValidMod A := by
  have hlog : Nat.log 2 4 = 2 := Nat.log_eq_of_pow_le_of_lt_pow (by norm_num) (by norm_num)
  have h12 : minModulus 4 = 12 := by
    simp [minModulus, hlog]
  rw [h12] at hlt
  by_cases h8 : N ≤ 8
  · exact not_isValidMod_of_le_two_pow_pred 4 (by norm_num) hN (by simpa using h8) A hA
  · by_cases h9 : N = 9
    · intro hv
      have := two_pow_add_le_of_odd 4 (by norm_num) hN ⟨4, by omega⟩ A hA hv
      omega
    · have h10 : N = 10 ∨ N = 11 := by omega
      rcases h10 with rfl | rfl
      · exact not_isValidMod_four_of_allQuads 10 allQuads_ten A hA
      · exact not_isValidMod_four_of_allQuads 11 allQuads_eleven A hA

end MinModulusSweep
