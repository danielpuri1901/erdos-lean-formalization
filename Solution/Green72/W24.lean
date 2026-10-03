import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 24. -/

namespace Green72Data

theorem w24_ok : noThree w24 = true ∧ inGrid 24 w24 = true ∧ w24.Nodup ∧ w24.length = 2 * 24 := by
  decide +kernel

end Green72Data
