import Solution.Green72.Witnesses

/-! Kernel check of the N = 29 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w29_ok : noThree w29 = true ∧ inGrid 29 w29 = true ∧ w29.Nodup ∧ w29.length = 2 * 29 := by
  decide +kernel

end Green72Data
