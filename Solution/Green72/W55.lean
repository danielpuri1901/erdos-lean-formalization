import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 55. -/

namespace Green72Data

theorem w55_ok : noThree w55 = true ∧ inGrid 55 w55 = true ∧ w55.Nodup ∧ w55.length = 2 * 55 := by
  decide +kernel

end Green72Data
