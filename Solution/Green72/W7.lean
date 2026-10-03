import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 7. -/

namespace Green72Data

theorem w7_ok : noThree w7 = true ∧ inGrid 7 w7 = true ∧ w7.Nodup ∧ w7.length = 2 * 7 := by
  decide +kernel

end Green72Data
