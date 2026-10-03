import Solution.Green72.Witnesses

/-! Kernel check of the N = 59 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w59_ok : noThree w59 = true ∧ inGrid 59 w59 = true ∧ w59.Nodup ∧ w59.length = 2 * 59 := by
  decide +kernel

end Green72Data
