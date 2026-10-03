import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w24_ok : noThree w24 = true ∧ inGrid 24 w24 = true ∧ w24.Nodup ∧ w24.length = 2 * 24 := by
  decide +kernel

end Green72Data
