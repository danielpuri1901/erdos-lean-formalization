import FormalConjectures.Wikipedia.RamseyNumbers

/-! Upper bound R(3, 4) ≤ 9 via R(3, 3) ≤ 6 and a degree-parity argument, all inside one graph. -/

namespace R34

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

/-- Twice the number of edges inside `S`. -/
theorem even_sum_card_adj (S : Finset V) : Even (∑ v ∈ S, (S.filter (G.Adj v)).card) := by
  have key : ∑ v ∈ S, (S.filter (G.Adj v)).card
      = ((S ×ˢ S).filter (fun p => G.Adj p.1 p.2)).card := by
    rw [Finset.card_filter, Finset.sum_product]
    refine Finset.sum_congr rfl fun v _ => ?_
    rw [Finset.card_filter]
  rw [key, ← ZMod.natCast_eq_zero_iff_even, Finset.card_eq_sum_ones, Nat.cast_sum]
  refine Finset.sum_involution (fun p _ => p.swap) ?_ ?_ ?_ ?_
  · intro p _
    simp only [Nat.cast_one]
    decide
  · intro p hp _ h
    have hadj := (Finset.mem_filter.mp hp).2
    apply G.ne_of_adj hadj
    exact (congrArg Prod.snd h)
  · intro p hp
    simp only [Finset.mem_filter, Finset.mem_product] at hp ⊢
    exact ⟨⟨hp.1.2, hp.1.1⟩, hp.2.symm⟩
  · intro p _
    simp

theorem hasIndep_four_nine (hT : TriFree G) : HasIndep G 4 9 := by
  intro S hS
  rcases Nat.lt_or_ge 9 S.card with h10 | h9
  · exact step hT 3 6 (hasIndep_three_six hT) S (by omega)
  · have hS9 : S.card = 9 := by omega
    by_contra hno
    have hdeg : ∀ v ∈ S, (S.filter (G.Adj v)).card = 3 := by
      intro v hv
      have heq : S.filter (G.Adj v) = (S.erase v).filter (G.Adj v) := by
        ext w
        simp only [Finset.mem_filter, Finset.mem_erase]
        constructor
        · rintro ⟨hw, hvw⟩; exact ⟨⟨(G.ne_of_adj hvw).symm, hw⟩, hvw⟩
        · rintro ⟨⟨_, hw⟩, hvw⟩; exact ⟨hw, hvw⟩
      rw [heq]
      have hcard := card_nbrs_add (G := G) S hv
      have hN3 : ((S.erase v).filter (G.Adj v)).card ≤ 3 := by
        by_contra hN4
        obtain ⟨I, hIN, hIc⟩ := Finset.exists_subset_card_eq
          (show 4 ≤ ((S.erase v).filter (G.Adj v)).card by omega)
        obtain ⟨hIS, hI⟩ := indep_nbrs hT hIN
        exact hno ⟨I, hIS, hIc, hI⟩
      have hM5 : ((S.erase v).filter (fun w => ¬ G.Adj v w)).card ≤ 5 := by
        by_contra hM6
        obtain ⟨I, hIM, hIc, hI⟩ := hasIndep_three_six hT _
          (show 6 ≤ ((S.erase v).filter (fun w => ¬ G.Adj v w)).card by omega)
        obtain ⟨h1, h2, h3⟩ := indep_insert hv hIM hI
        exact hno ⟨insert v I, h1, by rw [h2, hIc], h3⟩
      omega
    have hsum : ∑ v ∈ S, (S.filter (G.Adj v)).card = 27 := by
      rw [Finset.sum_congr rfl hdeg]
      simp [hS9]
    have hev := even_sum_card_adj (G := G) S
    rw [hsum] at hev
    exact absurd hev (by decide)

theorem triFree_of_cliqueFree (h : G.CliqueFree 3) : TriFree G := by
  intro a b c hab hbc hac
  exact h {a, b, c} (SimpleGraph.is3Clique_triple_iff.mpr ⟨hab, hac, hbc⟩)

theorem isGraphRamsey_9 : RamseyNumbers.IsGraphRamsey 9 3 4 := by
  intro G ⟨h3, h4⟩
  classical
  obtain ⟨I, -, hIc, hI⟩ := hasIndep_four_nine (triFree_of_cliqueFree h3)
    (Finset.univ : Finset (Fin 9)) (by simp)
  apply h4 I
  refine ⟨?_, hIc⟩
  intro x hx y hy hxy
  rw [SimpleGraph.compl_adj]
  exact ⟨hxy, hI x hx y hy⟩

end R34
