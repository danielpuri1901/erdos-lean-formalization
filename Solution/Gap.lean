import FormalConjectures.Paper.CatchUpConjecture

/-!
# Gap reformulation of the Catch-Up evaluator

`gv R g` is the value of a non-first-move position with remaining set `R`, for the player
to move, who is behind by the gap `g`.
-/

namespace CatchUpDeep

open CatchUp

/-- The value of a position from the point of view of the player to move, who is `g` behind. -/
noncomputable def gv (R : Finset ℕ) (g : ℕ) : Outcome :=
  if R = ∅ then (if g = 0 then .draw else .loss)
  else if R.sum (fun x => x) < g then .loss
  else Outcome.best (R.attach.toList.map fun ⟨x, _⟩ =>
    if g ≤ x then (gv (R.erase x) (x - g)).neg else gv (R.erase x) (g - x))
termination_by R.card
decreasing_by all_goals simpa using Finset.card_erase_lt_of_mem ‹_›

theorem valueAux_eq_gv_aux : ∀ (n : ℕ) (R : Finset ℕ), R.card = n → ∀ s t, s ≤ t →
    valueAux R s t false = gv R (t - s) := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro R hcard s t hst
  rw [valueAux, gv]
  by_cases hR : R = ∅
  · simp only [hR, if_true]
    split_ifs <;> first | rfl | omega
  · simp only [hR, if_false]
    by_cases hlt : s + R.sum (fun x => x) < t
    · have : R.sum (fun x => x) < t - s := by omega
      simp [hlt, this]
    · have : ¬ R.sum (fun x => x) < t - s := by omega
      simp only [hlt, this, if_false]
      congr 1
      apply List.map_congr_left
      rintro ⟨x, hx⟩ _
      have hc : (R.erase x).card < n := by
        have := Finset.card_pos.mpr ⟨x, hx⟩
        rw [Finset.card_erase_of_mem hx]; omega
      simp only [Bool.false_eq_true, if_false]
      by_cases hge : s + x ≥ t
      · have h1 : t - s ≤ x := by omega
        rw [if_pos hge, if_pos h1, ih _ hc _ rfl _ _ hge]
        congr 2; omega
      · have h1 : ¬ t - s ≤ x := by omega
        rw [if_neg hge, if_neg h1, ih _ hc _ rfl _ _ (by omega)]
        congr 1; omega

theorem valueAux_eq_gv (R : Finset ℕ) (s t : ℕ) (hst : s ≤ t) :
    valueAux R s t false = gv R (t - s) :=
  valueAux_eq_gv_aux _ R rfl s t hst

theorem valueAux_first_eq_gv (R : Finset ℕ) (s : ℕ) :
    valueAux R s s true = gv R 0 := by
  rw [valueAux, gv]
  by_cases hR : R = ∅
  · simp [hR]
  · have : ¬ s + R.sum (fun x => x) < s := by omega
    simp only [hR, if_false, Nat.not_lt_zero, this]
    congr 1
    apply List.map_congr_left
    rintro ⟨x, hx⟩ _
    simp only [if_true, Nat.zero_le, Nat.sub_zero]
    rw [valueAux_eq_gv _ _ _ (by omega)]
    congr 2; omega

theorem value_eq_gv (S : Finset ℕ) : value S = gv S 0 :=
  valueAux_first_eq_gv S 0

/- Helpers -/

theorem gv_eq (R : Finset ℕ) (g : ℕ) : gv R g =
    (if R = ∅ then (if g = 0 then .draw else .loss)
    else if R.sum (fun x => x) < g then .loss
    else Outcome.best (R.attach.toList.map fun ⟨x, _⟩ =>
      if g ≤ x then (gv (R.erase x) (x - g)).neg else gv (R.erase x) (g - x))) := by
  rw [gv]

theorem gv_empty (g : ℕ) : gv ∅ g = if g = 0 then .draw else .loss := by
  rw [gv_eq]; simp

theorem gv_of_sum_lt {R : Finset ℕ} {g : ℕ} (hR : R ≠ ∅) (h : R.sum (fun x => x) < g) :
    gv R g = .loss := by
  rw [gv_eq, if_neg hR, if_pos h]

/-- The maximum of a list of outcomes (loss < draw < win), described by membership. -/
def bestMem (os : List Outcome) : Outcome :=
  if Outcome.win ∈ os then .win else if Outcome.draw ∈ os then .draw else .loss

theorem foldl_eq_bestMem (F : Outcome → Outcome → Outcome)
    (hF : ∀ a o, F a o = bestMem [a, o]) :
    ∀ (os : List Outcome) (a : Outcome), os.foldl F a = bestMem (a :: os) := by
  intro os
  induction os with
  | nil => intro a; cases a <;> simp [bestMem]
  | cons o os ih =>
    intro a
    rw [List.foldl_cons, ih, hF]
    cases a <;> cases o <;> simp [bestMem]

theorem best_eq_bestMem (os : List Outcome) : Outcome.best os = bestMem os := by
  unfold Outcome.best
  rw [foldl_eq_bestMem _ (by intro a o; cases a <;> cases o <;> rfl)]
  simp [bestMem]

theorem best_eq_win_iff (os : List Outcome) : Outcome.best os = .win ↔ Outcome.win ∈ os := by
  rw [best_eq_bestMem, bestMem]
  split_ifs <;> simp_all

theorem best_eq_loss_iff (os : List Outcome) :
    Outcome.best os = .loss ↔ (Outcome.win ∉ os ∧ Outcome.draw ∉ os) := by
  rw [best_eq_bestMem, bestMem]
  split_ifs <;> simp_all

theorem gv_eq_win_iff {R : Finset ℕ} {g : ℕ} (hR : R ≠ ∅) (h : ¬ R.sum (fun x => x) < g) :
    gv R g = .win ↔ ∃ x ∈ R,
      (if g ≤ x then (gv (R.erase x) (x - g)).neg else gv (R.erase x) (g - x)) = .win := by
  rw [gv_eq, if_neg hR, if_neg h, best_eq_win_iff]
  simp only [List.mem_map, Finset.mem_toList, Finset.mem_attach, true_and, Subtype.exists]
  constructor
  · rintro ⟨x, hx, hw⟩; exact ⟨x, hx, hw⟩
  · rintro ⟨x, hx, hw⟩; exact ⟨x, hx, hw⟩

end CatchUpDeep

#print axioms CatchUpDeep.value_eq_gv
#print axioms CatchUpDeep.valueAux_eq_gv
#print axioms CatchUpDeep.gv_eq_win_iff
#print axioms CatchUpDeep.best_eq_loss_iff
