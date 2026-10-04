import Solution.TanArctanRun
import Solution.TanArctanData.Z37501
import Solution.TanArctanData.Z38751

/-! Chunk 31: indices `37501 ≤ n ≤ 38750`. -/

namespace TanArctanSweep

lemma chunk31 : runFrom 1250 37501 z37501a z37501b = (true, z38751a, z38751b) := by decide +kernel

end TanArctanSweep
