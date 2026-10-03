import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 38. -/

namespace Green72Data

theorem w38_ok : noThree w38 = true ∧ inGrid 38 w38 = true ∧ w38.Nodup ∧ w38.length = 2 * 38 := by
  decide +kernel

end Green72Data
