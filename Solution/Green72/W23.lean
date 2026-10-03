import Solution.Green72.Chunk

/-! Kernel check of the N = 23 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w23_c0 : prefOk ((w23.drop 0).take 4) ((w23.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c1 : prefOk ((w23.drop 4).take 4) ((w23.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c2 : prefOk ((w23.drop 8).take 4) ((w23.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c3 : prefOk ((w23.drop 12).take 4) ((w23.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c4 : prefOk ((w23.drop 16).take 4) ((w23.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c5 : prefOk ((w23.drop 20).take 4) ((w23.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c6 : prefOk ((w23.drop 24).take 4) ((w23.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c7 : prefOk ((w23.drop 28).take 4) ((w23.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c8 : prefOk ((w23.drop 32).take 4) ((w23.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c9 : prefOk ((w23.drop 36).take 4) ((w23.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c10 : prefOk ((w23.drop 40).take 4) ((w23.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c11 : prefOk ((w23.drop 44).take 4) ((w23.drop 44).drop 4) = true := by
  decide +kernel

theorem w23_noThree : noThree w23 = true := by
  have h : noThree (w23.drop 0) = true :=
    noThree_drop_step w23 0 4 w23_c0 <|
    noThree_drop_step w23 4 4 w23_c1 <|
    noThree_drop_step w23 8 4 w23_c2 <|
    noThree_drop_step w23 12 4 w23_c3 <|
    noThree_drop_step w23 16 4 w23_c4 <|
    noThree_drop_step w23 20 4 w23_c5 <|
    noThree_drop_step w23 24 4 w23_c6 <|
    noThree_drop_step w23 28 4 w23_c7 <|
    noThree_drop_step w23 32 4 w23_c8 <|
    noThree_drop_step w23 36 4 w23_c9 <|
    noThree_drop_step w23 40 4 w23_c10 <|
    noThree_drop_step w23 44 4 w23_c11 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w23_ok : noThree w23 = true ∧ inGrid 23 w23 = true ∧ w23.Nodup ∧ w23.length = 2 * 23 :=
  ⟨w23_noThree, by decide +kernel⟩

end Green72Data
