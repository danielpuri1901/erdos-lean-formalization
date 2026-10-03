import Solution.Green72.Chunk

/-! Kernel check of the N = 5 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w5_c0 : prefOk ((w5.drop 0).take 4) ((w5.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w5_c1 : prefOk ((w5.drop 4).take 4) ((w5.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w5_c2 : prefOk ((w5.drop 8).take 4) ((w5.drop 8).drop 4) = true := by
  decide +kernel

theorem w5_noThree : noThree w5 = true := by
  have h : noThree (w5.drop 0) = true :=
    noThree_drop_step w5 0 4 w5_c0 <|
    noThree_drop_step w5 4 4 w5_c1 <|
    noThree_drop_step w5 8 4 w5_c2 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w5_ok : noThree w5 = true ∧ inGrid 5 w5 = true ∧ w5.Nodup ∧ w5.length = 2 * 5 :=
  ⟨w5_noThree, by decide +kernel⟩

end Green72Data
