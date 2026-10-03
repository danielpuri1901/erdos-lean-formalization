import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 34. -/

namespace Green72Data

theorem w34_ok : noThree w34 = true ∧ inGrid 34 w34 = true ∧ w34.Nodup ∧ w34.length = 2 * 34 := by
  decide +kernel

end Green72Data
