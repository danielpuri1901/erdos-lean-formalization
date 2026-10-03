import Solution.Green72.Chunk

/-! Kernel check of the N = 54 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w54_c0 : prefOk ((w54.drop 0).take 4) ((w54.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c1 : prefOk ((w54.drop 4).take 4) ((w54.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c2 : prefOk ((w54.drop 8).take 4) ((w54.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c3 : prefOk ((w54.drop 12).take 4) ((w54.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c4 : prefOk ((w54.drop 16).take 4) ((w54.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c5 : prefOk ((w54.drop 20).take 4) ((w54.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c6 : prefOk ((w54.drop 24).take 4) ((w54.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c7 : prefOk ((w54.drop 28).take 4) ((w54.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c8 : prefOk ((w54.drop 32).take 4) ((w54.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c9 : prefOk ((w54.drop 36).take 4) ((w54.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c10 : prefOk ((w54.drop 40).take 4) ((w54.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c11 : prefOk ((w54.drop 44).take 4) ((w54.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c12 : prefOk ((w54.drop 48).take 4) ((w54.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c13 : prefOk ((w54.drop 52).take 4) ((w54.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c14 : prefOk ((w54.drop 56).take 4) ((w54.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c15 : prefOk ((w54.drop 60).take 4) ((w54.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c16 : prefOk ((w54.drop 64).take 4) ((w54.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c17 : prefOk ((w54.drop 68).take 4) ((w54.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c18 : prefOk ((w54.drop 72).take 4) ((w54.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c19 : prefOk ((w54.drop 76).take 4) ((w54.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c20 : prefOk ((w54.drop 80).take 4) ((w54.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c21 : prefOk ((w54.drop 84).take 4) ((w54.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c22 : prefOk ((w54.drop 88).take 4) ((w54.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c23 : prefOk ((w54.drop 92).take 4) ((w54.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c24 : prefOk ((w54.drop 96).take 4) ((w54.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c25 : prefOk ((w54.drop 100).take 4) ((w54.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w54_c26 : prefOk ((w54.drop 104).take 4) ((w54.drop 104).drop 4) = true := by
  decide +kernel

theorem w54_noThree : noThree w54 = true := by
  have h : noThree (w54.drop 0) = true :=
    noThree_drop_step w54 0 4 w54_c0 <|
    noThree_drop_step w54 4 4 w54_c1 <|
    noThree_drop_step w54 8 4 w54_c2 <|
    noThree_drop_step w54 12 4 w54_c3 <|
    noThree_drop_step w54 16 4 w54_c4 <|
    noThree_drop_step w54 20 4 w54_c5 <|
    noThree_drop_step w54 24 4 w54_c6 <|
    noThree_drop_step w54 28 4 w54_c7 <|
    noThree_drop_step w54 32 4 w54_c8 <|
    noThree_drop_step w54 36 4 w54_c9 <|
    noThree_drop_step w54 40 4 w54_c10 <|
    noThree_drop_step w54 44 4 w54_c11 <|
    noThree_drop_step w54 48 4 w54_c12 <|
    noThree_drop_step w54 52 4 w54_c13 <|
    noThree_drop_step w54 56 4 w54_c14 <|
    noThree_drop_step w54 60 4 w54_c15 <|
    noThree_drop_step w54 64 4 w54_c16 <|
    noThree_drop_step w54 68 4 w54_c17 <|
    noThree_drop_step w54 72 4 w54_c18 <|
    noThree_drop_step w54 76 4 w54_c19 <|
    noThree_drop_step w54 80 4 w54_c20 <|
    noThree_drop_step w54 84 4 w54_c21 <|
    noThree_drop_step w54 88 4 w54_c22 <|
    noThree_drop_step w54 92 4 w54_c23 <|
    noThree_drop_step w54 96 4 w54_c24 <|
    noThree_drop_step w54 100 4 w54_c25 <|
    noThree_drop_step w54 104 4 w54_c26 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w54_ok : noThree w54 = true ∧ inGrid 54 w54 = true ∧ w54.Nodup ∧ w54.length = 2 * 54 :=
  ⟨w54_noThree, by decide +kernel⟩

end Green72Data
