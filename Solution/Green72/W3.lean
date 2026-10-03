import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 3. -/

namespace Green72Data

theorem w3_ok : noThree w3 = true ∧ inGrid 3 w3 = true ∧ w3.Nodup ∧ w3.length = 2 * 3 := by
  decide +kernel

end Green72Data
