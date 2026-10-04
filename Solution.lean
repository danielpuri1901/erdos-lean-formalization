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

end MinModulusSweep
