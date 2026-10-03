import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w31_ok : noThree w31 = true ∧ inGrid 31 w31 = true ∧ w31.Nodup ∧ w31.length = 2 * 31 := by
  decide +kernel

end Green72Data
