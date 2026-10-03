import Solution.Green72.Chunk

/-! Kernel check of the N = 45 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w45_c0 : prefOk ((w45.drop 0).take 4) ((w45.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c1 : prefOk ((w45.drop 4).take 4) ((w45.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c2 : prefOk ((w45.drop 8).take 4) ((w45.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c3 : prefOk ((w45.drop 12).take 4) ((w45.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c4 : prefOk ((w45.drop 16).take 4) ((w45.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c5 : prefOk ((w45.drop 20).take 4) ((w45.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c6 : prefOk ((w45.drop 24).take 4) ((w45.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c7 : prefOk ((w45.drop 28).take 4) ((w45.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c8 : prefOk ((w45.drop 32).take 4) ((w45.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c9 : prefOk ((w45.drop 36).take 4) ((w45.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c10 : prefOk ((w45.drop 40).take 4) ((w45.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c11 : prefOk ((w45.drop 44).take 4) ((w45.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c12 : prefOk ((w45.drop 48).take 4) ((w45.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c13 : prefOk ((w45.drop 52).take 4) ((w45.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c14 : prefOk ((w45.drop 56).take 4) ((w45.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c15 : prefOk ((w45.drop 60).take 4) ((w45.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c16 : prefOk ((w45.drop 64).take 4) ((w45.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c17 : prefOk ((w45.drop 68).take 4) ((w45.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c18 : prefOk ((w45.drop 72).take 4) ((w45.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c19 : prefOk ((w45.drop 76).take 4) ((w45.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c20 : prefOk ((w45.drop 80).take 4) ((w45.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c21 : prefOk ((w45.drop 84).take 4) ((w45.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c22 : prefOk ((w45.drop 88).take 4) ((w45.drop 88).drop 4) = true := by
  decide +kernel

theorem w45_noThree : noThree w45 = true := by
  have h : noThree (w45.drop 0) = true :=
    noThree_drop_step w45 0 4 w45_c0 <|
    noThree_drop_step w45 4 4 w45_c1 <|
    noThree_drop_step w45 8 4 w45_c2 <|
    noThree_drop_step w45 12 4 w45_c3 <|
    noThree_drop_step w45 16 4 w45_c4 <|
    noThree_drop_step w45 20 4 w45_c5 <|
    noThree_drop_step w45 24 4 w45_c6 <|
    noThree_drop_step w45 28 4 w45_c7 <|
    noThree_drop_step w45 32 4 w45_c8 <|
    noThree_drop_step w45 36 4 w45_c9 <|
    noThree_drop_step w45 40 4 w45_c10 <|
    noThree_drop_step w45 44 4 w45_c11 <|
    noThree_drop_step w45 48 4 w45_c12 <|
    noThree_drop_step w45 52 4 w45_c13 <|
    noThree_drop_step w45 56 4 w45_c14 <|
    noThree_drop_step w45 60 4 w45_c15 <|
    noThree_drop_step w45 64 4 w45_c16 <|
    noThree_drop_step w45 68 4 w45_c17 <|
    noThree_drop_step w45 72 4 w45_c18 <|
    noThree_drop_step w45 76 4 w45_c19 <|
    noThree_drop_step w45 80 4 w45_c20 <|
    noThree_drop_step w45 84 4 w45_c21 <|
    noThree_drop_step w45 88 4 w45_c22 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w45_ok : noThree w45 = true ∧ inGrid 45 w45 = true ∧ w45.Nodup ∧ w45.length = 2 * 45 :=
  ⟨w45_noThree, by decide +kernel⟩

end Green72Data
