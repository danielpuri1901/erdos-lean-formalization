import Solution.TanArctanRun
import Solution.TanArctanData.Z15001
import Solution.TanArctanData.Z16251

/-! Chunk 13: indices `15001 ≤ n ≤ 16250`. -/

namespace TanArctanSweep

lemma chunk13 : runFrom 1250 15001 z15001a z15001b = (true, z16251a, z16251b) := by decide +kernel

end TanArctanSweep
