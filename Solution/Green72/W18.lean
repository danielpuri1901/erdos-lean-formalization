import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 18. -/

namespace Green72Data

theorem w18_ok : noThree w18 = true ∧ inGrid 18 w18 = true ∧ w18.Nodup ∧ w18.length = 2 * 18 := by
  decide +kernel

end Green72Data
