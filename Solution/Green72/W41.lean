import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 41. -/

namespace Green72Data

theorem w41_ok : noThree w41 = true ∧ inGrid 41 w41 = true ∧ w41.Nodup ∧ w41.length = 2 * 41 := by
  decide +kernel

end Green72Data
