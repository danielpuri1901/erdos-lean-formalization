import Solution.Green72.Witnesses

/-! Kernel check of the N = 30 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w30_ok : noThree w30 = true ∧ inGrid 30 w30 = true ∧ w30.Nodup ∧ w30.length = 2 * 30 := by
  decide +kernel

end Green72Data
