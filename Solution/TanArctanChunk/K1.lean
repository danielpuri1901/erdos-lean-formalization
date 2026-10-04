import Solution.TanArctanRun
import Solution.TanArctanData.Z1251

/-! Chunk 1: indices `5 ≤ n ≤ 1250`. -/

namespace TanArctanSweep

lemma chunk1 : runFrom 1246 5 190 (-90) = (true, z1251a, z1251b) := by decide +kernel

end TanArctanSweep
