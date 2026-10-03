import Solution.Green72.Witnesses

/-! Kernel check of the N = 6 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w6_ok : noThree w6 = true ∧ inGrid 6 w6 = true ∧ w6.Nodup ∧ w6.length = 2 * 6 := by
  decide +kernel

end Green72Data
