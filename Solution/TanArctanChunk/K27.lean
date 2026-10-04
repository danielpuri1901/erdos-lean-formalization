import Solution.TanArctanRun
import Solution.TanArctanData.Z32501
import Solution.TanArctanData.Z33751

/-! Chunk 27: indices `32501 ≤ n ≤ 33750`. -/

namespace TanArctanSweep

lemma chunk27 : runFrom 1250 32501 z32501a z32501b = (true, z33751a, z33751b) := by decide +kernel

end TanArctanSweep
