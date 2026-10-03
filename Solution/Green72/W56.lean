import Solution.Green72.Witnesses

/-! Kernel check of the N = 56 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w56_ok : noThree w56 = true ∧ inGrid 56 w56 = true ∧ w56.Nodup ∧ w56.length = 2 * 56 := by
  decide +kernel

end Green72Data
