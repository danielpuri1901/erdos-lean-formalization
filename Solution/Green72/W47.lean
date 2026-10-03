import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 47. -/

namespace Green72Data

theorem w47_ok : noThree w47 = true ∧ inGrid 47 w47 = true ∧ w47.Nodup ∧ w47.length = 2 * 47 := by
  decide +kernel

end Green72Data
