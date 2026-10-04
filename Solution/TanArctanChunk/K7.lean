import Solution.TanArctanRun
import Solution.TanArctanData.Z7501
import Solution.TanArctanData.Z8751

/-! Chunk 7: indices `7501 ≤ n ≤ 8750`. -/

namespace TanArctanSweep

lemma chunk7 : runFrom 1250 7501 z7501a z7501b = (true, z8751a, z8751b) := by decide +kernel

end TanArctanSweep
