import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 39. -/

namespace Green72Data

theorem w39_ok : noThree w39 = true ∧ inGrid 39 w39 = true ∧ w39.Nodup ∧ w39.length = 2 * 39 := by
  decide +kernel

end Green72Data
