import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 31. -/

namespace Green72Data

theorem w31_ok : noThree w31 = true ∧ inGrid 31 w31 = true ∧ w31.Nodup ∧ w31.length = 2 * 31 := by
  decide +kernel

end Green72Data
