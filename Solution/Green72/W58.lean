import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w58_ok : noThree w58 = true ∧ inGrid 58 w58 = true ∧ w58.Nodup ∧ w58.length = 2 * 58 := by
  decide +kernel

end Green72Data
