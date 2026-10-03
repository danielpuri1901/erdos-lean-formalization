import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 8. -/

namespace Green72Data

theorem w8_ok : noThree w8 = true ∧ inGrid 8 w8 = true ∧ w8.Nodup ∧ w8.length = 2 * 8 := by
  decide +kernel

end Green72Data
