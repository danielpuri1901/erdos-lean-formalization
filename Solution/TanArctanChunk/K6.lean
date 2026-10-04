import Solution.TanArctanRun
import Solution.TanArctanData.Z6251
import Solution.TanArctanData.Z7501

/-! Chunk 6: indices `6251 ≤ n ≤ 7500`. -/

namespace TanArctanSweep

lemma chunk6 : runFrom 1250 6251 z6251a z6251b = (true, z7501a, z7501b) := by decide +kernel

end TanArctanSweep
