import Solution.TanArctanRun
import Solution.TanArctanData.Z5001
import Solution.TanArctanData.Z6251

/-! Chunk 5: indices `5001 ≤ n ≤ 6250`. -/

namespace TanArctanSweep

lemma chunk5 : runFrom 1250 5001 z5001a z5001b = (true, z6251a, z6251b) := by decide +kernel

end TanArctanSweep
