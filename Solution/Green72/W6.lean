import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 6. -/

namespace Green72Data

theorem w6_ok : noThree w6 = true ∧ inGrid 6 w6 = true ∧ w6.Nodup ∧ w6.length = 2 * 6 := by
  decide +kernel

end Green72Data
