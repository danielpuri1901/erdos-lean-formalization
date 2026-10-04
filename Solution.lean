import FormalConjectures.WrittenOnTheWallII.GraphConjecture100

/-!
# Sweep wowii100: a proof of WOWII Conjecture 100

Paper proof: `sweep/wowii100/NOTES.md`. Notation there and here:
`A = α(G)`, `I` a maximum independent set, `R = Iᶜ`, `K = |R|`, `m = maxL`,
`c v = Gᶜ.degree v`, `nR u = #{w ∈ R | ¬ u ~ w}`, `nI w = #{u ∈ I | ¬ u ~ w}`,
`D = ∑_{u ∈ I} nR u = ∑_{w ∈ R} nI w`, `P = ∑_{u ∈ I} c u`,
`SI = ∑_{u ∈ I} (c u)^2`, `SR = ∑_{w ∈ R} (c w)^2`, `t = 2A - 2 - m`.
-/

open SimpleGraph Finset

namespace Wowii100

/-- Polynomial lemma: `4 m² t² ≤ A X²` with `X = m A + A - 2 m`. -/
lemma poly (A m : ℤ) (h1 : 1 ≤ m) (h2 : m ≤ A) (ht : 0 ≤ 2 * A - 2 - m) :
    4 * m ^ 2 * (2 * A - 2 - m) ^ 2 ≤ A * (m * A + A - 2 * m) ^ 2 := by
  by_cases hA : A ≤ 15
  · -- finite check of the pairs `1 ≤ m ≤ A ≤ 15`
    have hA1 : 1 ≤ A := le_trans h1 h2
    interval_cases A <;> interval_cases m <;> omega
  · -- `A ≥ 16`: `A X² ≥ 16 X² = 4 (2X)²` and `2X ≥ m t ≥ 0`
    have hA16 : 16 ≤ A := by omega
    have hX : 0 ≤ m * A + A - 2 * m := by nlinarith
    have hmt : 0 ≤ m * (2 * A - 2 - m) := mul_nonneg (by omega) ht
    have h2X : m * (2 * A - 2 - m) ≤ 2 * (m * A + A - 2 * m) := by nlinarith
    calc 4 * m ^ 2 * (2 * A - 2 - m) ^ 2 = 4 * (m * (2 * A - 2 - m)) ^ 2 := by ring
      _ ≤ 4 * (2 * (m * A + A - 2 * m)) ^ 2 := by gcongr
      _ = 16 * (m * A + A - 2 * m) ^ 2 := by ring
      _ ≤ A * (m * A + A - 2 * m) ^ 2 := by gcongr

/-- The final algebra (cases `m ≥ A` and `m < A` of the notes), over `ℤ`. -/
lemma algebra (A m K P SI SR D : ℤ) (hA : 1 ≤ A) (hm0 : 0 ≤ m) (hD0 : 0 ≤ D)
    (hL2 : A * A + D ≤ P + A)
    (hL4 : K * A ≤ D + K * m)
    (hL5 : D + A ≤ A * K)
    (hCS : P ^ 2 ≤ A * SI)
    (hSR : m < A → 1 ≤ SR) (hSR0 : 0 ≤ SR)
    (ht : 0 ≤ 2 * A - 2 - m) :
    4 * (2 * A - 2 - m) ^ 2 < SI + SR := by
  -- `K m ≥ A`
  have hKm : A ≤ K * m := by linarith
  by_cases hmA : A ≤ m
  · -- case `m ≥ A`: `SI ≥ A (A-1)² > 4 (A-2)² ≥ 4 t²`
    have hA2 : 2 ≤ A := by omega
    have hP : A * (A - 1) ≤ P := by linarith
    have hP2 : (A * (A - 1)) ^ 2 ≤ P ^ 2 := pow_le_pow_left₀ (by nlinarith) hP 2
    have hSI : A * (A - 1) ^ 2 ≤ SI := by
      have h : A * (A * (A - 1) ^ 2) ≤ A * SI := by nlinarith
      exact le_of_mul_le_mul_left h (by omega)
    have ht2 : (2 * A - 2 - m) ^ 2 ≤ (A - 2) ^ 2 := pow_le_pow_left₀ ht (by omega) 2
    have hlt : 4 * (A - 2) ^ 2 < A * (A - 1) ^ 2 := by
      rcases (show A = 2 ∨ A = 3 ∨ 4 ≤ A by omega) with h | h | h
      · subst h; norm_num
      · subst h; norm_num
      · have h1 : 4 * (A - 1) ^ 2 ≤ A * (A - 1) ^ 2 := by gcongr
        have h2 : (A - 2) ^ 2 < (A - 1) ^ 2 := by nlinarith
        linarith
    linarith
  · -- case `m < A`
    have hmA' : m < A := not_le.mp hmA
    have hm1 : 1 ≤ m := by
      by_contra hc
      have : m = 0 := by omega
      subst this
      simp at hKm
      omega
    -- `m P ≥ A X`
    have h1 : m * (A * A + D - A) ≤ m * P := mul_le_mul_of_nonneg_left (by linarith) hm0
    have h2 : m * (K * A - K * m) ≤ m * D := mul_le_mul_of_nonneg_left (by linarith) hm0
    have h3 : 0 ≤ (K * m - A) * (A - m) := mul_nonneg (by linarith) (by linarith)
    have hX : A * (m * A + A - 2 * m) ≤ m * P := by nlinarith
    have hX0 : 0 ≤ m * A + A - 2 * m := by nlinarith
    have hsq : (A * (m * A + A - 2 * m)) ^ 2 ≤ (m * P) ^ 2 :=
      pow_le_pow_left₀ (mul_nonneg (by omega) hX0) hX 2
    have hpoly := poly A m hm1 hmA'.le ht
    have hmain : A * m ^ 2 * (4 * (2 * A - 2 - m) ^ 2) ≤ A * m ^ 2 * SI := by
      calc A * m ^ 2 * (4 * (2 * A - 2 - m) ^ 2)
          = A * (4 * m ^ 2 * (2 * A - 2 - m) ^ 2) := by ring
        _ ≤ A * (A * (m * A + A - 2 * m) ^ 2) :=
          mul_le_mul_of_nonneg_left hpoly (by omega)
        _ = (A * (m * A + A - 2 * m)) ^ 2 := by ring
        _ ≤ (m * P) ^ 2 := hsq
        _ = m ^ 2 * P ^ 2 := by ring
        _ ≤ m ^ 2 * (A * SI) := mul_le_mul_of_nonneg_left hCS (by positivity)
        _ = A * m ^ 2 * SI := by ring
    have hpos : 0 < A * m ^ 2 := by positivity
    have hSI := le_of_mul_le_mul_left hmain hpos
    have := hSR hmA'
    linarith

/-- The last step over `ℝ`: from the counting facts (in `ℕ`) to `A - 1 < (m + √S / 2) / 2`. -/
lemma final (A m K P SI SR D : ℕ) (hA : 1 ≤ A)
    (hL2 : A * A + D ≤ P + A)
    (hL4 : K * A ≤ D + K * m)
    (hL5 : D + A ≤ A * K)
    (hCS : P ^ 2 ≤ A * SI)
    (hSR : m < A → 1 ≤ SR) :
    (A : ℝ) - 1 < ((m : ℝ) + (1 / 2) * Real.sqrt ((SI : ℝ) + SR)) / 2 := by
  have hsq := Real.sqrt_nonneg ((SI : ℝ) + SR)
  by_cases ht : 2 * (A : ℤ) - 2 - m < 0
  · have : 2 * (A : ℝ) - 2 - m < 0 := by exact_mod_cast ht
    linarith
  · have ht0 : 0 ≤ 2 * (A : ℤ) - 2 - m := not_lt.mp ht
    have hZ := algebra (A : ℤ) (m : ℤ) (K : ℤ) (P : ℤ) (SI : ℤ) (SR : ℤ) (D : ℤ)
      (by exact_mod_cast hA) (by positivity) (by positivity)
      (by exact_mod_cast hL2) (by exact_mod_cast hL4) (by exact_mod_cast hL5)
      (by exact_mod_cast hCS) (fun h' => by exact_mod_cast hSR (by exact_mod_cast h'))
      (by positivity) ht0
    have hR : 4 * (2 * (A : ℝ) - 2 - m) ^ 2 < (SI : ℝ) + SR := by exact_mod_cast hZ
    have ht' : (0 : ℝ) ≤ 2 * (2 * (A : ℝ) - 2 - m) := by
      have : (0 : ℝ) ≤ 2 * (A : ℝ) - 2 - m := by exact_mod_cast ht0
      linarith
    have hlt : 2 * (2 * (A : ℝ) - 2 - m) < Real.sqrt ((SI : ℝ) + SR) :=
      (Real.lt_sqrt ht').mpr (by nlinarith)
    linarith

end Wowii100

open Wowii100 in
/-- WOWII Conjecture 100 holds: for every connected graph on a nontrivial finite type,
`α(G) ≤ ⌈(max_v l(v) + ½ · degreeL2Norm Gᶜ) / 2⌉`. -/
theorem wowii100_holds {V : Type*} [Fintype V] [DecidableEq V] [Nontrivial V]
    (G : SimpleGraph V) [DecidableRel G.Adj] (h : G.Connected) :
    let maxL := (Finset.univ.image (indepNeighborsCard G)).max' (by simp)
    (G.indepNum : ℝ) ≤ ⌈((maxL : ℝ) + (1 / 2) * (degreeL2Norm Gᶜ : ℝ)) / 2⌉ := by
  intro maxL
  -- notation
  obtain ⟨I, hI⟩ := G.exists_isNIndepSet_indepNum
  have hIcard : I.card = G.indepNum := hI.card_eq
  have hIind : G.IsIndepSet (I : Set V) := hI.isIndepSet
  have hm : ∀ v, indepNeighborsCard G v ≤ maxL := fun v =>
    Finset.le_max' _ _ (Finset.mem_image_of_mem _ (Finset.mem_univ v))
  -- every vertex has a neighbour
  have hnb : ∀ u, ∃ w, G.Adj u w := fun u =>
    (G.degree_pos_iff_exists_adj u).mp (h.preconnected.degree_pos_of_nontrivial u)
  -- L1: for `u ∈ I`, `A + nR u ≤ c u + 1`
  have hL1 : ∀ u ∈ I, G.indepNum + (Iᶜ.filter (fun w => ¬ G.Adj u w)).card
      ≤ Gᶜ.degree u + 1 := by
    intro u hu
    have hsub : (I.erase u) ∪ Iᶜ.filter (fun w => ¬ G.Adj u w) ⊆ Gᶜ.neighborFinset u := by
      intro x hx
      rw [mem_neighborFinset, compl_adj]
      rcases mem_union.mp hx with hx | hx
      · obtain ⟨hxu, hxI⟩ := mem_erase.mp hx
        exact ⟨Ne.symm hxu, hIind (mem_coe.mpr hu) (mem_coe.mpr hxI) (Ne.symm hxu)⟩
      · obtain ⟨hxR, hadj⟩ := mem_filter.mp hx
        refine ⟨?_, hadj⟩
        rintro rfl
        exact (mem_compl.mp hxR) hu
    have hdisj : Disjoint (I.erase u) (Iᶜ.filter (fun w => ¬ G.Adj u w)) := by
      rw [Finset.disjoint_left]
      intro x hx hx'
      exact (mem_compl.mp (mem_filter.mp hx').1) (mem_of_mem_erase hx)
    have hc := card_le_card hsub
    rw [card_union_of_disjoint hdisj, card_erase_of_mem hu, card_neighborFinset_eq_degree,
      hIcard] at hc
    have : 1 ≤ G.indepNum := by rw [← hIcard]; exact card_pos.mpr ⟨u, hu⟩
    omega
  -- L2: `A * A + D ≤ P + A`
  have hL2 : G.indepNum * G.indepNum + ∑ u ∈ I, (Iᶜ.filter (fun w => ¬ G.Adj u w)).card
      ≤ ∑ u ∈ I, Gᶜ.degree u + G.indepNum := by
    have := Finset.sum_le_sum hL1
    simpa [Finset.sum_add_distrib, hIcard] using this
  -- L3: for every `w`, `#{u ∈ I | u ~ w} ≤ m`
  have hL3 : ∀ w, (I.filter (fun u => G.Adj u w)).card ≤ maxL := by
    intro w
    refine le_trans ?_ (hm w)
    unfold indepNeighborsCard
    classical
    let T : Finset (G.neighborSet w) :=
      (I.filter (fun u => G.Adj u w)).subtype (· ∈ G.neighborSet w)
    have hT : T.card = (I.filter (fun u => G.Adj u w)).card := by
      simp only [T, Finset.card_subtype]
      congr 1
      apply Finset.filter_true_of_mem
      intro x hx
      exact (G.mem_neighborSet w x).mpr (mem_filter.mp hx).2.symm
    rw [← hT]
    apply IsIndepSet.card_le_indepNum
    intro a ha b hb hab hadj
    simp only [T, mem_coe, Finset.mem_subtype, mem_filter] at ha hb
    simp only [comap_adj, Function.Embedding.coe_subtype] at hadj
    exact hIind (mem_coe.mpr ha.1) (mem_coe.mpr hb.1) (Subtype.coe_ne_coe.mpr hab) hadj
  -- L4: for every `w`, `A ≤ nI w + m`
  have hL4 : ∀ w, G.indepNum ≤ (I.filter (fun u => ¬ G.Adj u w)).card + maxL := by
    intro w
    have h1 := card_filter_add_card_filter_not (s := I) (fun u => G.Adj u w)
    have h2 := hL3 w
    omega
  -- double counting: `∑_{u ∈ I} nR u = ∑_{w ∈ R} nI w`
  have hDC : ∑ u ∈ I, (Iᶜ.filter (fun w => ¬ G.Adj u w)).card
      = ∑ w ∈ Iᶜ, (I.filter (fun u => ¬ G.Adj u w)).card :=
    sum_card_bipartiteAbove_eq_sum_card_bipartiteBelow (fun u w => ¬ G.Adj u w)
  have hL4s : Iᶜ.card * G.indepNum ≤ ∑ w ∈ Iᶜ, (I.filter (fun u => ¬ G.Adj u w)).card
      + Iᶜ.card * maxL := by
    have := Finset.sum_le_sum (fun w (_ : w ∈ Iᶜ) => hL4 w)
    simpa [Finset.sum_add_distrib] using this
  -- L5: for `u ∈ I`, `nR u + 1 ≤ K`
  have hL5 : ∀ u ∈ I, (Iᶜ.filter (fun w => ¬ G.Adj u w)).card + 1 ≤ Iᶜ.card := by
    intro u hu
    obtain ⟨x, hx⟩ := hnb u
    have hxR : x ∈ Iᶜ := by
      rw [mem_compl]
      intro hxI
      exact hIind (mem_coe.mpr hu) (mem_coe.mpr hxI) (G.ne_of_adj hx) hx
    have hss : Iᶜ.filter (fun w => ¬ G.Adj u w) ⊂ Iᶜ :=
      Finset.filter_ssubset.mpr ⟨x, hxR, not_not.mpr hx⟩
    have := card_lt_card hss
    omega
  have hL5s : ∑ u ∈ I, (Iᶜ.filter (fun w => ¬ G.Adj u w)).card + G.indepNum
      ≤ G.indepNum * Iᶜ.card := by
    have := Finset.sum_le_sum hL5
    simpa [Finset.sum_add_distrib, hIcard] using this
  -- L6: Cauchy–Schwarz
  have hCS : (∑ u ∈ I, Gᶜ.degree u) ^ 2 ≤ G.indepNum * ∑ u ∈ I, Gᶜ.degree u ^ 2 := by
    rw [← hIcard]
    exact sq_sum_le_card_mul_sum_sq
  -- L7: if `m < A` then `SR ≥ 1`
  have hSR : maxL < G.indepNum → 1 ≤ ∑ w ∈ Iᶜ, Gᶜ.degree w ^ 2 := by
    intro hmA
    have hIne : I.Nonempty := by
      rw [← card_pos, hIcard]; omega
    obtain ⟨u, hu⟩ := hIne
    obtain ⟨x, hx⟩ := hnb u
    have hxR : x ∈ Iᶜ := by
      rw [mem_compl]
      intro hxI
      exact hIind (mem_coe.mpr hu) (mem_coe.mpr hxI) (G.ne_of_adj hx) hx
    have hsub : I.filter (fun y => ¬ G.Adj y x) ⊆ Gᶜ.neighborFinset x := by
      intro y hy
      obtain ⟨hyI, hyx⟩ := mem_filter.mp hy
      rw [mem_neighborFinset, compl_adj]
      refine ⟨?_, fun h' => hyx h'.symm⟩
      rintro rfl
      exact (mem_compl.mp hxR) hyI
    have h1 := card_le_card hsub
    rw [card_neighborFinset_eq_degree] at h1
    have h2 := hL4 x
    have h3 : 1 ≤ Gᶜ.degree x := by omega
    calc 1 ≤ Gᶜ.degree x ^ 2 := Nat.one_le_pow _ _ h3
      _ ≤ ∑ w ∈ Iᶜ, Gᶜ.degree w ^ 2 :=
        Finset.single_le_sum (f := fun w => Gᶜ.degree w ^ 2) (fun _ _ => Nat.zero_le _) hxR
  -- split `S = SI + SR`
  have hS : ∑ v, (Gᶜ.degree v : ℝ) ^ 2
      = ((∑ u ∈ I, Gᶜ.degree u ^ 2 : ℕ) : ℝ) + ((∑ w ∈ Iᶜ, Gᶜ.degree w ^ 2 : ℕ) : ℝ) := by
    push_cast
    exact (Finset.sum_add_sum_compl I (fun v => (Gᶜ.degree v : ℝ) ^ 2)).symm
  -- `A ≥ 1`
  have hA1 : 1 ≤ G.indepNum := by
    obtain ⟨u⟩ := (inferInstance : Nonempty V)
    have : ({u} : Finset V).card ≤ G.indepNum :=
      IsIndepSet.card_le_indepNum (by simp [isIndepSet_iff])
    simpa using this
  -- reduce the ceiling to a strict inequality
  have key : ((G.indepNum : ℤ) : ℝ) - 1
      < ((maxL : ℝ) + (1 / 2) * (degreeL2Norm Gᶜ : ℝ)) / 2 := by
    unfold degreeL2Norm
    rw [hS, Int.cast_natCast]
    exact final _ _ _ _ _ _ _ hA1 hL2 (hDC ▸ hL4s) hL5s hCS hSR
  have hceil : (G.indepNum : ℤ) ≤ ⌈((maxL : ℝ) + (1 / 2) * (degreeL2Norm Gᶜ : ℝ)) / 2⌉ :=
    Int.le_ceil_iff.mpr key
  exact_mod_cast hceil

/-- The statement proved above is exactly the type of the imported `conjecture100`. -/
theorem wowii100_matches.{u} :
    type_of% @WrittenOnTheWallII.GraphConjecture100.conjecture100.{u} :=
  @wowii100_holds.{u}

