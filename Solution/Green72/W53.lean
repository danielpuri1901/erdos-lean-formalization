import Solution.Green72.Witnesses

/-! Kernel check of the N = 53 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w53_ok : noThree w53 = true ∧ inGrid 53 w53 = true ∧ w53.Nodup ∧ w53.length = 2 * 53 := by
  decide +kernel

end Green72Data
