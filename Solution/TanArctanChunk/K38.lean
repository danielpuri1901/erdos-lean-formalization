import Solution.TanArctanRun
import Solution.TanArctanData.Z46251
import Solution.TanArctanData.Z47501

/-! Chunk 38: indices `46251 ≤ n ≤ 47500`. -/

namespace TanArctanSweep

lemma chunk38 : runFrom 1250 46251 z46251a z46251b = (true, z47501a, z47501b) := by decide +kernel

end TanArctanSweep
