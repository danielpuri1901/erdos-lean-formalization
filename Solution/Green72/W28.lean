import Solution.Green72.Witnesses

/-! Kernel check of the N = 28 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w28_ok : noThree w28 = true ∧ inGrid 28 w28 = true ∧ w28.Nodup ∧ w28.length = 2 * 28 := by
  decide +kernel

end Green72Data
