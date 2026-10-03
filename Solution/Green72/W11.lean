import Solution.Green72.Witnesses

/-! Kernel check of the N = 11 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w11_ok : noThree w11 = true ∧ inGrid 11 w11 = true ∧ w11.Nodup ∧ w11.length = 2 * 11 := by
  decide +kernel

end Green72Data
