import Solution.TanArctanRun
import Solution.TanArctanData.Z13751
import Solution.TanArctanData.Z15001

/-! Chunk 12: indices `13751 ≤ n ≤ 15000`. -/

namespace TanArctanSweep

lemma chunk12 : runFrom 1250 13751 z13751a z13751b = (true, z15001a, z15001b) := by decide +kernel

end TanArctanSweep
