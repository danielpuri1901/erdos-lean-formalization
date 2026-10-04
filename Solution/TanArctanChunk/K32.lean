import Solution.TanArctanRun
import Solution.TanArctanData.Z38751
import Solution.TanArctanData.Z40001

/-! Chunk 32: indices `38751 ≤ n ≤ 40000`. -/

namespace TanArctanSweep

lemma chunk32 : runFrom 1250 38751 z38751a z38751b = (true, z40001a, z40001b) := by decide +kernel

end TanArctanSweep
