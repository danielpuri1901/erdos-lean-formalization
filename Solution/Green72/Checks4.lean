import Solution.Green72.Checker

/-! Kernel checks of the Green 72 witnesses for N = 50 to 53. -/

namespace Green72Proof

set_option maxRecDepth 100000

theorem check50 : check 50 Green72Data.w50 = true := by decide +kernel

theorem check51 : check 51 Green72Data.w51 = true := by decide +kernel

theorem check52 : check 52 Green72Data.w52 = true := by decide +kernel

theorem check53 : check 53 Green72Data.w53 = true := by decide +kernel

end Green72Proof
