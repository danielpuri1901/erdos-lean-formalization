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
  simp [L, Ly, Lz, List.length_flatMap, List.map_const', List.sum_replicate]
  ring

theorem mem_L {m : Nat} {a : Fin 3 → Nat} (h : a ∈ L m) :
    ∃ x y z, x < m ∧ y < m ∧ z < m ∧ a = T m x y z := by
  simp only [L, Ly, Lz, List.mem_flatMap, List.mem_map, List.mem_range] at h
  obtain ⟨x, hx, y, hy, z, hz, rfl⟩ := h
  exact ⟨x, y, z, hx, hy, hz, rfl⟩

theorem range_T {m x y z : Nat} (hx : x < m) (hy : y < m) (hz : z < m) :
    Set.range (T m x y z) ⊆ Set.Icc 1 (m ^ 2) := by
  rintro _ ⟨i, rfl⟩
  have h1 : m * x + m ≤ m * m := by nlinarith
  have h2 : m * y + m ≤ m * m := by nlinarith
  fin_cases i <;> simp [T, sq] <;> omega

theorem lt₂_x {m x y z x' y' z' : Nat} (hy : y < m) (hz : z < m) (hx : x < x') :
    lt₂ (T m x y z) (T m x' y' z') := by
  have h1 : m * x + m ≤ m * x' := by nlinarith
  exact ⟨0, 1, by decide, by simp [T]; omega, by simp [T]; omega⟩

theorem lt₂_y {m x y z y' z' : Nat} (hz : z < m) (hy : y < y') :
    lt₂ (T m x y z) (T m x y' z') := by
  have h1 : m * y + m ≤ m * y' := by nlinarith
  exact ⟨0, 2, by decide, by simp [T]; omega, by simp [T]; omega⟩

theorem lt₂_z {m x y z z' : Nat} (hz : z < z') :
    lt₂ (T m x y z) (T m x y z') := by
  exact ⟨1, 2, by decide, by simp [T]; omega, by simp [T]; omega⟩

theorem pairwise_L (m : Nat) : IsIncreasing₂ (L m) := by
  unfold IsIncreasing₂ L
  rw [List.pairwise_flatMap]
  refine ⟨fun x hx => ?_, ?_⟩
  · unfold Ly
    rw [List.pairwise_flatMap]
    refine ⟨fun y hy => ?_, ?_⟩
    · unfold Lz
      rw [List.pairwise_map]
      exact (List.pairwise_lt_range (n := m)).imp fun h => lt₂_z h
    · refine (List.pairwise_lt_range (n := m)).imp_of_mem fun {y y'} _ _ hyy' => ?_
      intro a ha b hb
      simp only [Lz, List.mem_map, List.mem_range] at ha hb
      obtain ⟨z, hz, rfl⟩ := ha
      obtain ⟨z', hz', rfl⟩ := hb
      exact lt₂_y hz hyy'
  · refine (List.pairwise_lt_range (n := m)).imp_of_mem fun {x x'} _ _ hxx' => ?_
    intro a ha b hb
    simp only [Ly, Lz, List.mem_flatMap, List.mem_map, List.mem_range] at ha hb
    obtain ⟨y, hy, z, hz, rfl⟩ := ha
    obtain ⟨y', hy', z', hz', rfl⟩ := hb
    exact lt₂_x hy hz hxx'

theorem bdd {n : Nat} (hn : 2 ≤ n) :
    BddAbove { List.length s | (s : List (Fin 3 → Nat))
      (_ : ∀ a ∈ s, Set.range a ⊆ Set.Icc 1 n) (_ : IsIncreasing₂ s) } := by
  refine ⟨n ^ 2, ?_⟩
  rintro _ ⟨s, hs_range, hs_inc, rfl⟩
  by_contra hle
  have hs_length : n ^ 2 < s.length := Nat.lt_of_not_ge hle
  obtain ⟨i, j, hij, h0, h1⟩ := exists_pair_of_mem_Icc hn hs_range hs_length
  have hp : s.Pairwise lt₂ := hs_inc
  rcases lt_or_gt_of_ne hij with hij | hji
  · exact (not_lt₂_of_exists 0 1 zero_ne_one h0.ge h1.ge)
      (List.pairwise_iff_get.1 hp i j hij)
  · exact (not_lt₂_of_exists 0 1 zero_ne_one h0.le h1.le)
      (List.pairwise_iff_get.1 hp j i hji)

end SqTuples

theorem increasing_triples_square : type_of% @Arxiv.«1609.08688».maximalLength_ge_of_isSquare := by
  intro n h
  obtain ⟨m, rfl⟩ := h
  rw [Nat.sqrt_eq]
  rcases Nat.lt_or_ge m 2 with hm | hm
  · interval_cases m
    · simp
    · simp [Arxiv.«1609.08688».maximalLength_one]
  · have hn : 2 ≤ m * m := by nlinarith
    unfold Arxiv.«1609.08688».maximalLength
    refine le_csSup (SqTuples.bdd hn) ⟨SqTuples.L m, ?_, SqTuples.pairwise_L m, SqTuples.length_L m⟩
    intro a ha
    obtain ⟨x, y, z, hx, hy, hz, rfl⟩ := SqTuples.mem_L ha
    simpa [sq] using SqTuples.range_T hx hy hz
