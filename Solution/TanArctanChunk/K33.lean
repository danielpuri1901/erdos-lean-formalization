import Solution.TanArctanRun
import Solution.TanArctanData.Z40001
import Solution.TanArctanData.Z41251

/-! Chunk 33: indices `40001 ≤ n ≤ 41250`. -/

namespace TanArctanSweep

lemma chunk33 : runFrom 1250 40001 z40001a z40001b = (true, z41251a, z41251b) := by decide +kernel

end TanArctanSweep
