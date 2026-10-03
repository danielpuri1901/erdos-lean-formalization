import Solution.Green72.Witnesses

/-! Kernel check of the N = 35 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w35_ok : noThree w35 = true ∧ inGrid 35 w35 = true ∧ w35.Nodup ∧ w35.length = 2 * 35 := by
  decide +kernel

end Green72Data
