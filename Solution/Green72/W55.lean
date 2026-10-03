import Solution.Green72.Chunk

/-! Kernel check of the N = 55 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w55_c0 : prefOk ((w55.drop 0).take 4) ((w55.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c1 : prefOk ((w55.drop 4).take 4) ((w55.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c2 : prefOk ((w55.drop 8).take 4) ((w55.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c3 : prefOk ((w55.drop 12).take 4) ((w55.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c4 : prefOk ((w55.drop 16).take 4) ((w55.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c5 : prefOk ((w55.drop 20).take 4) ((w55.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c6 : prefOk ((w55.drop 24).take 4) ((w55.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c7 : prefOk ((w55.drop 28).take 4) ((w55.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c8 : prefOk ((w55.drop 32).take 4) ((w55.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c9 : prefOk ((w55.drop 36).take 4) ((w55.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c10 : prefOk ((w55.drop 40).take 4) ((w55.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c11 : prefOk ((w55.drop 44).take 4) ((w55.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c12 : prefOk ((w55.drop 48).take 4) ((w55.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c13 : prefOk ((w55.drop 52).take 4) ((w55.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c14 : prefOk ((w55.drop 56).take 4) ((w55.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c15 : prefOk ((w55.drop 60).take 4) ((w55.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c16 : prefOk ((w55.drop 64).take 4) ((w55.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c17 : prefOk ((w55.drop 68).take 4) ((w55.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c18 : prefOk ((w55.drop 72).take 4) ((w55.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c19 : prefOk ((w55.drop 76).take 4) ((w55.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c20 : prefOk ((w55.drop 80).take 4) ((w55.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c21 : prefOk ((w55.drop 84).take 4) ((w55.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c22 : prefOk ((w55.drop 88).take 4) ((w55.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c23 : prefOk ((w55.drop 92).take 4) ((w55.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c24 : prefOk ((w55.drop 96).take 4) ((w55.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c25 : prefOk ((w55.drop 100).take 4) ((w55.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c26 : prefOk ((w55.drop 104).take 4) ((w55.drop 104).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c27 : prefOk ((w55.drop 108).take 4) ((w55.drop 108).drop 4) = true := by
  decide +kernel

theorem w55_noThree : noThree w55 = true := by
  have h : noThree (w55.drop 0) = true :=
    noThree_drop_step w55 0 4 w55_c0 <|
    noThree_drop_step w55 4 4 w55_c1 <|
    noThree_drop_step w55 8 4 w55_c2 <|
    noThree_drop_step w55 12 4 w55_c3 <|
    noThree_drop_step w55 16 4 w55_c4 <|
    noThree_drop_step w55 20 4 w55_c5 <|
    noThree_drop_step w55 24 4 w55_c6 <|
    noThree_drop_step w55 28 4 w55_c7 <|
    noThree_drop_step w55 32 4 w55_c8 <|
    noThree_drop_step w55 36 4 w55_c9 <|
    noThree_drop_step w55 40 4 w55_c10 <|
    noThree_drop_step w55 44 4 w55_c11 <|
    noThree_drop_step w55 48 4 w55_c12 <|
    noThree_drop_step w55 52 4 w55_c13 <|
    noThree_drop_step w55 56 4 w55_c14 <|
    noThree_drop_step w55 60 4 w55_c15 <|
    noThree_drop_step w55 64 4 w55_c16 <|
    noThree_drop_step w55 68 4 w55_c17 <|
    noThree_drop_step w55 72 4 w55_c18 <|
    noThree_drop_step w55 76 4 w55_c19 <|
    noThree_drop_step w55 80 4 w55_c20 <|
    noThree_drop_step w55 84 4 w55_c21 <|
    noThree_drop_step w55 88 4 w55_c22 <|
    noThree_drop_step w55 92 4 w55_c23 <|
    noThree_drop_step w55 96 4 w55_c24 <|
    noThree_drop_step w55 100 4 w55_c25 <|
    noThree_drop_step w55 104 4 w55_c26 <|
    noThree_drop_step w55 108 4 w55_c27 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w55_ok : noThree w55 = true ∧ inGrid 55 w55 = true ∧ w55.Nodup ∧ w55.length = 2 * 55 :=
  ⟨w55_noThree, by decide +kernel⟩

end Green72Data
