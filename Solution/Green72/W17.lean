import Solution.Green72.Chunk

/-! Kernel check of the N = 17 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w17_c0 : prefOk ((w17.drop 0).take 4) ((w17.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c1 : prefOk ((w17.drop 4).take 4) ((w17.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c2 : prefOk ((w17.drop 8).take 4) ((w17.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c3 : prefOk ((w17.drop 12).take 4) ((w17.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c4 : prefOk ((w17.drop 16).take 4) ((w17.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c5 : prefOk ((w17.drop 20).take 4) ((w17.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c6 : prefOk ((w17.drop 24).take 4) ((w17.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c7 : prefOk ((w17.drop 28).take 4) ((w17.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w17_c8 : prefOk ((w17.drop 32).take 4) ((w17.drop 32).drop 4) = true := by
  decide +kernel

theorem w17_noThree : noThree w17 = true := by
  have h : noThree (w17.drop 0) = true :=
    noThree_drop_step w17 0 4 w17_c0 <|
    noThree_drop_step w17 4 4 w17_c1 <|
    noThree_drop_step w17 8 4 w17_c2 <|
    noThree_drop_step w17 12 4 w17_c3 <|
    noThree_drop_step w17 16 4 w17_c4 <|
    noThree_drop_step w17 20 4 w17_c5 <|
    noThree_drop_step w17 24 4 w17_c6 <|
    noThree_drop_step w17 28 4 w17_c7 <|
    noThree_drop_step w17 32 4 w17_c8 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w17_ok : noThree w17 = true ∧ inGrid 17 w17 = true ∧ w17.Nodup ∧ w17.length = 2 * 17 :=
  ⟨w17_noThree, by decide +kernel⟩

end Green72Data
