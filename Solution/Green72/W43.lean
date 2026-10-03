import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 43. -/

namespace Green72Data

theorem w43_ok : noThree w43 = true ∧ inGrid 43 w43 = true ∧ w43.Nodup ∧ w43.length = 2 * 43 := by
  decide +kernel

end Green72Data
