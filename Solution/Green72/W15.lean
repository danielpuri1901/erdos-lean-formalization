import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 15. -/

namespace Green72Data

theorem w15_ok : noThree w15 = true ∧ inGrid 15 w15 = true ∧ w15.Nodup ∧ w15.length = 2 * 15 := by
  decide +kernel

end Green72Data
