import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w42_ok : noThree w42 = true ∧ inGrid 42 w42 = true ∧ w42.Nodup ∧ w42.length = 2 * 42 := by
  decide +kernel

end Green72Data
