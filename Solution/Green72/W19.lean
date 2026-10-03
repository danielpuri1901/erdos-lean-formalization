import Solution.Green72.Witnesses

/-! Kernel check of the N = 19 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w19_ok : noThree w19 = true ∧ inGrid 19 w19 = true ∧ w19.Nodup ∧ w19.length = 2 * 19 := by
  decide +kernel

end Green72Data
