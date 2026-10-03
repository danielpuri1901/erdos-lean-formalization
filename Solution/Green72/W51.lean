import Solution.Green72.Chunk

/-! Kernel check of the N = 51 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w51_c0 : prefOk ((w51.drop 0).take 4) ((w51.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c1 : prefOk ((w51.drop 4).take 4) ((w51.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c2 : prefOk ((w51.drop 8).take 4) ((w51.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c3 : prefOk ((w51.drop 12).take 4) ((w51.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c4 : prefOk ((w51.drop 16).take 4) ((w51.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c5 : prefOk ((w51.drop 20).take 4) ((w51.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c6 : prefOk ((w51.drop 24).take 4) ((w51.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c7 : prefOk ((w51.drop 28).take 4) ((w51.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c8 : prefOk ((w51.drop 32).take 4) ((w51.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c9 : prefOk ((w51.drop 36).take 4) ((w51.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c10 : prefOk ((w51.drop 40).take 4) ((w51.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c11 : prefOk ((w51.drop 44).take 4) ((w51.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c12 : prefOk ((w51.drop 48).take 4) ((w51.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c13 : prefOk ((w51.drop 52).take 4) ((w51.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c14 : prefOk ((w51.drop 56).take 4) ((w51.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c15 : prefOk ((w51.drop 60).take 4) ((w51.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c16 : prefOk ((w51.drop 64).take 4) ((w51.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c17 : prefOk ((w51.drop 68).take 4) ((w51.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c18 : prefOk ((w51.drop 72).take 4) ((w51.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c19 : prefOk ((w51.drop 76).take 4) ((w51.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c20 : prefOk ((w51.drop 80).take 4) ((w51.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c21 : prefOk ((w51.drop 84).take 4) ((w51.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c22 : prefOk ((w51.drop 88).take 4) ((w51.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c23 : prefOk ((w51.drop 92).take 4) ((w51.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c24 : prefOk ((w51.drop 96).take 4) ((w51.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c25 : prefOk ((w51.drop 100).take 4) ((w51.drop 100).drop 4) = true := by
  decide +kernel

theorem w51_noThree : noThree w51 = true := by
  have h : noThree (w51.drop 0) = true :=
    noThree_drop_step w51 0 4 w51_c0 <|
    noThree_drop_step w51 4 4 w51_c1 <|
    noThree_drop_step w51 8 4 w51_c2 <|
    noThree_drop_step w51 12 4 w51_c3 <|
    noThree_drop_step w51 16 4 w51_c4 <|
    noThree_drop_step w51 20 4 w51_c5 <|
    noThree_drop_step w51 24 4 w51_c6 <|
    noThree_drop_step w51 28 4 w51_c7 <|
    noThree_drop_step w51 32 4 w51_c8 <|
    noThree_drop_step w51 36 4 w51_c9 <|
    noThree_drop_step w51 40 4 w51_c10 <|
    noThree_drop_step w51 44 4 w51_c11 <|
    noThree_drop_step w51 48 4 w51_c12 <|
    noThree_drop_step w51 52 4 w51_c13 <|
    noThree_drop_step w51 56 4 w51_c14 <|
    noThree_drop_step w51 60 4 w51_c15 <|
    noThree_drop_step w51 64 4 w51_c16 <|
    noThree_drop_step w51 68 4 w51_c17 <|
    noThree_drop_step w51 72 4 w51_c18 <|
    noThree_drop_step w51 76 4 w51_c19 <|
    noThree_drop_step w51 80 4 w51_c20 <|
    noThree_drop_step w51 84 4 w51_c21 <|
    noThree_drop_step w51 88 4 w51_c22 <|
    noThree_drop_step w51 92 4 w51_c23 <|
    noThree_drop_step w51 96 4 w51_c24 <|
    noThree_drop_step w51 100 4 w51_c25 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w51_ok : noThree w51 = true ∧ inGrid 51 w51 = true ∧ w51.Nodup ∧ w51.length = 2 * 51 :=
  ⟨w51_noThree, by decide +kernel⟩

end Green72Data
