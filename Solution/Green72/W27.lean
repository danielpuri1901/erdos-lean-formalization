import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w27_ok : noThree w27 = true ∧ inGrid 27 w27 = true ∧ w27.Nodup ∧ w27.length = 2 * 27 := by
  decide +kernel

end Green72Data
