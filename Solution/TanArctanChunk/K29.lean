import Solution.TanArctanRun
import Solution.TanArctanData.Z35001
import Solution.TanArctanData.Z36251

/-! Chunk 29: indices `35001 ≤ n ≤ 36250`. -/

namespace TanArctanSweep

lemma chunk29 : runFrom 1250 35001 z35001a z35001b = (true, z36251a, z36251b) := by decide +kernel

end TanArctanSweep
