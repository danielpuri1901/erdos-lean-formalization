import Solution.TanArctanRun
import Solution.TanArctanData.Z30001
import Solution.TanArctanData.Z31251

/-! Chunk 25: indices `30001 ≤ n ≤ 31250`. -/

namespace TanArctanSweep

lemma chunk25 : runFrom 1250 30001 z30001a z30001b = (true, z31251a, z31251b) := by decide +kernel

end TanArctanSweep
