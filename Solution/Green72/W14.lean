import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w14_ok : noThree w14 = true ∧ inGrid 14 w14 = true ∧ w14.Nodup ∧ w14.length = 2 * 14 := by
  decide +kernel

end Green72Data
