import Solution.TanArctanRun
import Solution.TanArctanData.Z11251
import Solution.TanArctanData.Z12501

/-! Chunk 10: indices `11251 ≤ n ≤ 12500`. -/

namespace TanArctanSweep

lemma chunk10 : runFrom 1250 11251 z11251a z11251b = (true, z12501a, z12501b) := by decide +kernel

end TanArctanSweep
