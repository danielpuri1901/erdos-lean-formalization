import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w16_ok : noThree w16 = true ∧ inGrid 16 w16 = true ∧ w16.Nodup ∧ w16.length = 2 * 16 := by
  decide +kernel

end Green72Data
