import FormalConjectures.Wikipedia.RamseyNumbers

/-! Upper bound R(3, 3) ≤ 6, all inside one graph. -/

namespace R33

open Finset

set_option linter.unusedSectionVars false

variable {V : Type*} [DecidableEq V] (G : SimpleGraph V) [DecidableRel G.Adj]

/-- `I` has no edge of `G`. -/
def Indep (I : Finset V) : Prop := ∀ x ∈ I, ∀ y ∈ I, ¬ G.Adj x y

/-- Every finset of size at least `m` contains an independent set of size `k`. -/
def HasIndep (k m : ℕ) : Prop :=
  ∀ S : Finset V, m ≤ S.card → ∃ I ⊆ S, I.card = k ∧ Indep G I

/-- Triangle-free, stated on vertices. -/
def TriFree : Prop := ∀ a b c : V, G.Adj a b → G.Adj b c → G.Adj a c → False

variable {G}

/-- An independent set inside the non-neighbours of `v` extends by `v`. -/
theorem indep_insert {S I : Finset V} {v : V} (hv : v ∈ S)
    (hIM : I ⊆ (S.erase v).filter (fun w => ¬ G.Adj v w)) (hI : Indep G I) :
    insert v I ⊆ S ∧ (insert v I).card = I.card + 1 ∧ Indep G (insert v I) := by
  have hvI : v ∉ I := fun hvI => by
    have := (Finset.mem_filter.mp (hIM hvI)).1
    simp at this
  refine ⟨?_, Finset.card_insert_of_notMem hvI, ?_⟩
  · intro x hx
    rcases Finset.mem_insert.mp hx with rfl | hx
    · exact hv
    · exact (Finset.mem_erase.mp (Finset.mem_filter.mp (hIM hx)).1).2
  · intro x hx y hy
    rcases Finset.mem_insert.mp hx with rfl | hx' <;> rcases Finset.mem_insert.mp hy with rfl | hy'
    · exact G.irrefl
    · exact (Finset.mem_filter.mp (hIM hy')).2
    · intro hxy; exact (Finset.mem_filter.mp (hIM hx')).2 hxy.symm
    · exact hI x hx' y hy'

/-- In a triangle-free graph a set of neighbours of `v` is independent. -/
theorem indep_nbrs (hT : TriFree G) {S I : Finset V} {v : V}
    (hIN : I ⊆ (S.erase v).filter (G.Adj v)) : I ⊆ S ∧ Indep G I := by
  refine ⟨fun x hx => (Finset.mem_erase.mp (Finset.mem_filter.mp (hIN hx)).1).2, ?_⟩
  intro x hx y hy hxy
  exact hT v x y (Finset.mem_filter.mp (hIN hx)).2 hxy (Finset.mem_filter.mp (hIN hy)).2

theorem card_nbrs_add (S : Finset V) {v : V} (hv : v ∈ S) :
    ((S.erase v).filter (G.Adj v)).card + ((S.erase v).filter (fun w => ¬ G.Adj v w)).card
      = S.card - 1 := by
  rw [Finset.card_filter_add_card_filter_not, Finset.card_erase_of_mem hv]

theorem step (hT : TriFree G) (k m : ℕ) (h : HasIndep G k m) :
    HasIndep G (k + 1) (m + k + 1) := by
  intro S hS
  obtain ⟨v, hv⟩ : S.Nonempty := Finset.card_pos.mp (by omega)
  have hcard := card_nbrs_add (G := G) S hv
  by_cases hNk : k + 1 ≤ ((S.erase v).filter (G.Adj v)).card
  · obtain ⟨I, hIN, hIc⟩ := Finset.exists_subset_card_eq hNk
    obtain ⟨hIS, hI⟩ := indep_nbrs hT hIN
    exact ⟨I, hIS, hIc, hI⟩
  · obtain ⟨I, hIM, hIc, hI⟩ := h _ (show m ≤ ((S.erase v).filter (fun w => ¬ G.Adj v w)).card by
      omega)
    obtain ⟨h1, h2, h3⟩ := indep_insert hv hIM hI
    exact ⟨insert v I, h1, by rw [h2, hIc], h3⟩

theorem hasIndep_one_one : HasIndep G 1 1 := by
  intro S hS
  obtain ⟨v, hv⟩ : S.Nonempty := Finset.card_pos.mp (by omega)
  refine ⟨{v}, by simpa using hv, by simp, ?_⟩
  intro x hx y hy
  simp only [Finset.mem_singleton] at hx hy
  subst hx; subst hy; exact G.irrefl

theorem hasIndep_three_six (hT : TriFree G) : HasIndep G 3 6 :=
  step hT 2 3 (step hT 1 1 hasIndep_one_one)

theorem triFree_of_cliqueFree (h : G.CliqueFree 3) : TriFree G := by
  intro a b c hab hbc hac
  exact h {a, b, c} (SimpleGraph.is3Clique_triple_iff.mpr ⟨hab, hac, hbc⟩)

theorem isGraphRamsey_6 : RamseyNumbers.IsGraphRamsey 6 3 3 := by
  intro G ⟨h3, h3c⟩
  classical
  obtain ⟨I, -, hIc, hI⟩ := hasIndep_three_six (triFree_of_cliqueFree h3)
    (Finset.univ : Finset (Fin 6)) (by simp)
  apply h3c I
  refine ⟨?_, hIc⟩
  intro x hx y hy hxy
  rw [SimpleGraph.compl_adj]
  exact ⟨hxy, hI x hx y hy⟩

end R33
