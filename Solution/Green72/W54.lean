import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w54_ok : noThree w54 = true ∧ inGrid 54 w54 = true ∧ w54.Nodup ∧ w54.length = 2 * 54 := by
  decide +kernel

end Green72Data
