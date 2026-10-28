import FormalConjectures.Wikipedia.RamseyNumbers

/-! Lower bound for R(3, 3): the 5-cycle on `Fin 5`. -/

namespace R33

/-- Cycle adjacency on `Fin 5`: connection set {1, 4}. -/
def cadj (a b : Fin 5) : Bool :=
  let d := (b.val + 5 - a.val) % 5
  d == 1 || d == 4

theorem cadj_symm : ∀ a b : Fin 5, cadj a b = true → cadj b a = true := by decide

theorem cadj_irrefl : ∀ a : Fin 5, ¬ cadj a a = true := by decide

/-- The 5-cycle. -/
def C5 : SimpleGraph (Fin 5) where
  Adj a b := cadj a b = true
  symm := ⟨fun a b h => cadj_symm a b h⟩
  loopless := ⟨fun a h => cadj_irrefl a h⟩

instance : DecidableRel C5.Adj := fun a b => inferInstanceAs (Decidable (cadj a b = true))

theorem c5_tri : ∀ a b : Fin 5, cadj a b = true → ∀ c : Fin 5, cadj a c = true →
    cadj b c = true → False := by
  decide +kernel

/-- Non-adjacency for distinct vertices. -/
def nadj (a b : Fin 5) : Bool := a != b && !cadj a b

theorem c5_ind : ∀ a b : Fin 5, nadj a b = true → ∀ c : Fin 5, nadj a c = true →
    nadj b c = true → False := by
  decide +kernel

theorem c5_cliqueFree : C5.CliqueFree 3 := by
  rw [SimpleGraph.cliqueFree_iff]
  refine ⟨fun f => ?_⟩
  have h : ∀ i j : Fin 3, i ≠ j → cadj (f i) (f j) = true := fun i j hij =>
    f.toHom.map_adj (by simpa using hij)
  exact c5_tri (f 0) (f 1) (h 0 1 (by decide)) (f 2) (h 0 2 (by decide)) (h 1 2 (by decide))

theorem c5_compl_cliqueFree : C5ᶜ.CliqueFree 3 := by
  rw [SimpleGraph.cliqueFree_iff]
  refine ⟨fun f => ?_⟩
  have h : ∀ i j : Fin 3, i ≠ j → nadj (f i) (f j) = true := fun i j hij => by
    have hadj := f.toHom.map_adj (show (SimpleGraph.completeGraph (Fin 3)).Adj i j by simpa using hij)
    rw [SimpleGraph.compl_adj] at hadj
    have h1 : f i ≠ f j := hadj.1
    have h2 : ¬ cadj (f i) (f j) = true := hadj.2
    simp [nadj, h1, h2]
  exact c5_ind (f 0) (f 1) (h 0 1 (by decide)) (f 2) (h 0 2 (by decide)) (h 1 2 (by decide))

theorem not_isGraphRamsey_5 : ¬ RamseyNumbers.IsGraphRamsey 5 3 3 :=
  fun h => h C5 ⟨c5_cliqueFree, c5_compl_cliqueFree⟩

end R33
