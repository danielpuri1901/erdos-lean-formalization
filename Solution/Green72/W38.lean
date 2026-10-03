import Solution.Green72.Witnesses

/-! Kernel check of the N = 38 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w38_ok : noThree w38 = true ∧ inGrid 38 w38 = true ∧ w38.Nodup ∧ w38.length = 2 * 38 := by
  decide +kernel

end Green72Data
