import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 4. -/

namespace Green72Data

theorem w4_ok : noThree w4 = true ∧ inGrid 4 w4 = true ∧ w4.Nodup ∧ w4.length = 2 * 4 := by
  decide +kernel

end Green72Data
