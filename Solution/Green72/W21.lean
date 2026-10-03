import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 21. -/

namespace Green72Data

theorem w21_ok : noThree w21 = true ∧ inGrid 21 w21 = true ∧ w21.Nodup ∧ w21.length = 2 * 21 := by
  decide +kernel

end Green72Data
