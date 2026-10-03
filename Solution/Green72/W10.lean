import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w10_ok : noThree w10 = true ∧ inGrid 10 w10 = true ∧ w10.Nodup ∧ w10.length = 2 * 10 := by
  decide +kernel

end Green72Data
