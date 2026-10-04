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
  sorry

/-- Non-adjacency for distinct vertices. -/
def nadj (a b : Fin 13) : Bool := a != b && !cadj a b

theorem c13_ind : ∀ a b : Fin 13, nadj a b = true → ∀ c : Fin 13, nadj a c = true →
    nadj b c = true → ∀ d : Fin 13, nadj a d = true → nadj b d = true → nadj c d = true →
    ∀ e : Fin 13, nadj a e = true → nadj b e = true → nadj c e = true → nadj d e = true →
    False := by
  sorry

theorem c13_cliqueFree : C13.CliqueFree 3 := by
  sorry

theorem c13_compl_cliqueFree : C13ᶜ.CliqueFree 5 := by
  sorry

theorem not_isGraphRamsey_13 : ¬ RamseyNumbers.IsGraphRamsey 13 3 5 :=
  fun h => h C13 ⟨c13_cliqueFree, c13_compl_cliqueFree⟩

end R35
