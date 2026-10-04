import Solution.Gap

/-!
# Reduction of the Catch-Up conjecture to the pairs conjecture

The pairs conjecture (`PairsConj`) and its `{1,2,3}` variant (`PairsConj3`) are stated
here; both are open (checked by computation only). The main theorem
`catchup_of_pairsConj` shows that together they imply the Catch-Up conjecture.
-/

namespace CatchUpDeep

open CatchUp

/-- `A` is a set of pair starts: no `0`, and no two starts adjacent, so the pairs `{a, a+1}` are disjoint. -/
def PairStarts (A : Finset ℕ) : Prop := 0 ∉ A ∧ ∀ a ∈ A, a + 1 ∉ A

/-- The union of the pairs `{a, a+1}`, `a ∈ A`. -/
def pairUnion (A : Finset ℕ) : Finset ℕ := A ∪ A.image (· + 1)

/-- The pairs conjecture (computed only, open). -/
def PairsConj : Prop :=
  ∀ A : Finset ℕ, PairStarts A →
    (Even A.card → gv (pairUnion A) 0 = .draw) ∧ (Odd A.card → gv (pairUnion A) 1 = .draw)

/-- The `{1,2,3}` variant (computed only, open). -/
def PairsConj3 : Prop :=
  ∀ A : Finset ℕ, (∀ a ∈ A, 4 ≤ a) → (∀ a ∈ A, a + 1 ∉ A) → Even A.card →
    gv ({1, 2, 3} ∪ pairUnion A) 0 = .draw

theorem even_tri_iff (N : ℕ) : Even (N * (N + 1) / 2) ↔ N % 4 = 0 ∨ N % 4 = 3 := by
  obtain ⟨q, r, hr, rfl⟩ : ∃ q r, r < 4 ∧ N = 4 * q + r :=
    ⟨N / 4, N % 4, Nat.mod_lt _ (by norm_num), (Nat.div_add_mod N 4).symm⟩
  rw [Nat.even_iff]
  interval_cases r
  · have h : (4 * q + 0) * (4 * q + 0 + 1) = 2 * (8 * (q * q) + 2 * q) := by ring
    rw [h, Nat.mul_div_cancel_left _ (by norm_num)]
    omega
  · have h : (4 * q + 1) * (4 * q + 1 + 1) = 2 * (8 * (q * q) + 6 * q + 1) := by ring
    rw [h, Nat.mul_div_cancel_left _ (by norm_num)]
    omega
  · have h : (4 * q + 2) * (4 * q + 2 + 1) = 2 * (8 * (q * q) + 10 * q + 3) := by ring
    rw [h, Nat.mul_div_cancel_left _ (by norm_num)]
    omega
  · have h : (4 * q + 3) * (4 * q + 3 + 1) = 2 * (8 * (q * q) + 14 * q + 6) := by ring
    rw [h, Nat.mul_div_cancel_left _ (by norm_num)]
    omega

theorem Icc_eq_pairUnion_of_mod4_eq_0 (m : ℕ) :
    Finset.Icc 1 (4 * m) = pairUnion ((Finset.range (2 * m)).image (fun i => 2 * i + 1)) := by
  ext x
  simp only [pairUnion, Finset.mem_Icc, Finset.mem_union, Finset.mem_image, Finset.mem_range]
  constructor
  · rintro ⟨h1, h2⟩
    rcases Nat.even_or_odd x with ⟨k, hk⟩ | ⟨k, hk⟩
    · right
      exact ⟨2 * (k - 1) + 1, ⟨k - 1, by omega, rfl⟩, by omega⟩
    · left
      exact ⟨k, by omega, by omega⟩
  · rintro (⟨i, hi, rfl⟩ | ⟨a, ⟨i, hi, rfl⟩, rfl⟩) <;> omega

theorem Icc_eq_three_union_pairUnion (m : ℕ) :
    Finset.Icc 1 (4 * m + 3) =
      {1, 2, 3} ∪ pairUnion ((Finset.range (2 * m)).image (fun i => 2 * i + 4)) := by
  ext x
  simp only [pairUnion, Finset.mem_Icc, Finset.mem_union, Finset.mem_image, Finset.mem_range,
    Finset.mem_insert, Finset.mem_singleton]
  constructor
  · rintro ⟨h1, h2⟩
    by_cases h3 : x ≤ 3
    · left; omega
    · right
      rcases Nat.even_or_odd x with ⟨k, hk⟩ | ⟨k, hk⟩
      · left
        exact ⟨k - 2, by omega, by omega⟩
      · right
        exact ⟨2 * (k - 2) + 4, ⟨k - 2, by omega, rfl⟩, by omega⟩
  · rintro (h | (⟨i, hi, rfl⟩ | ⟨a, ⟨i, hi, rfl⟩, rfl⟩)) <;> omega

/-- Main reduction: the pairs conjecture and its `{1,2,3}` variant imply the Catch-Up conjecture. -/
theorem catchup_of_pairsConj (hP : PairsConj) (hP3 : PairsConj3)
    (N : ℕ) (h_even : Even (N * (N + 1) / 2)) : value (Finset.Icc 1 N) = .draw := by
  rw [value_eq_gv]
  rcases (even_tri_iff N).mp h_even with h0 | h3
  · obtain ⟨m, rfl⟩ : ∃ m, N = 4 * m := ⟨N / 4, by omega⟩
    rw [Icc_eq_pairUnion_of_mod4_eq_0]
    have hinj : Function.Injective (fun i : ℕ => 2 * i + 1) := by
      intro a b h; simp only at h; omega
    apply (hP _ _).1
    · rw [Finset.card_image_of_injective _ hinj, Finset.card_range]
      exact ⟨m, by ring⟩
    · refine ⟨?_, ?_⟩
      · simp only [Finset.mem_image, Finset.mem_range, not_exists, not_and]
        intro i _; omega
      · intro a ha
        simp only [Finset.mem_image, Finset.mem_range] at ha ⊢
        obtain ⟨i, _, rfl⟩ := ha
        rintro ⟨j, _, hj⟩
        omega
  · obtain ⟨m, rfl⟩ : ∃ m, N = 4 * m + 3 := ⟨N / 4, by omega⟩
    rw [Icc_eq_three_union_pairUnion]
    have hinj : Function.Injective (fun i : ℕ => 2 * i + 4) := by
      intro a b h; simp only at h; omega
    apply hP3
    · intro a ha
      simp only [Finset.mem_image, Finset.mem_range] at ha
      obtain ⟨i, _, rfl⟩ := ha
      omega
    · intro a ha
      simp only [Finset.mem_image, Finset.mem_range] at ha ⊢
      obtain ⟨i, _, rfl⟩ := ha
      rintro ⟨j, _, hj⟩
      omega
    · rw [Finset.card_image_of_injective _ hinj, Finset.card_range]
      exact ⟨m, by ring⟩

end CatchUpDeep

#print axioms CatchUpDeep.catchup_of_pairsConj
