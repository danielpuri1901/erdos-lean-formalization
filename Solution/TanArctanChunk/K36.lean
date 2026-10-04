import Solution.TanArctanRun
import Solution.TanArctanData.Z43751
import Solution.TanArctanData.Z45001

/-! Chunk 36: indices `43751 ≤ n ≤ 45000`. -/

namespace TanArctanSweep

lemma chunk36 : runFrom 1250 43751 z43751a z43751b = (true, z45001a, z45001b) := by decide +kernel

end TanArctanSweep
