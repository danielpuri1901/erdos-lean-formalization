import Solution.Green72.Witnesses

/-! Kernel check of the N = 18 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w18_ok : noThree w18 = true ∧ inGrid 18 w18 = true ∧ w18.Nodup ∧ w18.length = 2 * 18 := by
  decide +kernel

end Green72Data
