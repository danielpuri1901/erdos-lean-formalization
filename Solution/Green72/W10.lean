import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 10. -/

namespace Green72Data

theorem w10_ok : noThree w10 = true ∧ inGrid 10 w10 = true ∧ w10.Nodup ∧ w10.length = 2 * 10 := by
  decide +kernel

end Green72Data
