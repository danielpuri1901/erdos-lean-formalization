import FormalConjectures.Mathoverflow.«75792»

/-! Solution for the intcomplexity target. See `TASK.md` and `NOTES.md`. -/

namespace IntComplexitySol

open Mathoverflow75792

theorem one_add_case (n a b : Nat) (hn : 1 ≤ n) (ha : 1 ≤ a) (hb : 1 ≤ b)
    (ih : n ^ 3 ≤ 3 ^ b) : (1 + n) ^ 3 ≤ 3 ^ (a + b) := by
  sorry

theorem add_case (m n a b : Nat) (hm : 1 ≤ m) (hn : 1 ≤ n) (ha : 1 ≤ a) (hb : 1 ≤ b)
    (ih₁ : m ^ 3 ≤ 3 ^ a) (ih₂ : n ^ 3 ≤ 3 ^ b) : (m + n) ^ 3 ≤ 3 ^ (a + b) := by
  sorry

theorem cube_le {m k : Nat} (h : Reachable m k) : m ^ 3 ≤ 3 ^ k := by
  sorry

end IntComplexitySol

theorem complexity_of_three_pow : type_of% @Mathoverflow75792.complexity_three_pow := by
  sorry
