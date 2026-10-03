import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 57. -/

namespace Green72Data

theorem w57_ok : noThree w57 = true ∧ inGrid 57 w57 = true ∧ w57.Nodup ∧ w57.length = 2 * 57 := by
  decide +kernel

end Green72Data
