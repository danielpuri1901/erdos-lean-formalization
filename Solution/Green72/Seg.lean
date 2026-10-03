import Solution.Green72.Witnesses

/-! Segmented kernel checks for the green72 witnesses: `segOk l k` runs `noThree.pairsOk` for the
first `k` heads of `l`, so the check of `noThree wN` splits into small declarations. -/

namespace Green72Data

/-- Runs `noThree.pairsOk` for the first `k` heads of the list. -/
def segOk : List (Nat × Nat) → Nat → Bool
  | _, 0 => true
  | [], _ + 1 => true
  | p :: rest, k + 1 => noThree.pairsOk p rest && segOk rest k

theorem noThree_of_segOk : ∀ (l : List (Nat × Nat)) (k : Nat),
    segOk l k = true → noThree (l.drop k) = true → noThree l = true
  | _, 0, _, h => h
  | [], _ + 1, _, _ => rfl
  | p :: rest, k + 1, h1, h2 => by
    simp only [segOk, Bool.and_eq_true] at h1
    simp only [noThree, Bool.and_eq_true]
    exact ⟨h1.1, noThree_of_segOk rest k h1.2 h2⟩

/-- One chunk: the heads from index `a` to `a + k` are checked, the rest is checked later. -/
theorem chain {l : List (Nat × Nat)} {a k : Nat} (h1 : segOk (l.drop a) k = true)
    (h2 : noThree (l.drop (a + k)) = true) : noThree (l.drop a) = true :=
  noThree_of_segOk _ k h1 (by rw [List.drop_drop]; exact h2)

end Green72Data
