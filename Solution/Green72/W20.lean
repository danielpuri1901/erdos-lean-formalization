import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 20. -/

namespace Green72Data

theorem w20_ok : noThree w20 = true ∧ inGrid 20 w20 = true ∧ w20.Nodup ∧ w20.length = 2 * 20 := by
  decide +kernel

end Green72Data
