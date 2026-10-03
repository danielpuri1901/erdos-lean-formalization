import Solution.Green72.Witnesses

/-! Kernel check of the N = 7 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w7_ok : noThree w7 = true ∧ inGrid 7 w7 = true ∧ w7.Nodup ∧ w7.length = 2 * 7 := by
  decide +kernel

end Green72Data
