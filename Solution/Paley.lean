import FormalConjectures.Wikipedia.RamseyNumbers

/-! The Paley graph on 17 vertices has no 4-clique and no independent set of size 4. -/

namespace Ramsey44

/-- `i` and `j` are adjacent when `j - i` is a nonzero square modulo 17;
the squares `{1, 2, 4, 8, 9, 13, 15, 16}` are the set bits of `107286`. -/
def padj (i j : Nat) : Bool :=
  (107286 >>> ((j + 17 - i) % 17)) % 2 == 1

/-- Bool check: no four pairwise adjacent vertices below 17. -/
def noK4 : Bool :=
  (List.range 17).all fun a => (List.range 17).all fun b => !padj a b ||
    (List.range 17).all fun c => !(padj a c && padj b c) ||
      (List.range 17).all fun d => !(padj a d && padj b d && padj c d)

/-- Bool check: no four pairwise distinct, pairwise nonadjacent vertices below 17. -/
def noI4 : Bool :=
  (List.range 17).all fun a => (List.range 17).all fun b => !(a != b && !padj a b) ||
    (List.range 17).all fun c => !(a != c && !padj a c && b != c && !padj b c) ||
      (List.range 17).all fun d =>
        !(a != d && !padj a d && b != d && !padj b d && c != d && !padj c d)

theorem noK4_eq : noK4 = true := by decide +kernel

theorem noI4_eq : noI4 = true := by decide +kernel

end Ramsey44

namespace Ramsey44

theorem noK4_sound : ∀ a < 17, ∀ b < 17, ∀ c < 17, ∀ d < 17, padj a b = true → padj a c = true →
    padj a d = true → padj b c = true → padj b d = true → padj c d = true → False := by
  intro a ha b hb c hc d hd h1 h2 h3 h4 h5 h6
  have h := List.all_eq_true.mp noK4_eq a (List.mem_range.mpr ha)
  have h := List.all_eq_true.mp h b (List.mem_range.mpr hb)
  simp only [h1, Bool.not_true, Bool.false_or] at h
  have h := List.all_eq_true.mp h c (List.mem_range.mpr hc)
  simp only [h2, h4, Bool.and_self, Bool.not_true, Bool.false_or] at h
  have h := List.all_eq_true.mp h d (List.mem_range.mpr hd)
  simp [h3, h5, h6] at h

theorem noI4_sound : ∀ a < 17, ∀ b < 17, ∀ c < 17, ∀ d < 17,
    (a ≠ b ∧ ¬ padj a b = true) → (a ≠ c ∧ ¬ padj a c = true) → (a ≠ d ∧ ¬ padj a d = true) →
    (b ≠ c ∧ ¬ padj b c = true) → (b ≠ d ∧ ¬ padj b d = true) → (c ≠ d ∧ ¬ padj c d = true) →
    False := by
  intro a ha b hb c hc d hd h1 h2 h3 h4 h5 h6
  have cv : ∀ x y : Nat, (x ≠ y ∧ ¬ padj x y = true) → (x != y) = true ∧ padj x y = false :=
    fun x y hxy => ⟨bne_iff_ne.mpr hxy.1, Bool.eq_false_iff.mpr hxy.2⟩
  obtain ⟨e1, p1⟩ := cv a b h1
  obtain ⟨e2, p2⟩ := cv a c h2
  obtain ⟨e3, p3⟩ := cv a d h3
  obtain ⟨e4, p4⟩ := cv b c h4
  obtain ⟨e5, p5⟩ := cv b d h5
  obtain ⟨e6, p6⟩ := cv c d h6
  have h := List.all_eq_true.mp noI4_eq a (List.mem_range.mpr ha)
  have h := List.all_eq_true.mp h b (List.mem_range.mpr hb)
  simp only [e1, p1, Bool.not_false, Bool.and_self, Bool.not_true, Bool.false_or] at h
  have h := List.all_eq_true.mp h c (List.mem_range.mpr hc)
  simp only [e2, p2, e4, p4, Bool.not_false, Bool.and_self, Bool.not_true, Bool.false_or] at h
  have h := List.all_eq_true.mp h d (List.mem_range.mpr hd)
  simp only [e3, p3, e5, p5, e6, p6, Bool.not_false, Bool.and_self, Bool.not_true] at h
  exact Bool.false_ne_true h

theorem padj_symm : ∀ i < 17, ∀ j < 17, padj i j = true → padj j i = true := by
  decide +kernel

theorem padj_irrefl (i : Nat) : padj i i = false := by
  unfold padj
  rw [Nat.add_sub_cancel_left]
  rfl

/-- The Paley graph on 17 vertices. -/
def paley : SimpleGraph (Fin 17) where
  Adj i j := padj i.val j.val = true
  symm := ⟨fun i j h => padj_symm _ i.isLt _ j.isLt h⟩
  loopless := ⟨fun i h => by rw [padj_irrefl] at h; exact Bool.false_ne_true h⟩

theorem paley_cliqueFree : paley.CliqueFree 4 := by
  by_contra hc
  obtain ⟨f⟩ := (SimpleGraph.not_cliqueFree_iff_top_isContained 4).mp hc
  have adj : ∀ i j : Fin 4, i ≠ j → padj (f i).val (f j).val = true :=
    fun i j hij => f.toHom.map_adj hij
  exact noK4_sound _ (f 0).isLt _ (f 1).isLt _ (f 2).isLt _ (f 3).isLt
    (adj 0 1 (by decide)) (adj 0 2 (by decide)) (adj 0 3 (by decide))
    (adj 1 2 (by decide)) (adj 1 3 (by decide)) (adj 2 3 (by decide))

theorem paley_compl_cliqueFree : paleyᶜ.CliqueFree 4 := by
  by_contra hc
  obtain ⟨f⟩ := (SimpleGraph.not_cliqueFree_iff_top_isContained 4).mp hc
  have adj : ∀ i j : Fin 4, i ≠ j →
      ((f i).val ≠ (f j).val ∧ ¬ padj (f i).val (f j).val = true) := fun i j hij => by
    have h := (SimpleGraph.compl_adj paley _ _).mp (f.toHom.map_adj hij)
    exact ⟨fun e => h.1 (Fin.ext e), h.2⟩
  exact noI4_sound _ (f 0).isLt _ (f 1).isLt _ (f 2).isLt _ (f 3).isLt
    (adj 0 1 (by decide)) (adj 0 2 (by decide)) (adj 0 3 (by decide))
    (adj 1 2 (by decide)) (adj 1 3 (by decide)) (adj 2 3 (by decide))

end Ramsey44
