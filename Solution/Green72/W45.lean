import Solution.Green72.Witnesses

/-! Kernel check of the N = 45 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w45_ok : noThree w45 = true ∧ inGrid 45 w45 = true ∧ w45.Nodup ∧ w45.length = 2 * 45 := by
  decide +kernel

end Green72Data
