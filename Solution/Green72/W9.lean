import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w9_ok : noThree w9 = true ∧ inGrid 9 w9 = true ∧ w9.Nodup ∧ w9.length = 2 * 9 := by
  decide +kernel

end Green72Data
