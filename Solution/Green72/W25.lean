import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 25. -/

namespace Green72Data

theorem w25_ok : noThree w25 = true ∧ inGrid 25 w25 = true ∧ w25.Nodup ∧ w25.length = 2 * 25 := by
  decide +kernel

end Green72Data
