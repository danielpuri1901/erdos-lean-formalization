import Solution.Green72.Witnesses

/-! Kernel check of the N = 26 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w26_ok : noThree w26 = true ∧ inGrid 26 w26 = true ∧ w26.Nodup ∧ w26.length = 2 * 26 := by
  decide +kernel

end Green72Data
