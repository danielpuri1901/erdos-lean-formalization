import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 42. -/

namespace Green72Data

theorem w42_ok : noThree w42 = true ∧ inGrid 42 w42 = true ∧ w42.Nodup ∧ w42.length = 2 * 42 := by
  decide +kernel

end Green72Data
