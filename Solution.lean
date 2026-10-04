import FormalConjectures.Arxiv.«1609.08688».sIncreasingrTuples

/-! Solution for the sqtuples target. See `TASK.md` and `NOTES.md`.

For n = m^2 the triples `T m x y z = (m x + y + 1, m x + z + 1, m y + z + 1)`,
listed with (x, y, z) ∈ [0, m)^3 in lexicographic order, form a 2-increasing
sequence of length m^3 with entries in 1..m^2. -/

namespace SqTuples

open Arxiv.«1609.08688»

/-- The triple with index (x, y, z). -/
def T (m x y z : Nat) : Fin 3 → Nat := ![m * x + y + 1, m * x + z + 1, m * y + z + 1]

/-- The inner list for fixed x and y. -/
def Lz (m x y : Nat) : List (Fin 3 → Nat) := (List.range m).map fun z => T m x y z

/-- The middle list for fixed x. -/
def Ly (m x : Nat) : List (Fin 3 → Nat) := (List.range m).flatMap fun y => Lz m x y

/-- The whole sequence. -/
def L (m : Nat) : List (Fin 3 → Nat) := (List.range m).flatMap fun x => Ly m x

theorem length_L (m : Nat) : (L m).length = m ^ 3 := by
  sorry

theorem mem_L {m : Nat} {a : Fin 3 → Nat} (h : a ∈ L m) :
    ∃ x y z, x < m ∧ y < m ∧ z < m ∧ a = T m x y z := by
  sorry

theorem range_T {m x y z : Nat} (hx : x < m) (hy : y < m) (hz : z < m) :
    Set.range (T m x y z) ⊆ Set.Icc 1 (m ^ 2) := by
  sorry

theorem lt₂_x {m x y z x' y' z' : Nat} (hy : y < m) (hz : z < m) (hx : x < x') :
    lt₂ (T m x y z) (T m x' y' z') := by
  sorry

theorem lt₂_y {m x y z y' z' : Nat} (hz : z < m) (hy : y < y') :
    lt₂ (T m x y z) (T m x y' z') := by
  sorry

theorem lt₂_z {m x y z z' : Nat} (hz : z < z') :
    lt₂ (T m x y z) (T m x y z') := by
  sorry

theorem pairwise_L (m : Nat) : IsIncreasing₂ (L m) := by
  sorry

theorem bdd {n : Nat} (hn : 2 ≤ n) :
    BddAbove { List.length s | (s : List (Fin 3 → Nat))
      (_ : ∀ a ∈ s, Set.range a ⊆ Set.Icc 1 n) (_ : IsIncreasing₂ s) } := by
  sorry

end SqTuples

theorem increasing_triples_square : type_of% @Arxiv.«1609.08688».maximalLength_ge_of_isSquare := by
  sorry
