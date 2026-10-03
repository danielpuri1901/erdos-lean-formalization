import Solution.Green72.Witnesses

/-! Kernel check of the N = 55 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w55_ok : noThree w55 = true ∧ inGrid 55 w55 = true ∧ w55.Nodup ∧ w55.length = 2 * 55 := by
  decide +kernel

end Green72Data
