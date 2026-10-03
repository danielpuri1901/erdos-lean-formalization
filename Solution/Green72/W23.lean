import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 23. -/

namespace Green72Data

theorem w23_ok : noThree w23 = true ∧ inGrid 23 w23 = true ∧ w23.Nodup ∧ w23.length = 2 * 23 := by
  decide +kernel

end Green72Data
