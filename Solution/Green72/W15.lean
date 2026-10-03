import Solution.Green72.Witnesses

/-! Kernel check of the N = 15 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w15_ok : noThree w15 = true ∧ inGrid 15 w15 = true ∧ w15.Nodup ∧ w15.length = 2 * 15 := by
  decide +kernel

end Green72Data
