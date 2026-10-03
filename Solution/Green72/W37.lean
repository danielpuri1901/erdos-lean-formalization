import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 37. -/

namespace Green72Data

theorem w37_ok : noThree w37 = true ∧ inGrid 37 w37 = true ∧ w37.Nodup ∧ w37.length = 2 * 37 := by
  decide +kernel

end Green72Data
