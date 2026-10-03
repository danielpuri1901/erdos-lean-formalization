import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w60_ok : noThree w60 = true ∧ inGrid 60 w60 = true ∧ w60.Nodup ∧ w60.length = 2 * 60 := by
  decide +kernel

end Green72Data
