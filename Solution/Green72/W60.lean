import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 60. -/

namespace Green72Data

theorem w60_ok : noThree w60 = true ∧ inGrid 60 w60 = true ∧ w60.Nodup ∧ w60.length = 2 * 60 := by
  decide +kernel

end Green72Data
