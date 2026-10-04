import Solution.TanArctanRun
import Solution.TanArctanData.Z31251
import Solution.TanArctanData.Z32501

/-! Chunk 26: indices `31251 ≤ n ≤ 32500`. -/

namespace TanArctanSweep

lemma chunk26 : runFrom 1250 31251 z31251a z31251b = (true, z32501a, z32501b) := by decide +kernel

end TanArctanSweep
