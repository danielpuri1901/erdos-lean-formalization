import Solution.TanArctanRun
import Solution.TanArctanData.Z10001
import Solution.TanArctanData.Z11251

/-! Chunk 9: indices `10001 ≤ n ≤ 11250`. -/

namespace TanArctanSweep

lemma chunk9 : runFrom 1250 10001 z10001a z10001b = (true, z11251a, z11251b) := by decide +kernel

end TanArctanSweep
