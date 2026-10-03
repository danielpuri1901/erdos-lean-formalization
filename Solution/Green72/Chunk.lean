import Solution.Green72.Witnesses

/-! Chunked form of `noThree`, so each kernel check stays small in memory. -/

namespace Green72Data

/-- `prefOk l1 l2` checks every triple whose first point lies in `l1` (triples read in list
order through `l1 ++ l2`). -/
def prefOk : List (Nat × Nat) → List (Nat × Nat) → Bool
  | [], _ => true
  | p :: ps, l2 => noThree.pairsOk p (ps ++ l2) && prefOk ps l2

theorem noThree_append (l1 l2 : List (Nat × Nat)) :
    noThree (l1 ++ l2) = (prefOk l1 l2 && noThree l2) := by
  induction l1 with
  | nil => simp [prefOk]
  | cons p ps ih => simp [noThree, prefOk, ih, Bool.and_assoc]

theorem noThree_drop_step (l : List (Nat × Nat)) (a k : Nat)
    (h1 : prefOk ((l.drop a).take k) ((l.drop a).drop k) = true)
    (h2 : noThree (l.drop (a + k)) = true) : noThree (l.drop a) = true := by
  rw [← List.take_append_drop k (l.drop a), noThree_append, h1, List.drop_drop]
  simpa [Nat.add_comm] using h2

end Green72Data
