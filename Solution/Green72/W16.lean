import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 16. -/

namespace Green72Data

theorem w16_ok : noThree w16 = true ∧ inGrid 16 w16 = true ∧ w16.Nodup ∧ w16.length = 2 * 16 := by
  decide +kernel

end Green72Data
