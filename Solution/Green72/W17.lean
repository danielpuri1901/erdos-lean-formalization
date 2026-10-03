import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 17. -/

namespace Green72Data

theorem w17_ok : noThree w17 = true ∧ inGrid 17 w17 = true ∧ w17.Nodup ∧ w17.length = 2 * 17 := by
  decide +kernel

end Green72Data
