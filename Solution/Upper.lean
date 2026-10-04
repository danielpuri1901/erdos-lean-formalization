import FormalConjectures.Wikipedia.RamseyNumbers

/-! Upper bound R(3, 5) ≤ 14 via R(3, 3) ≤ 6 and R(3, 4) ≤ 9, all inside one graph. -/

namespace R35

open Finset

variable {V : Type*} [DecidableEq V] (G : SimpleGraph V) [DecidableRel G.Adj]

/-- `I` has no edge of `G`. -/
def Indep (I : Finset V) : Prop := ∀ x ∈ I, ∀ y ∈ I, ¬ G.Adj x y

/-- Every finset of size at least `m` contains an independent set of size `k`. -/
def HasIndep (k m : ℕ) : Prop :=
  ∀ S : Finset V, m ≤ S.card → ∃ I ⊆ S, I.card = k ∧ Indep G I

/-- Triangle-free, stated on vertices. -/
def TriFree : Prop := ∀ a b c : V, G.Adj a b → G.Adj b c → G.Adj a c → False

variable {G}

theorem step (hT : TriFree G) (k m : ℕ) (h : HasIndep G k m) :
    HasIndep G (k + 1) (m + k + 1) := by
  sorry

theorem hasIndep_one_one : HasIndep G 1 1 := by
  sorry

theorem hasIndep_three_six (hT : TriFree G) : HasIndep G 3 6 :=
  step hT 2 3 (step hT 1 1 hasIndep_one_one)

/-- Twice the number of edges inside `S`. -/
theorem even_sum_card_adj (S : Finset V) : Even (∑ v ∈ S, (S.filter (G.Adj v)).card) := by
  sorry

theorem hasIndep_four_nine (hT : TriFree G) : HasIndep G 4 9 := by
  sorry

theorem hasIndep_five_fourteen (hT : TriFree G) : HasIndep G 5 14 :=
  step hT 4 9 (hasIndep_four_nine hT)

theorem triFree_of_cliqueFree (h : G.CliqueFree 3) : TriFree G := by
  sorry

theorem isGraphRamsey_14 : RamseyNumbers.IsGraphRamsey 14 3 5 := by
  sorry

end R35
