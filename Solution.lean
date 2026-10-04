import Solution.Pairs
import Solution.Cert11
import Solution.Cert12
import Solution.Gap
import Solution.Reduction
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

/-- If `best` returns `draw`, then `draw` occurs in the list. -/
theorem best_eq_draw {os : List Outcome} (h : Outcome.best os = .draw) : Outcome.draw ∈ os := by
  rw [best_eq_bestSpec, bestSpec] at h
  split_ifs at h with h1 h2
  exact h2

/-- `neg` fixes only `draw`. -/
theorem neg_eq_draw {o : Outcome} (h : o.neg = .draw) : o = .draw := by
  cases o <;> simp_all [Outcome.neg]

/-- A drawn position has an even total: score of both players plus what is left. -/
theorem valueAux_draw_even : ∀ (n : Nat) (R : Finset Nat), R.card = n →
    ∀ s t b, valueAux R s t b = .draw → Even (s + t + R.sum (fun x => x)) := by
  intro n
  induction n with
  | zero =>
    intro R hcard s t b h
    obtain rfl : R = ∅ := Finset.card_eq_zero.mp hcard
    rw [valueAux] at h
    simp only [if_true] at h
    split_ifs at h with h1 h2
    have : s = t := by omega
    subst this
    simp
  | succ n ih =>
    intro R hcard s t b h
    have hR : R ≠ ∅ := by rintro rfl; simp at hcard
    rw [valueAux] at h
    simp only [hR, if_false] at h
    by_cases hlt : s + R.sum (fun x => x) < t
    · rw [if_pos hlt] at h; cases h
    rw [if_neg hlt] at h
    have hmem := best_eq_draw h
    simp only [List.mem_map, Finset.mem_toList, Finset.mem_attach, true_and,
      Subtype.exists] at hmem
    obtain ⟨x, hx, hxd⟩ := hmem
    have hc : (R.erase x).card = n := by rw [Finset.card_erase_of_mem hx]; omega
    have hs : (R.erase x).sum (fun x => x) + x = R.sum (fun x => x) :=
      Finset.sum_erase_add R (fun x => x) hx
    split_ifs at hxd with hb hge
    · have := ih _ hc _ _ _ (neg_eq_draw hxd)
      rw [← hs]
      convert this using 1
      omega
    · have := ih _ hc _ _ _ (neg_eq_draw hxd)
      rw [← hs]
      convert this using 1
      omega
    · have := ih _ hc _ _ _ hxd
      rw [← hs]
      convert this using 1
      omega

/-- `∑_{x=1}^{N} x = N(N+1)/2`. -/
theorem sum_Icc_id (N : Nat) : (Finset.Icc 1 N).sum (fun x => x) = N * (N + 1) / 2 := by
  have h2 : (Finset.Icc 1 N).sum (fun x => x) * 2 = N * (N + 1) := by
    induction N with
    | zero => simp
    | succ k ih => rw [Finset.sum_Icc_succ_top (by omega), add_mul, ih]; ring
  exact (Nat.div_eq_of_eq_mul_left (by norm_num) h2.symm).symm

/-- Converse direction: when `N * (N + 1) / 2` is odd the game is not a draw. -/
theorem value_ne_draw_of_odd (N : Nat) (h_odd : ¬ Even (N * (N + 1) / 2)) :
    value (Finset.Icc 1 N) ≠ .draw := by
  intro h
  apply h_odd
  have := valueAux_draw_even _ _ rfl _ _ _ h
  simpa [sum_Icc_id] using this
/-- For `N ≤ 8`: the game on `{1, …, N}` is a draw exactly when `N * (N + 1) / 2` is even. -/
theorem catchup_draw_iff_le_8 (N : Nat) (hN : N ≤ 8) :
    value (Finset.Icc 1 N) = .draw ↔ Even (N * (N + 1) / 2) :=
  ⟨fun h => by_contra fun h' => value_ne_draw_of_odd N h' h, catchup_draw_le_8 N hN⟩

end CatchUpSweep

#print axioms CatchUpSweep.catchup_draw_le_8
#print axioms CatchUpSweep.valueAux_eq_valL
#print axioms CatchUpSweep.value_ne_draw_of_odd
#print axioms CatchUpSweep.catchup_draw_iff_le_8
