import Solution.Green72.Chunk

/-! Kernel check of the N = 10 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w10_c0 : prefOk ((w10.drop 0).take 4) ((w10.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w10_c1 : prefOk ((w10.drop 4).take 4) ((w10.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w10_c2 : prefOk ((w10.drop 8).take 4) ((w10.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w10_c3 : prefOk ((w10.drop 12).take 4) ((w10.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w10_c4 : prefOk ((w10.drop 16).take 4) ((w10.drop 16).drop 4) = true := by
  decide +kernel

theorem w10_noThree : noThree w10 = true := by
  have h : noThree (w10.drop 0) = true :=
    noThree_drop_step w10 0 4 w10_c0 <|
    noThree_drop_step w10 4 4 w10_c1 <|
    noThree_drop_step w10 8 4 w10_c2 <|
    noThree_drop_step w10 12 4 w10_c3 <|
    noThree_drop_step w10 16 4 w10_c4 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w10_ok : noThree w10 = true ∧ inGrid 10 w10 = true ∧ w10.Nodup ∧ w10.length = 2 * 10 :=
  ⟨w10_noThree, by decide +kernel⟩

end Green72Data
