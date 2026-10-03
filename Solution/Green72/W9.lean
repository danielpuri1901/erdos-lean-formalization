import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 9. -/

namespace Green72Data

theorem w9_ok : noThree w9 = true ∧ inGrid 9 w9 = true ∧ w9.Nodup ∧ w9.length = 2 * 9 := by
  decide +kernel

end Green72Data
