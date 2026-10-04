import Solution.TanArctanRun
import Solution.TanArctanData.Z12501
import Solution.TanArctanData.Z13751

/-! Chunk 11: indices `12501 ≤ n ≤ 13750`. -/

namespace TanArctanSweep

lemma chunk11 : runFrom 1250 12501 z12501a z12501b = (true, z13751a, z13751b) := by decide +kernel

end TanArctanSweep
