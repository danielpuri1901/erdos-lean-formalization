import Solution.TanArctanRun
import Solution.TanArctanData.Z18751
import Solution.TanArctanData.Z20001

/-! Chunk 16: indices `18751 ≤ n ≤ 20000`. -/

namespace TanArctanSweep

lemma chunk16 : runFrom 1250 18751 z18751a z18751b = (true, z20001a, z20001b) := by decide +kernel

end TanArctanSweep
