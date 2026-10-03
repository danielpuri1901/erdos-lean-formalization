import Solution.Green72.Chunk

/-! Kernel check of the N = 49 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w49_c0 : prefOk ((w49.drop 0).take 4) ((w49.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c1 : prefOk ((w49.drop 4).take 4) ((w49.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c2 : prefOk ((w49.drop 8).take 4) ((w49.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c3 : prefOk ((w49.drop 12).take 4) ((w49.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c4 : prefOk ((w49.drop 16).take 4) ((w49.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c5 : prefOk ((w49.drop 20).take 4) ((w49.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c6 : prefOk ((w49.drop 24).take 4) ((w49.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c7 : prefOk ((w49.drop 28).take 4) ((w49.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c8 : prefOk ((w49.drop 32).take 4) ((w49.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c9 : prefOk ((w49.drop 36).take 4) ((w49.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c10 : prefOk ((w49.drop 40).take 4) ((w49.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c11 : prefOk ((w49.drop 44).take 4) ((w49.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c12 : prefOk ((w49.drop 48).take 4) ((w49.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c13 : prefOk ((w49.drop 52).take 4) ((w49.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c14 : prefOk ((w49.drop 56).take 4) ((w49.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c15 : prefOk ((w49.drop 60).take 4) ((w49.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c16 : prefOk ((w49.drop 64).take 4) ((w49.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c17 : prefOk ((w49.drop 68).take 4) ((w49.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c18 : prefOk ((w49.drop 72).take 4) ((w49.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c19 : prefOk ((w49.drop 76).take 4) ((w49.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c20 : prefOk ((w49.drop 80).take 4) ((w49.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c21 : prefOk ((w49.drop 84).take 4) ((w49.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c22 : prefOk ((w49.drop 88).take 4) ((w49.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c23 : prefOk ((w49.drop 92).take 4) ((w49.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c24 : prefOk ((w49.drop 96).take 4) ((w49.drop 96).drop 4) = true := by
  decide +kernel

theorem w49_noThree : noThree w49 = true := by
  have h : noThree (w49.drop 0) = true :=
    noThree_drop_step w49 0 4 w49_c0 <|
    noThree_drop_step w49 4 4 w49_c1 <|
    noThree_drop_step w49 8 4 w49_c2 <|
    noThree_drop_step w49 12 4 w49_c3 <|
    noThree_drop_step w49 16 4 w49_c4 <|
    noThree_drop_step w49 20 4 w49_c5 <|
    noThree_drop_step w49 24 4 w49_c6 <|
    noThree_drop_step w49 28 4 w49_c7 <|
    noThree_drop_step w49 32 4 w49_c8 <|
    noThree_drop_step w49 36 4 w49_c9 <|
    noThree_drop_step w49 40 4 w49_c10 <|
    noThree_drop_step w49 44 4 w49_c11 <|
    noThree_drop_step w49 48 4 w49_c12 <|
    noThree_drop_step w49 52 4 w49_c13 <|
    noThree_drop_step w49 56 4 w49_c14 <|
    noThree_drop_step w49 60 4 w49_c15 <|
    noThree_drop_step w49 64 4 w49_c16 <|
    noThree_drop_step w49 68 4 w49_c17 <|
    noThree_drop_step w49 72 4 w49_c18 <|
    noThree_drop_step w49 76 4 w49_c19 <|
    noThree_drop_step w49 80 4 w49_c20 <|
    noThree_drop_step w49 84 4 w49_c21 <|
    noThree_drop_step w49 88 4 w49_c22 <|
    noThree_drop_step w49 92 4 w49_c23 <|
    noThree_drop_step w49 96 4 w49_c24 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w49_ok : noThree w49 = true ∧ inGrid 49 w49 = true ∧ w49.Nodup ∧ w49.length = 2 * 49 :=
  ⟨w49_noThree, by decide +kernel⟩

end Green72Data
