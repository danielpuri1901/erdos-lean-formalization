import Solution.TanArctanRun
import Solution.TanArctanData.Z2501
import Solution.TanArctanData.Z3751

/-! Chunk 3: indices `2501 ≤ n ≤ 3750`. -/

namespace TanArctanSweep

lemma chunk3 : runFrom 1250 2501 z2501a z2501b = (true, z3751a, z3751b) := by decide +kernel

end TanArctanSweep
