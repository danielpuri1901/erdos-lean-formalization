import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w39_ok : noThree w39 = true ∧ inGrid 39 w39 = true ∧ w39.Nodup ∧ w39.length = 2 * 39 := by
  decide +kernel

end Green72Data
