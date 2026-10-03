import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 29. -/

namespace Green72Data

theorem w29_ok : noThree w29 = true ∧ inGrid 29 w29 = true ∧ w29.Nodup ∧ w29.length = 2 * 29 := by
  decide +kernel

end Green72Data
