import FormalConjectures.Wikipedia.VizingConjecture

open SimpleGraph

namespace SuenTarrProof

variable {α β : Type} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]

/-- Clark–Suen double projection with a gain: if `U` is a minimum dominating set of `G` and `D`
dominates `G □ H`, then `γ(G) γ(H) + #{u ∈ U | {u} × V(H) meets D} ≤ 2 |D|`. -/
theorem key (G : SimpleGraph α) (H : SimpleGraph β) (U : Finset α)
    (hU : G.IsNDominatingSet G.dominationNumber U)
    (D : Finset (α × β)) (hD : (G □ H).IsDominating (D : Set (α × β))) :
    G.dominationNumber * H.dominationNumber + (U.filter (fun u => ∃ y, (u, y) ∈ D)).card
      ≤ 2 * D.card := by
  classical
  -- assign every vertex to a dominator in `U`, fixing the elements of `U`
  have hf : ∀ x, ∃ u ∈ U, x = u ∨ G.Adj x u := by
    intro x
    rcases hU.isDominating x with h | ⟨w, hw, hadj⟩
    · exact ⟨x, h, Or.inl rfl⟩
    · exact ⟨w, hw, Or.inr hadj⟩
  obtain ⟨f, hfU, hfadj, hfu⟩ : ∃ f : α → α, (∀ x, f x ∈ U) ∧ (∀ x, x = f x ∨ G.Adj x (f x)) ∧
      (∀ u ∈ U, f u = u) := by
    refine ⟨fun x => if x ∈ U then x else Classical.choose (hf x), ?_, ?_, ?_⟩
    · intro x
      by_cases hx : x ∈ U
      · simp [hx]
      · simp only [hx, if_false]; exact (Classical.choose_spec (hf x)).1
    · intro x
      by_cases hx : x ∈ U
      · simp [hx]
      · simp only [hx, if_false]; exact (Classical.choose_spec (hf x)).2
    · intro u hu; simp [hu]
  -- rows
  let Dy : β → Finset α := fun y => (D.filter (fun p => p.2 = y)).image Prod.fst
  have memDy : ∀ x y, x ∈ Dy y ↔ (x, y) ∈ D := by
    intro x y
    constructor
    · intro h
      obtain ⟨p, hp, rfl⟩ := Finset.mem_image.mp h
      rw [Finset.mem_filter] at hp
      have : p = (p.1, y) := Prod.ext rfl hp.2
      rw [← this]; exact hp.1
    · intro h
      exact Finset.mem_image.mpr ⟨(x, y), Finset.mem_filter.mpr ⟨h, rfl⟩, rfl⟩
  let L : β → Finset α := fun y =>
    U.filter (fun u => ∀ x, f x = u → ∃ z ∈ Dy y, x = z ∨ G.Adj x z)
  have hrow : ∀ y, (L y).card ≤ (Dy y).card := by
    intro y
    have hdom : G.IsDominating (((U \ L y) ∪ Dy y : Finset α) : Set α) := by
      intro x
      by_cases hx : f x ∈ L y
      · obtain ⟨z, hz, h⟩ := (Finset.mem_filter.mp hx).2 x rfl
        rcases h with h | h
        · left
          rw [Finset.mem_coe, Finset.mem_union]
          exact Or.inr (h ▸ hz)
        · right
          exact ⟨z, by rw [Finset.mem_coe, Finset.mem_union]; exact Or.inr hz, h⟩
      · have hmem : f x ∈ U \ L y := Finset.mem_sdiff.mpr ⟨hfU x, hx⟩
        rcases hfadj x with h | h
        · left
          rw [Finset.mem_coe, Finset.mem_union]
          exact Or.inl (h ▸ hmem)
        · right
          exact ⟨f x, by rw [Finset.mem_coe, Finset.mem_union]; exact Or.inl hmem, h⟩
    have h1 := dominationNumber_le_of_isDominating G _ hdom
    have h2 := Finset.card_union_le (U \ L y) (Dy y)
    have h3 : (U \ L y).card = U.card - (L y).card :=
      Finset.card_sdiff_of_subset (Finset.filter_subset _ _)
    have h4 : (L y).card ≤ U.card := Finset.card_le_card (Finset.filter_subset _ _)
    have h5 := hU.card_eq
    omega
  -- columns
  let P : α → Finset β := fun u => (D.filter (fun p => f p.1 = u)).image Prod.snd
  let UU : α → Finset β := fun u => Finset.univ.filter (fun y => u ∈ L y)
  have hcol : ∀ u ∈ U, H.dominationNumber ≤ (P u ∪ UU u).card := by
    intro u hu
    apply dominationNumber_le_of_isDominating
    intro y
    by_cases hy : ∃ y' ∈ P u, y = y' ∨ H.Adj y y'
    · obtain ⟨y', hy', h⟩ := hy
      rcases h with h | h
      · left
        rw [Finset.mem_coe, Finset.mem_union]
        exact Or.inl (h ▸ hy')
      · right
        exact ⟨y', by rw [Finset.mem_coe, Finset.mem_union]; exact Or.inl hy', h⟩
    · left
      have hL : u ∈ L y := by
        refine Finset.mem_filter.mpr ⟨hu, ?_⟩
        intro x hx
        rcases hD (x, y) with h | ⟨⟨x', y'⟩, hmem, hadj⟩
        · exact ⟨x, (memDy x y).mpr h, Or.inl rfl⟩
        · rw [boxProd_adj] at hadj
          rcases hadj with ⟨hadj, h2⟩ | ⟨hadj, h2⟩
          · simp only at h2 hadj
            subst h2
            exact ⟨x', (memDy x' y).mpr hmem, Or.inr hadj⟩
          · exfalso
            simp only at h2 hadj
            subst h2
            apply hy
            refine ⟨y', ?_, Or.inr hadj⟩
            exact Finset.mem_image.mpr ⟨(x, y'), Finset.mem_filter.mpr ⟨hmem, hx⟩, rfl⟩
      rw [Finset.mem_coe, Finset.mem_union]
      exact Or.inr (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hL⟩)
  let Du : α → Finset (α × β) := fun u => D.filter (fun p => f p.1 = u)
  let Du' : α → Finset (α × β) := fun u => D.filter (fun p => f p.1 = u ∧ p.2 ∉ UU u)
  have hPU : ∀ u, (P u ∪ UU u).card ≤ (Du' u).card + (UU u).card := by
    intro u
    rw [← Finset.sdiff_union_self_eq_union]
    refine (Finset.card_union_le _ _).trans (Nat.add_le_add_right ?_ _)
    have hsub : P u \ UU u ⊆ (Du' u).image Prod.snd := by
      intro y hy
      rw [Finset.mem_sdiff] at hy
      obtain ⟨p, hp, rfl⟩ := Finset.mem_image.mp hy.1
      rw [Finset.mem_filter] at hp
      exact Finset.mem_image.mpr ⟨p, Finset.mem_filter.mpr ⟨hp.1, hp.2, hy.2⟩, rfl⟩
    exact (Finset.card_le_card hsub).trans Finset.card_image_le
  have hgain : ∀ u ∈ U,
      (Du' u).card + (if ∃ y, (u, y) ∈ D then 1 else 0) ≤ (Du u).card := by
    intro u hu
    have hsub : Du' u ⊆ Du u := by
      intro p hp
      rw [Finset.mem_filter] at hp ⊢
      exact ⟨hp.1, hp.2.1⟩
    split_ifs with h
    · obtain ⟨y0, hy0⟩ := h
      have hL : u ∈ L y0 := by
        refine Finset.mem_filter.mpr ⟨hu, ?_⟩
        intro x hx
        refine ⟨u, (memDy u y0).mpr hy0, ?_⟩
        have := hfadj x
        rw [hx] at this
        exact this
      have hin : (u, y0) ∈ Du u := Finset.mem_filter.mpr ⟨hy0, hfu u hu⟩
      have hout : (u, y0) ∉ Du' u := by
        intro h
        rw [Finset.mem_filter] at h
        exact h.2.2 (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hL⟩)
      have : Du' u ⊂ Du u := Finset.ssubset_iff_subset_ne.mpr
        ⟨hsub, fun h => hout (h ▸ hin)⟩
      have := Finset.card_lt_card this
      omega
    · simpa using Finset.card_le_card hsub
  -- summing up
  have hsumD : D.card = ∑ u ∈ U, (Du u).card := by
    apply Finset.card_eq_sum_card_fiberwise
    intro p _
    exact hfU p.1
  have hsumD2 : D.card = ∑ y ∈ (Finset.univ : Finset β), (D.filter (fun p => p.2 = y)).card := by
    apply Finset.card_eq_sum_card_fiberwise
    intro p _
    exact Finset.mem_coe.mpr (Finset.mem_univ _)
  have hUU : ∑ u ∈ U, (UU u).card = ∑ y ∈ (Finset.univ : Finset β), (L y).card := by
    have e1 : ∀ u, (UU u).card = ∑ y ∈ (Finset.univ : Finset β), if u ∈ L y then 1 else 0 :=
      fun u => Finset.card_filter _ _
    have e2 : ∀ y, (L y).card = ∑ u ∈ U, if u ∈ L y then 1 else 0 := by
      intro y
      rw [← Finset.card_filter]
      congr 1
      ext u
      simp only [Finset.mem_filter]
      constructor
      · intro h; exact ⟨(Finset.mem_filter.mp h).1, h⟩
      · intro h; exact h.2
    simp_rw [e1, e2]
    exact Finset.sum_comm
  have hLD : ∑ y ∈ (Finset.univ : Finset β), (L y).card ≤ D.card := by
    rw [hsumD2]
    apply Finset.sum_le_sum
    intro y _
    exact (hrow y).trans Finset.card_image_le
  have hm : (U.filter (fun u => ∃ y, (u, y) ∈ D)).card =
      ∑ u ∈ U, if ∃ y, (u, y) ∈ D then 1 else 0 := Finset.card_filter _ _
  have hk : G.dominationNumber * H.dominationNumber = ∑ u ∈ U, H.dominationNumber := by
    rw [Finset.sum_const, smul_eq_mul, hU.card_eq]
  have hmain : ∑ u ∈ U, (H.dominationNumber + if ∃ y, (u, y) ∈ D then 1 else 0) ≤
      ∑ u ∈ U, ((Du u).card + (UU u).card) := by
    apply Finset.sum_le_sum
    intro u hu
    have := hcol u hu
    have := hPU u
    have := hgain u hu
    omega
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib, ← hsumD, hUU, ← hk, ← hm] at hmain
  omega

end SuenTarrProof

theorem suen_tarr {α β : Type} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]
    (G : SimpleGraph α) (H : SimpleGraph β) :
    G.dominationNumber * H.dominationNumber + min G.dominationNumber H.dominationNumber ≤
      2 * (G □ H).dominationNumber := by
  classical
  obtain ⟨D, hD⟩ := exists_isNDominatingSet_dominationNumber (G □ H)
  obtain ⟨U, hU⟩ := exists_isNDominatingSet_dominationNumber G
  obtain ⟨V, hV⟩ := exists_isNDominatingSet_dominationNumber H
  rw [← hD.card_eq]
  by_cases hall : ∀ u ∈ U, ∃ y, (u, y) ∈ D
  · have h := SuenTarrProof.key G H U hU D hD.isDominating
    have hf : U.filter (fun u => ∃ y, (u, y) ∈ D) = U := Finset.filter_true_of_mem hall
    rw [hf, hU.card_eq] at h
    have := min_le_left G.dominationNumber H.dominationNumber
    omega
  · push_neg at hall
    obtain ⟨u, -, hu⟩ := hall
    -- every row of `G □ H` meets `D`, since `{u} × V(H)` is dominated horizontally
    have hrows : ∀ y, ∃ x, (x, y) ∈ D := by
      intro y
      rcases hD.isDominating (u, y) with h | ⟨⟨x', y'⟩, hmem, hadj⟩
      · exact absurd h (hu y)
      · rw [boxProd_adj] at hadj
        rcases hadj with ⟨-, h2⟩ | ⟨-, h2⟩
        · simp only at h2
          subst h2
          exact ⟨x', hmem⟩
        · simp only at h2
          subst h2
          exact absurd hmem (hu y')
    let D' : Finset (β × α) := D.image Prod.swap
    have hD' : (H □ G).IsDominating (D' : Set (β × α)) := by
      intro ⟨y, x⟩
      rcases hD.isDominating (x, y) with h | ⟨⟨x', y'⟩, hmem, hadj⟩
      · left
        exact Finset.mem_coe.mpr (Finset.mem_image.mpr ⟨(x, y), h, rfl⟩)
      · right
        refine ⟨(y', x'), Finset.mem_coe.mpr (Finset.mem_image.mpr ⟨(x', y'), hmem, rfl⟩), ?_⟩
        rw [boxProd_adj] at hadj ⊢
        simp only at hadj ⊢
        tauto
    have h := SuenTarrProof.key H G V hV D' hD'
    have hf : V.filter (fun v => ∃ x, (v, x) ∈ D') = V := by
      apply Finset.filter_true_of_mem
      intro v _
      obtain ⟨x, hx⟩ := hrows v
      exact ⟨x, Finset.mem_image.mpr ⟨(x, v), hx, rfl⟩⟩
    have hcard : D'.card = D.card := Finset.card_image_of_injective _ Prod.swap_injective
    rw [hf, hV.card_eq, hcard] at h
    have := min_le_right G.dominationNumber H.dominationNumber
    have := Nat.mul_comm G.dominationNumber H.dominationNumber
    omega
