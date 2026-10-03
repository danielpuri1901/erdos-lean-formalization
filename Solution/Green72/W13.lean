import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w13_ok : noThree w13 = true ∧ inGrid 13 w13 = true ∧ w13.Nodup ∧ w13.length = 2 * 13 := by
  decide +kernel

end Green72Data
