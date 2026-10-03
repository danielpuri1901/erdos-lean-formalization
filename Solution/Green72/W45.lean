import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 45. -/

namespace Green72Data

theorem w45_ok : noThree w45 = true ∧ inGrid 45 w45 = true ∧ w45.Nodup ∧ w45.length = 2 * 45 := by
  decide +kernel

end Green72Data
