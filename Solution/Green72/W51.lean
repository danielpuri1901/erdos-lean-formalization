import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 51. -/

namespace Green72Data

theorem w51_ok : noThree w51 = true ∧ inGrid 51 w51 = true ∧ w51.Nodup ∧ w51.length = 2 * 51 := by
  decide +kernel

end Green72Data
