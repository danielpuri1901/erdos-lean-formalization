import Solution.Green72.Witnesses

/-! Kernel check of the N = 36 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w36_ok : noThree w36 = true ∧ inGrid 36 w36 = true ∧ w36.Nodup ∧ w36.length = 2 * 36 := by
  decide +kernel

end Green72Data
