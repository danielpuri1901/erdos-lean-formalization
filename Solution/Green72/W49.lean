import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 49. -/

namespace Green72Data

theorem w49_ok : noThree w49 = true ∧ inGrid 49 w49 = true ∧ w49.Nodup ∧ w49.length = 2 * 49 := by
  decide +kernel

end Green72Data
