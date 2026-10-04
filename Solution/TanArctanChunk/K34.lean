import Solution.TanArctanRun
import Solution.TanArctanData.Z41251
import Solution.TanArctanData.Z42501

/-! Chunk 34: indices `41251 ≤ n ≤ 42500`. -/

namespace TanArctanSweep

lemma chunk34 : runFrom 1250 41251 z41251a z41251b = (true, z42501a, z42501b) := by decide +kernel

end TanArctanSweep
