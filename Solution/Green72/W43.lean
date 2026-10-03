import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w43_ok : noThree w43 = true ∧ inGrid 43 w43 = true ∧ w43.Nodup ∧ w43.length = 2 * 43 := by
  decide +kernel

end Green72Data
