import Solution.TanArctanRun
import Solution.TanArctanData.Z48751
import Solution.TanArctanData.Z50001

/-! Chunk 40: indices `48751 ≤ n ≤ 50000`. -/

namespace TanArctanSweep

lemma chunk40 : runFrom 1250 48751 z48751a z48751b = (true, z50001a, z50001b) := by decide +kernel

end TanArctanSweep
