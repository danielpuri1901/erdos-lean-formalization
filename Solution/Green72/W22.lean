import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 22. -/

namespace Green72Data

theorem w22_ok : noThree w22 = true ∧ inGrid 22 w22 = true ∧ w22.Nodup ∧ w22.length = 2 * 22 := by
  decide +kernel

end Green72Data
