import Solution.Green72.Witnesses

/-! Kernel check of the N = 8 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w8_ok : noThree w8 = true ∧ inGrid 8 w8 = true ∧ w8.Nodup ∧ w8.length = 2 * 8 := by
  decide +kernel

end Green72Data
