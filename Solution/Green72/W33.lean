import Solution.Green72.Witnesses

/-! Kernel check of the N = 33 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w33_ok : noThree w33 = true ∧ inGrid 33 w33 = true ∧ w33.Nodup ∧ w33.length = 2 * 33 := by
  decide +kernel

end Green72Data
