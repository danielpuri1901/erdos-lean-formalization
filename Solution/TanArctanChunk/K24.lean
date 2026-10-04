import Solution.TanArctanRun
import Solution.TanArctanData.Z28751
import Solution.TanArctanData.Z30001

/-! Chunk 24: indices `28751 ≤ n ≤ 30000`. -/

namespace TanArctanSweep

lemma chunk24 : runFrom 1250 28751 z28751a z28751b = (true, z30001a, z30001b) := by decide +kernel

end TanArctanSweep
