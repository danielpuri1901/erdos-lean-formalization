import FormalConjectures.Wikipedia.VizingConjecture

/-!
Proof of the Clark-Suen inequality by double counting.

Let `A` be a minimum dominating set of `G` and `D` a minimum dominating set of `G □ H`.
Send each vertex `g` of `G` to a vertex `f g ∈ A` dominating it; the fibres of `f` partition
the vertices of `G` into cells. For `a ∈ A` let `P a` be the projection to `H` of the part of `D`
lying over the cell of `a`. Call the pair `(a, h)` bad when `h` is not dominated by `P a` in `H`.

* For fixed `h`, the vertices `a ∈ A` with `(a, h)` good, together with the projection of the
  layer `D ∩ (V(G) × {h})`, dominate `G`. So the number of bad pairs with second coordinate `h`
  is at most the size of that layer, and summing over `h` gives at most `|D|` bad pairs.
* For fixed `a ∈ A`, the set `P a` together with the vertices `h` with `(a, h)` bad dominates `H`.
  So `γ(H)` is at most the size of the part of `D` over the cell of `a` plus the number of bad
  pairs with first coordinate `a`. Summing over `a` gives `γ(G) γ(H) ≤ |D| + |D|`.
-/

open SimpleGraph

theorem clark_suen {α β : Type} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]
    (G : SimpleGraph α) (H : SimpleGraph β) :
    G.dominationNumber * H.dominationNumber ≤ 2 * (G □ H).dominationNumber := by
  classical
  obtain ⟨A, hA, hAcard⟩ := G.exists_isNDominatingSet_dominationNumber
  obtain ⟨D, hD, hDcard⟩ := (G □ H).exists_isNDominatingSet_dominationNumber
  -- Each vertex of `G` is assigned a dominator in `A`.
  have hf : ∀ g : α, ∃ a ∈ A, g = a ∨ G.Adj g a := by
    intro g
    rcases hA g with h | ⟨w, hw, hadj⟩
    · exact ⟨g, Finset.mem_coe.mp h, Or.inl rfl⟩
    · exact ⟨w, Finset.mem_coe.mp hw, Or.inr hadj⟩
  choose f hfA hfadj using hf
  -- The part of `D` over the cell of `a`, and its projection to `H`.
  let Da : α → Finset (α × β) := fun a => D.filter (fun p => f p.1 = a)
  let P : α → Finset β := fun a => (Da a).image Prod.snd
  -- `(a, h)` is bad when `h` is not dominated by `P a`.
  let bad : α → β → Prop := fun a h => ¬ (h ∈ P a ∨ ∃ h' ∈ P a, H.Adj h h')
  -- The layer of `D` at height `h`.
  let Dh : β → Finset (α × β) := fun h => D.filter (fun p => p.2 = h)
  have claim1 : ∀ h, (A.filter (fun a => bad a h)).card ≤ (Dh h).card := by
    intro h
    have hdom : G.IsDominating
        ((A.filter (fun a => ¬ bad a h) ∪ (Dh h).image Prod.fst : Finset α) : Set α) := by
      intro g
      by_cases hb : bad (f g) h
      · rcases hD (g, h) with hgh | ⟨⟨g', h'⟩, hmem, hadj⟩
        · left
          rw [Finset.mem_coe, Finset.mem_union]
          right
          exact Finset.mem_image.mpr ⟨(g, h), Finset.mem_filter.mpr ⟨Finset.mem_coe.mp hgh, rfl⟩, rfl⟩
        · rw [boxProd_adj] at hadj
          rcases hadj with ⟨hgg', hhh'⟩ | ⟨hhh', hgg'⟩
          · right
            subst hhh'
            refine ⟨g', ?_, hgg'⟩
            rw [Finset.mem_coe, Finset.mem_union]
            right
            exact Finset.mem_image.mpr
              ⟨(g', h), Finset.mem_filter.mpr ⟨Finset.mem_coe.mp hmem, rfl⟩, rfl⟩
          · exfalso
            subst hgg'
            apply hb
            right
            exact ⟨h', Finset.mem_image.mpr
              ⟨(g, h'), Finset.mem_filter.mpr ⟨Finset.mem_coe.mp hmem, rfl⟩, rfl⟩, hhh'⟩
      · have hmem : f g ∈ (A.filter (fun a => ¬ bad a h) ∪ (Dh h).image Prod.fst : Finset α) :=
          Finset.mem_union_left _ (Finset.mem_filter.mpr ⟨hfA g, hb⟩)
        rcases hfadj g with heq | hadj
        · left
          rw [heq]
          exact Finset.mem_coe.mpr hmem
        · right
          exact ⟨f g, Finset.mem_coe.mpr hmem, hadj⟩
    have h1 := dominationNumber_le_of_isDominating G _ hdom
    have h2 := Finset.card_union_le (A.filter (fun a => ¬ bad a h)) ((Dh h).image Prod.fst)
    have h3 : ((Dh h).image Prod.fst).card ≤ (Dh h).card := Finset.card_image_le
    have h4 := Finset.card_filter_add_card_filter_not (s := A) (fun a => bad a h)
    omega
  have claim2 : ∀ a ∈ A,
      H.dominationNumber ≤ (Da a).card + (Finset.univ.filter (fun h => bad a h)).card := by
    intro a _
    have hdom : H.IsDominating
        ((P a ∪ Finset.univ.filter (fun h => bad a h) : Finset β) : Set β) := by
      intro h
      by_cases hb : bad a h
      · left
        rw [Finset.mem_coe, Finset.mem_union]
        right
        exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hb⟩
      · have hb' : h ∈ P a ∨ ∃ h' ∈ P a, H.Adj h h' := not_not.mp hb
        rcases hb' with hb' | ⟨h', hh', hadj⟩
        · left
          rw [Finset.mem_coe, Finset.mem_union]
          left
          exact hb'
        · right
          exact ⟨h', Finset.mem_coe.mpr (Finset.mem_union_left _ hh'), hadj⟩
    have h1 := dominationNumber_le_of_isDominating H _ hdom
    have h2 := Finset.card_union_le (P a) (Finset.univ.filter (fun h => bad a h))
    have h3 : (P a).card ≤ (Da a).card := Finset.card_image_le
    omega
  have sum1 : ∑ a ∈ A, (Da a).card = D.card :=
    (Finset.card_eq_sum_card_fiberwise (f := fun p : α × β => f p.1) (t := A)
      (fun p _ => hfA p.1)).symm
  have sum2 : ∑ a ∈ A, (Finset.univ.filter (fun h => bad a h)).card =
      ∑ h, (A.filter (fun a => bad a h)).card := by
    simp only [Finset.card_filter]
    exact Finset.sum_comm
  have sum3 : ∑ h, (Dh h).card = D.card :=
    (Finset.card_eq_sum_card_fiberwise (f := fun p : α × β => p.2) (t := Finset.univ)
      (fun p _ => Finset.mem_univ _)).symm
  have key : A.card * H.dominationNumber ≤ 2 * D.card := by
    calc A.card * H.dominationNumber = ∑ _a ∈ A, H.dominationNumber := by
          rw [Finset.sum_const, smul_eq_mul]
      _ ≤ ∑ a ∈ A, ((Da a).card + (Finset.univ.filter (fun h => bad a h)).card) :=
          Finset.sum_le_sum claim2
      _ = ∑ a ∈ A, (Da a).card + ∑ a ∈ A, (Finset.univ.filter (fun h => bad a h)).card :=
          Finset.sum_add_distrib
      _ ≤ D.card + ∑ h, (Dh h).card := by
          rw [sum1, sum2]
          exact Nat.add_le_add_left (Finset.sum_le_sum fun h _ => claim1 h) _
      _ = 2 * D.card := by rw [sum3]; ring
  rw [← hAcard, ← hDcard]
  exact key
