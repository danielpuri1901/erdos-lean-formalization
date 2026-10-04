import FormalConjectures.OEIS.«112970»

/-! Solution for the a112970 target. See `TASK.md` and `NOTES.md`. -/

namespace A112970Sol

open OeisA112970

theorem a_zero : a 0 = 1 := by sorry

theorem a_odd (k : Nat) : a (2 * k + 1) = a k := by sorry

theorem a_even (k : Nat) : a (2 * k) = a k + (if k < 2 then 0 else a (k - 2)) := by sorry

theorem a_pow_sub_one (m : Nat) : a (2 ^ m - 1) = 1 := by sorry

theorem a_pow_sub_two (m : Nat) (hm : 1 ≤ m) : a (2 ^ m - 2) = (m + 1) / 2 := by sorry

theorem a_pow_succ (n : Nat) (hn : 1 ≤ n) : a (2 ^ (n + 1)) = a (2 ^ n) + a (2 ^ n - 2) := by sorry

theorem arith_step (n : Nat) : n ^ 2 / 4 + (n + 1) / 2 = (n + 1) ^ 2 / 4 := by sorry

theorem main (n : Nat) : a (2 ^ n) = n ^ 2 / 4 + 1 := by sorry

end A112970Sol

theorem a112970_power_of_two : type_of% @OeisA112970.conjecture1_value :=
  @A112970Sol.main
