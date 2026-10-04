import Solution.TanArctanRun
import Solution.TanArctanData.Z33751
import Solution.TanArctanData.Z35001

/-! Chunk 28: indices `33751 ≤ n ≤ 35000`. -/

namespace TanArctanSweep

lemma chunk28 : runFrom 1250 33751 z33751a z33751b = (true, z35001a, z35001b) := by decide +kernel

end TanArctanSweep
