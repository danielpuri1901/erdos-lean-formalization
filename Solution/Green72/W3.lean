import Solution.Green72.Witnesses

/-! Kernel check of the N = 3 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w3_ok : noThree w3 = true ∧ inGrid 3 w3 = true ∧ w3.Nodup ∧ w3.length = 2 * 3 := by
  decide +kernel

end Green72Data
