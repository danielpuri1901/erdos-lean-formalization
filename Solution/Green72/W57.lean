import Solution.Green72.Witnesses

/-! Kernel check of the N = 57 witness for Green 72. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w57_ok : noThree w57 = true ∧ inGrid 57 w57 = true ∧ w57.Nodup ∧ w57.length = 2 * 57 := by
  decide +kernel

end Green72Data
