import FormalConjectures.Wikipedia.RamseyNumbers

/-! Lower bound for R(3, 4): the circulant graph on `Fin 8` with connection set {1, 4, 7}. -/

namespace R34

/-- Circulant adjacency on `Fin 8` with connection set {1, 4, 7}. -/
def cadj (a b : Fin 8) : Bool :=
  let d := (b.val + 8 - a.val) % 8
  d == 1 || d == 4 || d == 7

theorem cadj_symm : ∀ a b : Fin 8, cadj a b = true → cadj b a = true := by decide

theorem cadj_irrefl : ∀ a : Fin 8, ¬ cadj a a = true := by decide

/-- The circulant graph. -/
def C8 : SimpleGraph (Fin 8) where
  Adj a b := cadj a b = true
  symm := ⟨fun a b h => cadj_symm a b h⟩
  loopless := ⟨fun a h => cadj_irrefl a h⟩

instance : DecidableRel C8.Adj := fun a b => inferInstanceAs (Decidable (cadj a b = true))

theorem c8_tri : ∀ a b : Fin 8, cadj a b = true → ∀ c : Fin 8, cadj a c = true →
    cadj b c = true → False := by
  decide +kernel

/-- Non-adjacency for distinct vertices. -/
def nadj (a b : Fin 8) : Bool := a != b && !cadj a b

theorem c8_ind : ∀ a b : Fin 8, nadj a b = true → ∀ c : Fin 8, nadj a c = true →
    nadj b c = true → ∀ d : Fin 8, nadj a d = true → nadj b d = true → nadj c d = true →
    False := by
  decide +kernel

theorem c8_cliqueFree : C8.CliqueFree 3 := by
  rw [SimpleGraph.cliqueFree_iff]
  refine ⟨fun f => ?_⟩
  have h : ∀ i j : Fin 3, i ≠ j → cadj (f i) (f j) = true := fun i j hij =>
    f.toHom.map_adj (by simpa using hij)
  exact c8_tri (f 0) (f 1) (h 0 1 (by decide)) (f 2) (h 0 2 (by decide)) (h 1 2 (by decide))

theorem c8_compl_cliqueFree : C8ᶜ.CliqueFree 4 := by
  rw [SimpleGraph.cliqueFree_iff]
  refine ⟨fun f => ?_⟩
  have h : ∀ i j : Fin 4, i ≠ j → nadj (f i) (f j) = true := fun i j hij => by
    have hadj := f.toHom.map_adj (show (SimpleGraph.completeGraph (Fin 4)).Adj i j by simpa using hij)
    rw [SimpleGraph.compl_adj] at hadj
    have h1 : f i ≠ f j := hadj.1
    have h2 : ¬ cadj (f i) (f j) = true := hadj.2
    simp [nadj, h1, h2]
  exact c8_ind (f 0) (f 1) (h 0 1 (by decide)) (f 2) (h 0 2 (by decide)) (h 1 2 (by decide))
    (f 3) (h 0 3 (by decide)) (h 1 3 (by decide)) (h 2 3 (by decide))

theorem not_isGraphRamsey_8 : ¬ RamseyNumbers.IsGraphRamsey 8 3 4 :=
  fun h => h C8 ⟨c8_cliqueFree, c8_compl_cliqueFree⟩

end R34
