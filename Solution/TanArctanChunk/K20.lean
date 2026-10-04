import Solution.TanArctanRun
import Solution.TanArctanData.Z23751
import Solution.TanArctanData.Z25001

/-! Chunk 20: indices `23751 ≤ n ≤ 25000`. -/

namespace TanArctanSweep

lemma chunk20 : runFrom 1250 23751 z23751a z23751b = (true, z25001a, z25001b) := by decide +kernel

end TanArctanSweep
