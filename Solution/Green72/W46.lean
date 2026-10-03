import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w46_ok : noThree w46 = true ∧ inGrid 46 w46 = true ∧ w46.Nodup ∧ w46.length = 2 * 46 := by
  decide +kernel

end Green72Data
