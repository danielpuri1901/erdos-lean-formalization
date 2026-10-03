import Solution.Green72.Witnesses

/-! Chunked form of the `noThree` check, so that each kernel check of a witness stays small.
`prefixOk k l` runs the outer loop of `noThree` on the first `k` points of `l` only. -/

namespace Green72Data

/-- The first `k` steps of the outer loop of `noThree`. -/
def prefixOk : Nat → List (Nat × Nat) → Bool
  | 0, _ => true
  | _ + 1, [] => true
  | k + 1, p :: rest => noThree.pairsOk p rest && prefixOk k rest

theorem noThree_eq_prefixOk (k : Nat) (l : List (Nat × Nat)) :
    noThree l = (prefixOk k l && noThree (l.drop k)) := by
  induction k generalizing l with
  | zero => simp [prefixOk]
  | succ k ih =>
    cases l with
    | nil => simp [prefixOk, noThree]
    | cons p rest =>
      simp only [noThree, prefixOk, List.drop_succ_cons]
      rw [ih rest, Bool.and_assoc]

theorem noThree_of_chunks (k m : Nat) (l : List (Nat × Nat)) (hlen : l.length ≤ m * k)
    (h : ∀ j < m, prefixOk k (l.drop (j * k)) = true) : noThree l = true := by
  induction m generalizing l with
  | zero =>
    have : l = [] := List.eq_nil_of_length_eq_zero (by rw [Nat.zero_mul] at hlen; omega)
    subst this
    rfl
  | succ m ih =>
    rw [noThree_eq_prefixOk k l]
    have h0 : prefixOk k l = true := by simpa using h 0 (by omega)
    have hrest : noThree (l.drop k) = true := by
      apply ih
      · simp only [List.length_drop]
        rw [Nat.succ_mul] at hlen
        omega
      · intro j hj
        have := h (j + 1) (by omega)
        rw [List.drop_drop]
        rw [Nat.succ_mul] at this
        rw [Nat.add_comm] at this
        exact this
    rw [h0, hrest]
    rfl

end Green72Data
