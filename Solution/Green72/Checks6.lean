import Solution.Green72.Checker

/-! Kernel checks of the Green 72 witnesses for N = 57 to 58. -/

namespace Green72Proof

set_option maxRecDepth 100000

theorem check57 : check 57 Green72Data.w57 = true := by decide +kernel

theorem check58 : check 58 Green72Data.w58 = true := by decide +kernel

end Green72Proof
