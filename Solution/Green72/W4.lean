import Solution.Green72.Chunk

/-! Kernel check of the N = 4 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w4_c0 : prefOk ((w4.drop 0).take 4) ((w4.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w4_c1 : prefOk ((w4.drop 4).take 4) ((w4.drop 4).drop 4) = true := by
  decide +kernel

theorem w4_noThree : noThree w4 = true := by
  have h : noThree (w4.drop 0) = true :=
    noThree_drop_step w4 0 4 w4_c0 <|
    noThree_drop_step w4 4 4 w4_c1 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w4_ok : noThree w4 = true ∧ inGrid 4 w4 = true ∧ w4.Nodup ∧ w4.length = 2 * 4 :=
  ⟨w4_noThree, by decide +kernel⟩

end Green72Data
