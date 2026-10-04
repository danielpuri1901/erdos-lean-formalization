import Solution.TanArctanRun
import Solution.TanArctanData.Z3751
import Solution.TanArctanData.Z5001

/-! Chunk 4: indices `3751 ≤ n ≤ 5000`. -/

namespace TanArctanSweep

lemma chunk4 : runFrom 1250 3751 z3751a z3751b = (true, z5001a, z5001b) := by decide +kernel

end TanArctanSweep
