import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 56. -/

namespace Green72Data

theorem w56_ok : noThree w56 = true ∧ inGrid 56 w56 = true ∧ w56.Nodup ∧ w56.length = 2 * 56 := by
  decide +kernel

end Green72Data
