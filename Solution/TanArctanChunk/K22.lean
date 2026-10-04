import Solution.TanArctanRun
import Solution.TanArctanData.Z26251
import Solution.TanArctanData.Z27501

/-! Chunk 22: indices `26251 ≤ n ≤ 27500`. -/

namespace TanArctanSweep

lemma chunk22 : runFrom 1250 26251 z26251a z26251b = (true, z27501a, z27501b) := by decide +kernel

end TanArctanSweep
