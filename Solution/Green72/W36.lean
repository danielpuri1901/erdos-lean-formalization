import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 36. -/

namespace Green72Data

theorem w36_ok : noThree w36 = true ∧ inGrid 36 w36 = true ∧ w36.Nodup ∧ w36.length = 2 * 36 := by
  decide +kernel

end Green72Data
