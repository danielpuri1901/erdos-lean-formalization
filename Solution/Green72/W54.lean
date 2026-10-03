import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 54. -/

namespace Green72Data

theorem w54_ok : noThree w54 = true ∧ inGrid 54 w54 = true ∧ w54.Nodup ∧ w54.length = 2 * 54 := by
  decide +kernel

end Green72Data
