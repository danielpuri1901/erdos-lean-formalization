import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 14. -/

namespace Green72Data

theorem w14_ok : noThree w14 = true ∧ inGrid 14 w14 = true ∧ w14.Nodup ∧ w14.length = 2 * 14 := by
  decide +kernel

end Green72Data
