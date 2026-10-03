import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w41_ok : noThree w41 = true ∧ inGrid 41 w41 = true ∧ w41.Nodup ∧ w41.length = 2 * 41 := by
  decide +kernel

end Green72Data
