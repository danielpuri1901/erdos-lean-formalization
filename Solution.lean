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

/-- `ZMod N` has at most one element of order two. -/
theorem eq_of_two_mul_eq_zero (hN : 0 < N) {x y : ZMod N} (hx : 2 * x = 0) (hy : 2 * y = 0)
    (hx0 : x ≠ 0) (hy0 : y ≠ 0) : x = y := by
  have : NeZero N := ⟨by omega⟩
  have key : ∀ z : ZMod N, 2 * z = 0 → z ≠ 0 → 2 * z.val = N := by
    intro z hz hz0
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
  apply ZMod.val_injective
  have := key x hx hx0
  have := key y hy hy0
  omega

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
  -- `f` misses the value `2 * (b - a₀)`
  have hmiss : ∀ T ∈ A'.powerset, f T ≠ 2 * (b - a₀) := by
    intro T hT hfT
    have hTA' := mem_powerset.mp hT
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
  -- counting: `2 ^ (n - 1)` distinct values avoid one value of `ZMod N`
  have hsub : A'.powerset.image f ⊆ univ.erase (2 * (b - a₀)) := by
    intro x hx
    obtain ⟨T, hT, rfl⟩ := mem_image.mp hx
    exact mem_erase.mpr ⟨hmiss T hT, mem_univ _⟩
  have hcard := card_le_card hsub
  rw [card_image_of_injOn hinj, card_powerset, hcardA', card_erase_of_mem (mem_univ _),
    card_univ, ZMod.card] at hcard
  omega

end MinModulusSweep
