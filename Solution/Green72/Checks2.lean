import Solution.Green72.Checker

/-! Kernel checks of the Green 72 witnesses for N = 37 to 44. -/

namespace Green72Proof

set_option maxRecDepth 100000

theorem check37 : check 37 Green72Data.w37 = true := by decide +kernel

theorem check38 : check 38 Green72Data.w38 = true := by decide +kernel

theorem check39 : check 39 Green72Data.w39 = true := by decide +kernel

theorem check40 : check 40 Green72Data.w40 = true := by decide +kernel

theorem check41 : check 41 Green72Data.w41 = true := by decide +kernel

theorem check42 : check 42 Green72Data.w42 = true := by decide +kernel

theorem check43 : check 43 Green72Data.w43 = true := by decide +kernel

theorem check44 : check 44 Green72Data.w44 = true := by decide +kernel

end Green72Proof
