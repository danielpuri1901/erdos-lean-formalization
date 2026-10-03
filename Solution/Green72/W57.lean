import Solution.Green72.Chunk

/-! Kernel check of the N = 57 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w57_c0 : prefOk ((w57.drop 0).take 4) ((w57.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c1 : prefOk ((w57.drop 4).take 4) ((w57.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c2 : prefOk ((w57.drop 8).take 4) ((w57.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c3 : prefOk ((w57.drop 12).take 4) ((w57.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c4 : prefOk ((w57.drop 16).take 4) ((w57.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c5 : prefOk ((w57.drop 20).take 4) ((w57.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c6 : prefOk ((w57.drop 24).take 4) ((w57.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c7 : prefOk ((w57.drop 28).take 4) ((w57.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c8 : prefOk ((w57.drop 32).take 4) ((w57.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c9 : prefOk ((w57.drop 36).take 4) ((w57.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c10 : prefOk ((w57.drop 40).take 4) ((w57.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c11 : prefOk ((w57.drop 44).take 4) ((w57.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c12 : prefOk ((w57.drop 48).take 4) ((w57.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c13 : prefOk ((w57.drop 52).take 4) ((w57.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c14 : prefOk ((w57.drop 56).take 4) ((w57.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c15 : prefOk ((w57.drop 60).take 4) ((w57.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c16 : prefOk ((w57.drop 64).take 4) ((w57.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c17 : prefOk ((w57.drop 68).take 4) ((w57.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c18 : prefOk ((w57.drop 72).take 4) ((w57.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c19 : prefOk ((w57.drop 76).take 4) ((w57.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c20 : prefOk ((w57.drop 80).take 4) ((w57.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c21 : prefOk ((w57.drop 84).take 4) ((w57.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c22 : prefOk ((w57.drop 88).take 4) ((w57.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c23 : prefOk ((w57.drop 92).take 4) ((w57.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c24 : prefOk ((w57.drop 96).take 4) ((w57.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c25 : prefOk ((w57.drop 100).take 4) ((w57.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c26 : prefOk ((w57.drop 104).take 4) ((w57.drop 104).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c27 : prefOk ((w57.drop 108).take 4) ((w57.drop 108).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w57_c28 : prefOk ((w57.drop 112).take 4) ((w57.drop 112).drop 4) = true := by
  decide +kernel

theorem w57_noThree : noThree w57 = true := by
  have h : noThree (w57.drop 0) = true :=
    noThree_drop_step w57 0 4 w57_c0 <|
    noThree_drop_step w57 4 4 w57_c1 <|
    noThree_drop_step w57 8 4 w57_c2 <|
    noThree_drop_step w57 12 4 w57_c3 <|
    noThree_drop_step w57 16 4 w57_c4 <|
    noThree_drop_step w57 20 4 w57_c5 <|
    noThree_drop_step w57 24 4 w57_c6 <|
    noThree_drop_step w57 28 4 w57_c7 <|
    noThree_drop_step w57 32 4 w57_c8 <|
    noThree_drop_step w57 36 4 w57_c9 <|
    noThree_drop_step w57 40 4 w57_c10 <|
    noThree_drop_step w57 44 4 w57_c11 <|
    noThree_drop_step w57 48 4 w57_c12 <|
    noThree_drop_step w57 52 4 w57_c13 <|
    noThree_drop_step w57 56 4 w57_c14 <|
    noThree_drop_step w57 60 4 w57_c15 <|
    noThree_drop_step w57 64 4 w57_c16 <|
    noThree_drop_step w57 68 4 w57_c17 <|
    noThree_drop_step w57 72 4 w57_c18 <|
    noThree_drop_step w57 76 4 w57_c19 <|
    noThree_drop_step w57 80 4 w57_c20 <|
    noThree_drop_step w57 84 4 w57_c21 <|
    noThree_drop_step w57 88 4 w57_c22 <|
    noThree_drop_step w57 92 4 w57_c23 <|
    noThree_drop_step w57 96 4 w57_c24 <|
    noThree_drop_step w57 100 4 w57_c25 <|
    noThree_drop_step w57 104 4 w57_c26 <|
    noThree_drop_step w57 108 4 w57_c27 <|
    noThree_drop_step w57 112 4 w57_c28 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w57_ok : noThree w57 = true ∧ inGrid 57 w57 = true ∧ w57.Nodup ∧ w57.length = 2 * 57 :=
  ⟨w57_noThree, by decide +kernel⟩

end Green72Data
