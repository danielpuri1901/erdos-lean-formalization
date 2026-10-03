import Solution.Green72.Chunk

/-! Kernel check of the N = 50 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w50_c0 : prefOk ((w50.drop 0).take 4) ((w50.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c1 : prefOk ((w50.drop 4).take 4) ((w50.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c2 : prefOk ((w50.drop 8).take 4) ((w50.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c3 : prefOk ((w50.drop 12).take 4) ((w50.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c4 : prefOk ((w50.drop 16).take 4) ((w50.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c5 : prefOk ((w50.drop 20).take 4) ((w50.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c6 : prefOk ((w50.drop 24).take 4) ((w50.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c7 : prefOk ((w50.drop 28).take 4) ((w50.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c8 : prefOk ((w50.drop 32).take 4) ((w50.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c9 : prefOk ((w50.drop 36).take 4) ((w50.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c10 : prefOk ((w50.drop 40).take 4) ((w50.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c11 : prefOk ((w50.drop 44).take 4) ((w50.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c12 : prefOk ((w50.drop 48).take 4) ((w50.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c13 : prefOk ((w50.drop 52).take 4) ((w50.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c14 : prefOk ((w50.drop 56).take 4) ((w50.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c15 : prefOk ((w50.drop 60).take 4) ((w50.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c16 : prefOk ((w50.drop 64).take 4) ((w50.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c17 : prefOk ((w50.drop 68).take 4) ((w50.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c18 : prefOk ((w50.drop 72).take 4) ((w50.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c19 : prefOk ((w50.drop 76).take 4) ((w50.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c20 : prefOk ((w50.drop 80).take 4) ((w50.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c21 : prefOk ((w50.drop 84).take 4) ((w50.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c22 : prefOk ((w50.drop 88).take 4) ((w50.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c23 : prefOk ((w50.drop 92).take 4) ((w50.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c24 : prefOk ((w50.drop 96).take 4) ((w50.drop 96).drop 4) = true := by
  decide +kernel

theorem w50_noThree : noThree w50 = true := by
  have h : noThree (w50.drop 0) = true :=
    noThree_drop_step w50 0 4 w50_c0 <|
    noThree_drop_step w50 4 4 w50_c1 <|
    noThree_drop_step w50 8 4 w50_c2 <|
    noThree_drop_step w50 12 4 w50_c3 <|
    noThree_drop_step w50 16 4 w50_c4 <|
    noThree_drop_step w50 20 4 w50_c5 <|
    noThree_drop_step w50 24 4 w50_c6 <|
    noThree_drop_step w50 28 4 w50_c7 <|
    noThree_drop_step w50 32 4 w50_c8 <|
    noThree_drop_step w50 36 4 w50_c9 <|
    noThree_drop_step w50 40 4 w50_c10 <|
    noThree_drop_step w50 44 4 w50_c11 <|
    noThree_drop_step w50 48 4 w50_c12 <|
    noThree_drop_step w50 52 4 w50_c13 <|
    noThree_drop_step w50 56 4 w50_c14 <|
    noThree_drop_step w50 60 4 w50_c15 <|
    noThree_drop_step w50 64 4 w50_c16 <|
    noThree_drop_step w50 68 4 w50_c17 <|
    noThree_drop_step w50 72 4 w50_c18 <|
    noThree_drop_step w50 76 4 w50_c19 <|
    noThree_drop_step w50 80 4 w50_c20 <|
    noThree_drop_step w50 84 4 w50_c21 <|
    noThree_drop_step w50 88 4 w50_c22 <|
    noThree_drop_step w50 92 4 w50_c23 <|
    noThree_drop_step w50 96 4 w50_c24 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w50_ok : noThree w50 = true ∧ inGrid 50 w50 = true ∧ w50.Nodup ∧ w50.length = 2 * 50 :=
  ⟨w50_noThree, by decide +kernel⟩

end Green72Data
