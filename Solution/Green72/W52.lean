import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 52. -/

namespace Green72Data

theorem w52_ok : noThree w52 = true ∧ inGrid 52 w52 = true ∧ w52.Nodup ∧ w52.length = 2 * 52 := by
  decide +kernel

end Green72Data
