import Solution.Green72.Witnesses

/-! Kernel check of the N = 17 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w17_ok : noThree w17 = true ∧ inGrid 17 w17 = true ∧ w17.Nodup ∧ w17.length = 2 * 17 := by
  decide +kernel

end Green72Data
