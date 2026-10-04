import Solution.TanArctanRun
import Solution.TanArctanData.Z20001
import Solution.TanArctanData.Z21251

/-! Chunk 17: indices `20001 ≤ n ≤ 21250`. -/

namespace TanArctanSweep

lemma chunk17 : runFrom 1250 20001 z20001a z20001b = (true, z21251a, z21251b) := by decide +kernel

end TanArctanSweep
