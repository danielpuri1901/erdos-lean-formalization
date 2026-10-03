import Solution.Green72.Witnesses

/-! Kernel check of the N = 21 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w21_ok : noThree w21 = true ∧ inGrid 21 w21 = true ∧ w21.Nodup ∧ w21.length = 2 * 21 := by
  decide +kernel

end Green72Data
