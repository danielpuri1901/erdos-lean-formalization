import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 26. -/

namespace Green72Data

theorem w26_ok : noThree w26 = true ∧ inGrid 26 w26 = true ∧ w26.Nodup ∧ w26.length = 2 * 26 := by
  decide +kernel

end Green72Data
