import Solution.Green72.Checker

/-! Kernel checks of the Green 72 witnesses for N = 45 to 49. -/

namespace Green72Proof

set_option maxRecDepth 100000

theorem check45 : check 45 Green72Data.w45 = true := by decide +kernel

theorem check46 : check 46 Green72Data.w46 = true := by decide +kernel

theorem check47 : check 47 Green72Data.w47 = true := by decide +kernel

theorem check48 : check 48 Green72Data.w48 = true := by decide +kernel

theorem check49 : check 49 Green72Data.w49 = true := by decide +kernel

end Green72Proof
