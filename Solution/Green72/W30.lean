import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 30. -/

namespace Green72Data

theorem w30_ok : noThree w30 = true ∧ inGrid 30 w30 = true ∧ w30.Nodup ∧ w30.length = 2 * 30 := by
  decide +kernel

end Green72Data
