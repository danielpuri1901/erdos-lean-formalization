import Solution.Green72.Witnesses

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w44_ok : noThree w44 = true ∧ inGrid 44 w44 = true ∧ w44.Nodup ∧ w44.length = 2 * 44 := by
  decide +kernel

end Green72Data
