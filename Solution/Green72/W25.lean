import Solution.Green72.Witnesses

/-! Kernel check of the N = 25 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w25_ok : noThree w25 = true ∧ inGrid 25 w25 = true ∧ w25.Nodup ∧ w25.length = 2 * 25 := by
  decide +kernel

end Green72Data
