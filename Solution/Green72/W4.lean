import Solution.Green72.Witnesses

/-! Kernel check of the N = 4 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w4_ok : noThree w4 = true ∧ inGrid 4 w4 = true ∧ w4.Nodup ∧ w4.length = 2 * 4 := by
  decide +kernel

end Green72Data
