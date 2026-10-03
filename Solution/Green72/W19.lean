import Solution.Green72.Witnesses

/-! Kernel check of the green72 witness for N = 19. -/

namespace Green72Data

theorem w19_ok : noThree w19 = true ∧ inGrid 19 w19 = true ∧ w19.Nodup ∧ w19.length = 2 * 19 := by
  decide +kernel

end Green72Data
