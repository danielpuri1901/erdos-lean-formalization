import Solution.Green72.Witnesses

/-! Kernel check of the N = 32 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w32_ok : noThree w32 = true ∧ inGrid 32 w32 = true ∧ w32.Nodup ∧ w32.length = 2 * 32 := by
  decide +kernel

end Green72Data
