import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w20_ok : noThree w20 = true ∧ inGrid 20 w20 = true ∧ w20.Nodup ∧ w20.length = 2 * 20 := by
  decide +kernel

end Green72Data
