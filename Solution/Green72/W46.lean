import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 46. -/

namespace Green72Data

theorem w46_ok : noThree w46 = true ∧ inGrid 46 w46 = true ∧ w46.Nodup ∧ w46.length = 2 * 46 := by
  decide +kernel

end Green72Data
