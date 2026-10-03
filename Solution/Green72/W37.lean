import Solution.Green72.Witnesses

/-! Kernel check of the N = 37 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w37_ok : noThree w37 = true ∧ inGrid 37 w37 = true ∧ w37.Nodup ∧ w37.length = 2 * 37 := by
  decide +kernel

end Green72Data
