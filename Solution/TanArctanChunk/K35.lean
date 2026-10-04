import Solution.TanArctanRun
import Solution.TanArctanData.Z42501
import Solution.TanArctanData.Z43751

/-! Chunk 35: indices `42501 ≤ n ≤ 43750`. -/

namespace TanArctanSweep

lemma chunk35 : runFrom 1250 42501 z42501a z42501b = (true, z43751a, z43751b) := by decide +kernel

end TanArctanSweep
