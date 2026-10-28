import FormalConjectures.Wikipedia.RamseyNumbers

/-! Lower bound for R(3, 5): the circulant graph on `Fin 13` with connection set {1, 5, 8, 12}. -/

namespace R35

/-- Circulant adjacency on `Fin 13` with connection set {1, 5, 8, 12}. -/
def cadj (a b : Fin 13) : Bool :=
  let d := (b.val + 13 - a.val) % 13
  d == 1 || d == 5 || d == 8 || d == 12

theorem cadj_symm : ∀ a b : Fin 13, cadj a b = true → cadj b a = true := by decide

theorem cadj_irrefl : ∀ a : Fin 13, ¬ cadj a a = true := by decide

/-- The circulant graph. -/
def C13 : SimpleGraph (Fin 13) where
  Adj a b := cadj a b = true
  symm := ⟨fun a b h => cadj_symm a b h⟩
  loopless := ⟨fun a h => cadj_irrefl a h⟩

instance : DecidableRel C13.Adj := fun a b => inferInstanceAs (Decidable (cadj a b = true))

theorem c13_tri : ∀ a b : Fin 13, cadj a b = true → ∀ c : Fin 13, cadj a c = true →
    cadj b c = true → False := by
  decide +kernel

/-- Non-adjacency for distinct vertices. -/
def nadj (a b : Fin 13) : Bool := a != b && !cadj a b

theorem c13_ind : ∀ a b : Fin 13, nadj a b = true → ∀ c : Fin 13, nadj a c = true →
    nadj b c = true → ∀ d : Fin 13, nadj a d = true → nadj b d = true → nadj c d = true →
    ∀ e : Fin 13, nadj a e = true → nadj b e = true → nadj c e = true → nadj d e = true →
    False := by
  decide +kernel

theorem c13_cliqueFree : C13.CliqueFree 3 := by
  rw [SimpleGraph.cliqueFree_iff]
  refine ⟨fun f => ?_⟩
  have h : ∀ i j : Fin 3, i ≠ j → cadj (f i) (f j) = true := fun i j hij =>
    f.toHom.map_adj (by simpa using hij)
  exact c13_tri (f 0) (f 1) (h 0 1 (by decide)) (f 2) (h 0 2 (by decide)) (h 1 2 (by decide))

theorem c13_compl_cliqueFree : C13ᶜ.CliqueFree 5 := by
  rw [SimpleGraph.cliqueFree_iff]
  refine ⟨fun f => ?_⟩
  have h : ∀ i j : Fin 5, i ≠ j → nadj (f i) (f j) = true := fun i j hij => by
    have hadj := f.toHom.map_adj (show (SimpleGraph.completeGraph (Fin 5)).Adj i j by simpa using hij)
    rw [SimpleGraph.compl_adj] at hadj
    have h1 : f i ≠ f j := hadj.1
    have h2 : ¬ cadj (f i) (f j) = true := hadj.2
    simp [nadj, h1, h2]
  exact c13_ind (f 0) (f 1) (h 0 1 (by decide)) (f 2) (h 0 2 (by decide)) (h 1 2 (by decide))
    (f 3) (h 0 3 (by decide)) (h 1 3 (by decide)) (h 2 3 (by decide))
    (f 4) (h 0 4 (by decide)) (h 1 4 (by decide)) (h 2 4 (by decide)) (h 3 4 (by decide))

theorem not_isGraphRamsey_13 : ¬ RamseyNumbers.IsGraphRamsey 13 3 5 :=
  fun h => h C13 ⟨c13_cliqueFree, c13_compl_cliqueFree⟩

end R35
