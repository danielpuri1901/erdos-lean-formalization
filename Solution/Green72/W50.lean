import Solution.Green72.Witnesses

/-! Kernel check of the N = 50 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w50_ok : noThree w50 = true ∧ inGrid 50 w50 = true ∧ w50.Nodup ∧ w50.length = 2 * 50 := by
  decide +kernel

end Green72Data
