import FormalConjectures.Wikipedia.SnakeInTheBox

/-! Solution for the snakeupper target. See `TASK.md` and `NOTES.md`.

Partial result: every snake in `Hypercube n` has fewer than `2^n` edges, so
`LongestSnakeInTheBox n ≤ 2^n - 1`; this gives the target for `n = 1`.
The case `n ≥ 2` is still open here (see `NOTES.md`). -/

namespace SnakeUpper

open SnakeInBox SimpleGraph

theorem snake_length_lt (n k : Nat) (S : (Hypercube n).Subgraph)
    (h : IsSnakeInGraphOfLength (Hypercube n) S k) : k < 2 ^ n := by
  obtain ⟨-, u, v, P, hP, -, rfl⟩ := h
  have := hP.length_lt
  simpa [Fintype.card_finset] using this

theorem snake_lengths_bddAbove (n : Nat) :
    BddAbove {k | ∃ S : (Hypercube n).Subgraph, IsSnakeInGraphOfLength (Hypercube n) S k} :=
  ⟨2 ^ n, fun _ ⟨S, hS⟩ => (snake_length_lt n _ S hS).le⟩

theorem longest_le_two_pow_sub_one (n : Nat) : LongestSnakeInTheBox n ≤ 2 ^ n - 1 :=
  csSup_le' fun _ ⟨S, hS⟩ => by have := snake_length_lt n _ S hS; omega

theorem snake_upper_bound_one : LongestSnakeInTheBox 1 ≤ 2 ^ (1 - 1) :=
  longest_le_two_pow_sub_one 1

end SnakeUpper

theorem snake_le_two_pow : type_of% @SnakeInBox.snake_upper_bound := by
  intro n hn
  rcases Nat.lt_or_ge n 2 with h | h
  · obtain rfl : n = 1 := by omega
    exact SnakeUpper.snake_upper_bound_one
  · -- Missing: the Danzer–Klee bound for `n ≥ 2` (see `NOTES.md`).
    sorry
