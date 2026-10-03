import Solution.Green72.Checker

/-! Kernel checks of the Green 72 witnesses for N = 59 to 60. -/

namespace Green72Proof

set_option maxRecDepth 100000

theorem check59 : check 59 Green72Data.w59 = true := by decide +kernel

theorem check60 : check 60 Green72Data.w60 = true := by decide +kernel

end Green72Proof
