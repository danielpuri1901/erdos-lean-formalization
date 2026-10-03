import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 28. -/

namespace Green72Data

theorem w28_ok : noThree w28 = true ∧ inGrid 28 w28 = true ∧ w28.Nodup ∧ w28.length = 2 * 28 := by
  decide +kernel

end Green72Data
