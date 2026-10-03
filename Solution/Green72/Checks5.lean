import Solution.Green72.Checker

/-! Kernel checks of the Green 72 witnesses for N = 54 to 56. -/

namespace Green72Proof

set_option maxRecDepth 100000

theorem check54 : check 54 Green72Data.w54 = true := by decide +kernel

theorem check55 : check 55 Green72Data.w55 = true := by decide +kernel

theorem check56 : check 56 Green72Data.w56 = true := by decide +kernel

end Green72Proof
