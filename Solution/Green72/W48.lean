import Solution.Green72.Witnesses

/-! Kernel check of the N = 48 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w48_ok : noThree w48 = true ∧ inGrid 48 w48 = true ∧ w48.Nodup ∧ w48.length = 2 * 48 := by
  decide +kernel

end Green72Data
