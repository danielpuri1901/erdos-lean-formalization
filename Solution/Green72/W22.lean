import Solution.Green72.Witnesses

/-! Kernel check of the N = 22 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w22_ok : noThree w22 = true ∧ inGrid 22 w22 = true ∧ w22.Nodup ∧ w22.length = 2 * 22 := by
  decide +kernel

end Green72Data
