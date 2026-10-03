import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 53. -/

namespace Green72Data

theorem w53_ok : noThree w53 = true ∧ inGrid 53 w53 = true ∧ w53.Nodup ∧ w53.length = 2 * 53 := by
  decide +kernel

end Green72Data
