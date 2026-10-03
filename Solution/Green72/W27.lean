import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 27. -/

namespace Green72Data

theorem w27_ok : noThree w27 = true ∧ inGrid 27 w27 = true ∧ w27.Nodup ∧ w27.length = 2 * 27 := by
  decide +kernel

end Green72Data
