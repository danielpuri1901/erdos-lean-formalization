import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 50. -/

namespace Green72Data

theorem w50_ok : noThree w50 = true ∧ inGrid 50 w50 = true ∧ w50.Nodup ∧ w50.length = 2 * 50 := by
  decide +kernel

end Green72Data
