import Solution.TanArctanRun
import Solution.TanArctanData.Z17501
import Solution.TanArctanData.Z18751

/-! Chunk 15: indices `17501 ≤ n ≤ 18750`. -/

namespace TanArctanSweep

lemma chunk15 : runFrom 1250 17501 z17501a z17501b = (true, z18751a, z18751b) := by decide +kernel

end TanArctanSweep
