import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 59. -/

namespace Green72Data

theorem w59_ok : noThree w59 = true ∧ inGrid 59 w59 = true ∧ w59.Nodup ∧ w59.length = 2 * 59 := by
  decide +kernel

end Green72Data
