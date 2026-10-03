import Solution.Green72.Witnesses

/-! Kernel check of the N = 12 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w12_ok : noThree w12 = true ∧ inGrid 12 w12 = true ∧ w12.Nodup ∧ w12.length = 2 * 12 := by
  decide +kernel

end Green72Data
