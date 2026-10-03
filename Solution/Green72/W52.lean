import Solution.Green72.Witnesses

/-! Kernel check of the N = 52 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w52_ok : noThree w52 = true ∧ inGrid 52 w52 = true ∧ w52.Nodup ∧ w52.length = 2 * 52 := by
  decide +kernel

end Green72Data
