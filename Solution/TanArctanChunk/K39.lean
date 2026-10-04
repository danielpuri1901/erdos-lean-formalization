import Solution.TanArctanRun
import Solution.TanArctanData.Z47501
import Solution.TanArctanData.Z48751

/-! Chunk 39: indices `47501 ≤ n ≤ 48750`. -/

namespace TanArctanSweep

lemma chunk39 : runFrom 1250 47501 z47501a z47501b = (true, z48751a, z48751b) := by decide +kernel

end TanArctanSweep
