import Solution.Green72.Witnesses

/-! Kernel check of the N = 40 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w40_ok : noThree w40 = true ∧ inGrid 40 w40 = true ∧ w40.Nodup ∧ w40.length = 2 * 40 := by
  decide +kernel

end Green72Data
