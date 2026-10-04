import Solution.TanArctanRun
import Solution.TanArctanData.Z25001
import Solution.TanArctanData.Z26251

/-! Chunk 21: indices `25001 ≤ n ≤ 26250`. -/

namespace TanArctanSweep

lemma chunk21 : runFrom 1250 25001 z25001a z25001b = (true, z26251a, z26251b) := by decide +kernel

end TanArctanSweep
