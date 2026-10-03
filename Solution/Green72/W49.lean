import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w49_ok : noThree w49 = true ∧ inGrid 49 w49 = true ∧ w49.Nodup ∧ w49.length = 2 * 49 := by
  decide +kernel

end Green72Data
