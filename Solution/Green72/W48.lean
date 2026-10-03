import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 48. -/

namespace Green72Data

theorem w48_ok : noThree w48 = true ∧ inGrid 48 w48 = true ∧ w48.Nodup ∧ w48.length = 2 * 48 := by
  decide +kernel

end Green72Data
