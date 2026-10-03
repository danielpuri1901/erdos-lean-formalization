import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 13. -/

namespace Green72Data

theorem w13_ok : noThree w13 = true ∧ inGrid 13 w13 = true ∧ w13.Nodup ∧ w13.length = 2 * 13 := by
  decide +kernel

end Green72Data
