import Solution.Green72.Witnesses

/-! Kernel check of the N = 34 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w34_ok : noThree w34 = true ∧ inGrid 34 w34 = true ∧ w34.Nodup ∧ w34.length = 2 * 34 := by
  decide +kernel

end Green72Data
