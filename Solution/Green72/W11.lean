import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 11. -/

namespace Green72Data

theorem w11_ok : noThree w11 = true ∧ inGrid 11 w11 = true ∧ w11.Nodup ∧ w11.length = 2 * 11 := by
  decide +kernel

end Green72Data
