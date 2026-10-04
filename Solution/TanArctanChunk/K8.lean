import Solution.TanArctanRun
import Solution.TanArctanData.Z8751
import Solution.TanArctanData.Z10001

/-! Chunk 8: indices `8751 ≤ n ≤ 10000`. -/

namespace TanArctanSweep

lemma chunk8 : runFrom 1250 8751 z8751a z8751b = (true, z10001a, z10001b) := by decide +kernel

end TanArctanSweep
