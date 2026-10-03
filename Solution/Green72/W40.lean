import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 40. -/

namespace Green72Data

theorem w40_ok : noThree w40 = true ∧ inGrid 40 w40 = true ∧ w40.Nodup ∧ w40.length = 2 * 40 := by
  decide +kernel

end Green72Data
