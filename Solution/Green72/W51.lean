import Solution.Green72.Witnesses

/-! Kernel check of the N = 51 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w51_ok : noThree w51 = true ∧ inGrid 51 w51 = true ∧ w51.Nodup ∧ w51.length = 2 * 51 := by
  decide +kernel

end Green72Data
