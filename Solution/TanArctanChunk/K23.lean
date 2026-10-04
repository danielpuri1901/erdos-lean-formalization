import Solution.TanArctanRun
import Solution.TanArctanData.Z27501
import Solution.TanArctanData.Z28751

/-! Chunk 23: indices `27501 ≤ n ≤ 28750`. -/

namespace TanArctanSweep

lemma chunk23 : runFrom 1250 27501 z27501a z27501b = (true, z28751a, z28751b) := by decide +kernel

end TanArctanSweep
