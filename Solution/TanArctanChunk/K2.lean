import Solution.TanArctanRun
import Solution.TanArctanData.Z1251
import Solution.TanArctanData.Z2501

/-! Chunk 2: indices `1251 ≤ n ≤ 2500`. -/

namespace TanArctanSweep

lemma chunk2 : runFrom 1250 1251 z1251a z1251b = (true, z2501a, z2501b) := by decide +kernel

end TanArctanSweep
