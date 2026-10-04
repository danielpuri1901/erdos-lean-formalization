import Solution.TanArctanRun
import Solution.TanArctanData.Z16251
import Solution.TanArctanData.Z17501

/-! Chunk 14: indices `16251 ≤ n ≤ 17500`. -/

namespace TanArctanSweep

lemma chunk14 : runFrom 1250 16251 z16251a z16251b = (true, z17501a, z17501b) := by decide +kernel

end TanArctanSweep
