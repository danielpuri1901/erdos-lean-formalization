import FormalConjectures.GreensOpenProblems.«72»
import Solution.Green72.Witnesses

/-! Solution for the green72 target: one verified witness of 2N points per grid size N from 3 to 60
(`Solution/Green72/Witnesses.lean`), lifted to `Green72.NoKInLineFor 3 N` with the upper bound
`Green72.allowedSetSize_le` from formal-conjectures.
The lemma statements below are the plan from `TASKS.md`; each `sorry` is an open step. -/

open Green72Data

/-- The real points of a Nat witness. -/
noncomputable def toReal (p : Nat × Nat) : ℝ × ℝ := ((p.1 : ℝ), (p.2 : ℝ))

/-- Step 1: the Bool checker is sound for three distinct points of the list. -/
theorem cross_ne_of_noThree {l : List (Nat × Nat)} (h : noThree l = true) (hl : l.Nodup)
    {a b c : Nat × Nat} (ha : a ∈ l) (hb : b ∈ l) (hc : c ∈ l)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) : collinear3 a b c = false := by
  sorry

/-- Step 2: unequal cross terms mean three non-collinear real points. -/
theorem not_collinear_of_cross {a b c : Nat × Nat} (h : collinear3 a b c = false) :
    ¬ Collinear ℝ ({toReal a, toReal b, toReal c} : Set (ℝ × ℝ)) := by
  sorry

/-- Step 3: a verified witness list is an allowed set. -/
theorem allowedSet_of_witness {N : ℕ} {l : List (Nat × Nat)} (hl : l.Nodup)
    (hg : inGrid N l = true) (h3 : noThree l = true) :
    Green72.AllowedSet 3 N l.toFinset := by
  sorry

/-- Step 4: an allowed set of size 2N gives the equality. -/
theorem noKInLineFor_of_allowed {N : ℕ} {s : Finset (Nat × Nat)}
    (hs : Green72.AllowedSet 3 N s) (hc : s.card = 2 * N) : Green72.NoKInLineFor 3 N := by
  sorry

/-- Step 5: every grid size from 3 to 60 has its witness. -/
theorem green72_no_three_in_line_le {N : ℕ} (hN : 3 ≤ N) (hN' : N ≤ 60) :
    Green72.NoKInLineFor 3 N := by
  sorry
