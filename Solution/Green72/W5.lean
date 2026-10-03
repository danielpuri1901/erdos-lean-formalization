import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 5. -/

namespace Green72Data

theorem w5_ok : noThree w5 = true ∧ inGrid 5 w5 = true ∧ w5.Nodup ∧ w5.length = 2 * 5 := by
  decide +kernel

end Green72Data
