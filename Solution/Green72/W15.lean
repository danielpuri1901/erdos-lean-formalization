import Solution.Green72.Chunk

/-! Kernel check of the N = 15 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w15_c0 : prefOk ((w15.drop 0).take 4) ((w15.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w15_c1 : prefOk ((w15.drop 4).take 4) ((w15.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w15_c2 : prefOk ((w15.drop 8).take 4) ((w15.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w15_c3 : prefOk ((w15.drop 12).take 4) ((w15.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w15_c4 : prefOk ((w15.drop 16).take 4) ((w15.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w15_c5 : prefOk ((w15.drop 20).take 4) ((w15.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w15_c6 : prefOk ((w15.drop 24).take 4) ((w15.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w15_c7 : prefOk ((w15.drop 28).take 4) ((w15.drop 28).drop 4) = true := by
  decide +kernel

theorem w15_noThree : noThree w15 = true := by
  have h : noThree (w15.drop 0) = true :=
    noThree_drop_step w15 0 4 w15_c0 <|
    noThree_drop_step w15 4 4 w15_c1 <|
    noThree_drop_step w15 8 4 w15_c2 <|
    noThree_drop_step w15 12 4 w15_c3 <|
    noThree_drop_step w15 16 4 w15_c4 <|
    noThree_drop_step w15 20 4 w15_c5 <|
    noThree_drop_step w15 24 4 w15_c6 <|
    noThree_drop_step w15 28 4 w15_c7 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w15_ok : noThree w15 = true ∧ inGrid 15 w15 = true ∧ w15.Nodup ∧ w15.length = 2 * 15 :=
  ⟨w15_noThree, by decide +kernel⟩

end Green72Data
