import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 12. -/

namespace Green72Data

theorem w12_ok : noThree w12 = true ∧ inGrid 12 w12 = true ∧ w12.Nodup ∧ w12.length = 2 * 12 := by
  decide +kernel

end Green72Data
