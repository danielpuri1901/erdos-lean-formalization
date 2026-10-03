import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 33. -/

namespace Green72Data

theorem w33_ok : noThree w33 = true ∧ inGrid 33 w33 = true ∧ w33.Nodup ∧ w33.length = 2 * 33 := by
  decide +kernel

end Green72Data
