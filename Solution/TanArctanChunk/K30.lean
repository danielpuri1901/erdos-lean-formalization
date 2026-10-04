import Solution.TanArctanRun
import Solution.TanArctanData.Z36251
import Solution.TanArctanData.Z37501

/-! Chunk 30: indices `36251 ≤ n ≤ 37500`. -/

namespace TanArctanSweep

lemma chunk30 : runFrom 1250 36251 z36251a z36251b = (true, z37501a, z37501b) := by decide +kernel

end TanArctanSweep
