import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w47_ok : noThree w47 = true ∧ inGrid 47 w47 = true ∧ w47.Nodup ∧ w47.length = 2 * 47 := by
  decide +kernel

end Green72Data
