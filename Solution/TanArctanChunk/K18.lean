import Solution.TanArctanRun
import Solution.TanArctanData.Z21251
import Solution.TanArctanData.Z22501

/-! Chunk 18: indices `21251 ≤ n ≤ 22500`. -/

namespace TanArctanSweep

lemma chunk18 : runFrom 1250 21251 z21251a z21251b = (true, z22501a, z22501b) := by decide +kernel

end TanArctanSweep
