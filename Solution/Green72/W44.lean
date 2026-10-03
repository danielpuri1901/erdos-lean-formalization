import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 44. -/

namespace Green72Data

theorem w44_ok : noThree w44 = true ∧ inGrid 44 w44 = true ∧ w44.Nodup ∧ w44.length = 2 * 44 := by
  decide +kernel

end Green72Data
