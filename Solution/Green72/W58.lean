import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 58. -/

namespace Green72Data

theorem w58_ok : noThree w58 = true ∧ inGrid 58 w58 = true ∧ w58.Nodup ∧ w58.length = 2 * 58 := by
  decide +kernel

end Green72Data
