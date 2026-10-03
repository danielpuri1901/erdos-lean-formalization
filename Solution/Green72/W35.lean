import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 35. -/

namespace Green72Data

theorem w35_ok : noThree w35 = true ∧ inGrid 35 w35 = true ∧ w35.Nodup ∧ w35.length = 2 * 35 := by
  decide +kernel

end Green72Data
