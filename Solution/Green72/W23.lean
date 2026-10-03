import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w23_ok : noThree w23 = true ∧ inGrid 23 w23 = true ∧ w23.Nodup ∧ w23.length = 2 * 23 := by
  decide +kernel

end Green72Data
