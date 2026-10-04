import FormalConjectures.Paper.CatchUpConjecture

/-!
# Sweep `catchup`: small cases of the Catch-Up conjecture

`valueAux` is defined by well-founded recursion and uses the noncomputable `Finset.toList`,
so `decide` cannot evaluate it.  We prove that it agrees with a structurally recursive
version `valL` on lists (`valueAux_eq_valL`), and then evaluate `valL` with
`decide +kernel` for the small `N` with `N * (N + 1) / 2` even.
-/

namespace CatchUpSweep

open CatchUp

/-- The maximum of a list of outcomes (loss < draw < win), described by membership. -/
def bestSpec (os : List Outcome) : Outcome :=
  if Outcome.win ∈ os then .win else if Outcome.draw ∈ os then .draw else .loss

/-- A left fold whose step computes the maximum of two outcomes is the maximum. -/
theorem foldl_eq_bestSpec (F : Outcome → Outcome → Outcome)
    (hF : ∀ a o, F a o = bestSpec [a, o]) :
    ∀ (os : List Outcome) (a : Outcome), os.foldl F a = bestSpec (a :: os) := by
  intro os
  induction os with
  | nil => intro a; cases a <;> simp [bestSpec]
  | cons o os ih =>
    intro a
    rw [List.foldl_cons, ih, hF]
    cases a <;> cases o <;> simp [bestSpec]

/-- `Outcome.best` is the maximum. -/
theorem best_eq_bestSpec (os : List Outcome) : Outcome.best os = bestSpec os := by
  unfold Outcome.best
  rw [foldl_eq_bestSpec _ (by intro a o; cases a <;> cases o <;> rfl)]
  simp [bestSpec]

/-- `Outcome.best` depends only on which outcomes occur in the list. -/
theorem best_congr {l₁ l₂ : List Outcome} (h : ∀ o, o ∈ l₁ ↔ o ∈ l₂) :
    Outcome.best l₁ = Outcome.best l₂ := by
  simp only [best_eq_bestSpec, bestSpec, h]

/-- Structurally recursive copy of `valueAux` on lists; `n` is the length of the list. -/
def valL : Nat → List Nat → Nat → Nat → Bool → Outcome
  | 0, _, s, t, _ => if s > t then .win else if t > s then .loss else .draw
  | n + 1, l, s, t, b =>
    if l = [] then (if s > t then .win else if t > s then .loss else .draw)
    else if s + l.sum < t then .loss
    else Outcome.best (l.map fun x =>
      if b then (valL n (l.erase x) t (s + x) false).neg
      else if s + x ≥ t then (valL n (l.erase x) t (s + x) false).neg
      else valL n (l.erase x) (s + x) t false)

/-- Bridge: if `R` has the elements of the list `l` (of length `n`), `valueAux R = valL n l`. -/
theorem valueAux_eq_valL : ∀ (n : Nat) (l : List Nat) (R : Finset Nat), R.val = ↑l →
    l.length = n → ∀ s t b, valueAux R s t b = valL n l s t b := by
  intro n
  induction n with
  | zero =>
    intro l R hRl hlen s t b
    obtain rfl : l = [] := List.eq_nil_of_length_eq_zero hlen
    have hR : R = ∅ := Finset.val_eq_zero.mp (by simpa using hRl)
    subst hR
    rw [valueAux]
    simp [valL]
  | succ n ih =>
    intro l R hRl hlen s t b
    have hnil : l ≠ [] := by rintro rfl; simp at hlen
    have hR : R ≠ ∅ := by
      intro h
      apply hnil
      subst h
      simpa using hRl.symm
    have hsum : R.sum (fun x => x) = l.sum := by
      unfold Finset.sum
      rw [hRl]
      simp
    have hmem : ∀ x, x ∈ R ↔ x ∈ l := by
      intro x
      rw [Finset.mem_def, hRl, Multiset.mem_coe]
    have key : ∀ x ∈ l, ∀ s' t', valueAux (R.erase x) s' t' false = valL n (l.erase x) s' t' false := by
      intro x hx s' t'
      apply ih
      · rw [Finset.erase_val, hRl, Multiset.coe_erase]
      · rw [List.length_erase_of_mem hx]; omega
    rw [valueAux, valL]
    simp only [hR, hnil, if_false, hsum]
    by_cases hlt : s + l.sum < t
    · simp [hlt]
    · simp only [hlt, if_false]
      apply best_congr
      intro o
      simp only [List.mem_map, Finset.mem_toList, Finset.mem_attach, true_and, Subtype.exists]
      constructor
      · rintro ⟨x, hx, rfl⟩
        refine ⟨x, (hmem x).1 hx, ?_⟩
        simp [key x ((hmem x).1 hx)]
      · rintro ⟨x, hx, rfl⟩
        refine ⟨x, (hmem x).2 hx, ?_⟩
        simp [key x hx]

/-- `value (Icc 1 N)` computed by `valL`. -/
theorem value_Icc_eq_valL (N : Nat) :
    value (Finset.Icc 1 N) = valL N (List.range' 1 N) 0 0 true := by
  unfold value
  apply valueAux_eq_valL
  · rw [Nat.Icc_eq_range']
    simp
  · simp

/-- The Catch-Up conjecture holds for `N = 0, 3, 4, 7, 8`
(all `N ≤ 8` with `N * (N + 1) / 2` even). -/
theorem catchup_draw_0 : value (Finset.Icc 1 0) = .draw := by
  rw [value_Icc_eq_valL]; decide +kernel

theorem catchup_draw_3 : value (Finset.Icc 1 3) = .draw := by
  rw [value_Icc_eq_valL]; decide +kernel

theorem catchup_draw_4 : value (Finset.Icc 1 4) = .draw := by
  rw [value_Icc_eq_valL]; decide +kernel

theorem catchup_draw_7 : value (Finset.Icc 1 7) = .draw := by
  rw [value_Icc_eq_valL]; decide +kernel

theorem catchup_draw_8 : value (Finset.Icc 1 8) = .draw := by
  rw [value_Icc_eq_valL]; decide +kernel

/-- The conjecture for every `N ≤ 8`. -/
theorem catchup_draw_le_8 (N : Nat) (hN : N ≤ 8) (h_even : Even (N * (N + 1) / 2)) :
    value (Finset.Icc 1 N) = .draw := by
  interval_cases N
  · exact catchup_draw_0
  all_goals first
    | (exfalso; revert h_even; decide)
    | exact catchup_draw_3
    | exact catchup_draw_4
    | exact catchup_draw_7
    | exact catchup_draw_8

end CatchUpSweep

#print axioms CatchUpSweep.catchup_draw_le_8
#print axioms CatchUpSweep.valueAux_eq_valL
