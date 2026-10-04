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
  sorry

/-- Non-adjacency for distinct vertices. -/
def nadj (a b : Fin 8) : Bool := a != b && !cadj a b

theorem c8_ind : ∀ a b : Fin 8, nadj a b = true → ∀ c : Fin 8, nadj a c = true →
    nadj b c = true → ∀ d : Fin 8, nadj a d = true → nadj b d = true → nadj c d = true →
    False := by
  sorry

theorem c8_cliqueFree : C8.CliqueFree 3 := by
  sorry

theorem c8_compl_cliqueFree : C8ᶜ.CliqueFree 4 := by
  sorry

theorem not_isGraphRamsey_8 : ¬ RamseyNumbers.IsGraphRamsey 8 3 4 :=
  fun h => h C8 ⟨c8_cliqueFree, c8_compl_cliqueFree⟩

end R34
