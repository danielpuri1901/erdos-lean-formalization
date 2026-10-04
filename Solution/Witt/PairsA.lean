import Solution.Witt.Data

/-! Pairwise intersection checks for the witt24 octads, part A (generated). -/

namespace Witt

theorem rows_0_16 : rowsOK 0 16 = true := by decide +kernel

theorem rows_68_86 : rowsOK 68 18 = true := by decide +kernel

theorem rows_144_164 : rowsOK 144 20 = true := by decide +kernel

theorem rows_230_254 : rowsOK 230 24 = true := by decide +kernel

theorem rows_333_363 : rowsOK 333 30 = true := by decide +kernel

theorem rows_469_514 : rowsOK 469 45 = true := by decide +kernel

end Witt
