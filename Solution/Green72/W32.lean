import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 32. -/

namespace Green72Data

theorem w32_ok : noThree w32 = true ∧ inGrid 32 w32 = true ∧ w32.Nodup ∧ w32.length = 2 * 32 := by
  decide +kernel

end Green72Data
