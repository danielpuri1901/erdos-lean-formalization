import Solution.TanArctanRun
import Solution.TanArctanData.Z45001
import Solution.TanArctanData.Z46251

/-! Chunk 37: indices `45001 ≤ n ≤ 46250`. -/

namespace TanArctanSweep

lemma chunk37 : runFrom 1250 45001 z45001a z45001b = (true, z46251a, z46251b) := by decide +kernel

end TanArctanSweep
