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
  sorry

theorem noI4_sound : ∀ a < 17, ∀ b < 17, ∀ c < 17, ∀ d < 17,
    (a ≠ b ∧ ¬ padj a b = true) → (a ≠ c ∧ ¬ padj a c = true) → (a ≠ d ∧ ¬ padj a d = true) →
    (b ≠ c ∧ ¬ padj b c = true) → (b ≠ d ∧ ¬ padj b d = true) → (c ≠ d ∧ ¬ padj c d = true) →
    False := by
  sorry

theorem padj_symm (i j : Nat) (h : padj i j = true) : padj j i = true := by
  sorry

theorem padj_irrefl (i : Nat) : padj i i = false := by
  sorry

/-- The Paley graph on 17 vertices. -/
def paley : SimpleGraph (Fin 17) where
  Adj i j := padj i.val j.val = true
  symm := ⟨fun i j h => padj_symm _ _ h⟩
  loopless := ⟨fun i h => by rw [padj_irrefl] at h; exact Bool.false_ne_true h⟩

theorem paley_cliqueFree : paley.CliqueFree 4 := by
  sorry

theorem paley_compl_cliqueFree : paleyᶜ.CliqueFree 4 := by
  sorry

end Ramsey44
