import FormalConjectures.Arxiv.«2605.02731».DeanCycles

/-! Solution for the dean3 target. See `TASK.md` and `NOTES.md`.

Only a partial result is proved: the longest-path fan lemma `DeanThree.dean_three_fan`.
The main theorem `dean_three` is still open here (see `NOTES.md`, "What is missing"). -/

namespace DeanThree

open SimpleGraph

variable {V : Type} [Fintype V] [DecidableEq V] {G : SimpleGraph V}

/-- A longest path exists in a nonempty finite graph. -/
lemma exists_longest_path [Nonempty V] :
    ∃ (a b : V) (p : G.Walk a b), p.IsPath ∧
      ∀ (x y : V) (q : G.Walk x y), q.IsPath → q.length ≤ p.length := by
  sorry

/-- A neighbour of the first vertex of a longest path lies on the path. -/
lemma nbr_mem_support {a b : V} (p : G.Walk a b) (hp : p.IsPath)
    (hmax : ∀ (x y : V) (q : G.Walk x y), q.IsPath → q.length ≤ p.length)
    {w : V} (hw : G.Adj a w) : w ∈ p.support := by
  sorry

/-- The fan cycle `a → v_j → … → v_i → a` of a path `p` starting at `a`. -/
lemma fan_cycle {a b : V} (p : G.Walk a b) (hp : p.IsPath) {i j : ℕ} (hi : 1 ≤ i) (hij : i < j)
    (hj : j ≤ p.length) (hai : G.Adj a (p.getVert i)) (haj : G.Adj a (p.getVert j)) :
    j - i + 2 ∈ G.cycleLengths := by
  sorry

/-- Partial result towards Chen–Saito: either there is a cycle of length divisible by 3, or a
longest path whose first vertex `a` has all its (at least 3) neighbours on the path at indices
`i` with `i % 3 ≠ 2`, and any two neighbour indices `i < j` satisfy `(j - i) % 3 ≠ 1`. -/
theorem dean_three_fan [DecidableRel G.Adj] (hG : 3 ≤ G.minDegree) :
    (∃ m ∈ G.cycleLengths, 3 ∣ m) ∨
    ∃ (a b : V) (p : G.Walk a b), p.IsPath ∧
      (∀ (x y : V) (q : G.Walk x y), q.IsPath → q.length ≤ p.length) ∧ 3 ≤ G.degree a ∧
      (∀ w, G.Adj a w → ∃ i, 1 ≤ i ∧ i ≤ p.length ∧ p.getVert i = w ∧ i % 3 ≠ 2) ∧
      (∀ i j, i < j → j ≤ p.length → G.Adj a (p.getVert i) → G.Adj a (p.getVert j) →
        (j - i) % 3 ≠ 1) := by
  sorry

end DeanThree

theorem dean_three : type_of% @Arxiv.«2605.02731».dean_conjecture.variants.three := by
  sorry
