import Solution.Green72.Witnesses

/-! Kernel check of the N = 5 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w5_ok : noThree w5 = true ∧ inGrid 5 w5 = true ∧ w5.Nodup ∧ w5.length = 2 * 5 := by
  decide +kernel

end Green72Data
