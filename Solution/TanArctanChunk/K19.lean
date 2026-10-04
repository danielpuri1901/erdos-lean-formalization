import Solution.TanArctanRun
import Solution.TanArctanData.Z22501
import Solution.TanArctanData.Z23751

/-! Chunk 19: indices `22501 ≤ n ≤ 23750`. -/

namespace TanArctanSweep

lemma chunk19 : runFrom 1250 22501 z22501a z22501b = (true, z23751a, z23751b) := by decide +kernel

end TanArctanSweep
