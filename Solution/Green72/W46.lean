import Solution.Green72.Chunk

/-! Kernel check of the N = 46 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w46_c0 : prefOk ((w46.drop 0).take 4) ((w46.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c1 : prefOk ((w46.drop 4).take 4) ((w46.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c2 : prefOk ((w46.drop 8).take 4) ((w46.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c3 : prefOk ((w46.drop 12).take 4) ((w46.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c4 : prefOk ((w46.drop 16).take 4) ((w46.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c5 : prefOk ((w46.drop 20).take 4) ((w46.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c6 : prefOk ((w46.drop 24).take 4) ((w46.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c7 : prefOk ((w46.drop 28).take 4) ((w46.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c8 : prefOk ((w46.drop 32).take 4) ((w46.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c9 : prefOk ((w46.drop 36).take 4) ((w46.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c10 : prefOk ((w46.drop 40).take 4) ((w46.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c11 : prefOk ((w46.drop 44).take 4) ((w46.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c12 : prefOk ((w46.drop 48).take 4) ((w46.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c13 : prefOk ((w46.drop 52).take 4) ((w46.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c14 : prefOk ((w46.drop 56).take 4) ((w46.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c15 : prefOk ((w46.drop 60).take 4) ((w46.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c16 : prefOk ((w46.drop 64).take 4) ((w46.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c17 : prefOk ((w46.drop 68).take 4) ((w46.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c18 : prefOk ((w46.drop 72).take 4) ((w46.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c19 : prefOk ((w46.drop 76).take 4) ((w46.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c20 : prefOk ((w46.drop 80).take 4) ((w46.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c21 : prefOk ((w46.drop 84).take 4) ((w46.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c22 : prefOk ((w46.drop 88).take 4) ((w46.drop 88).drop 4) = true := by
  decide +kernel

theorem w46_noThree : noThree w46 = true := by
  have h : noThree (w46.drop 0) = true :=
    noThree_drop_step w46 0 4 w46_c0 <|
    noThree_drop_step w46 4 4 w46_c1 <|
    noThree_drop_step w46 8 4 w46_c2 <|
    noThree_drop_step w46 12 4 w46_c3 <|
    noThree_drop_step w46 16 4 w46_c4 <|
    noThree_drop_step w46 20 4 w46_c5 <|
    noThree_drop_step w46 24 4 w46_c6 <|
    noThree_drop_step w46 28 4 w46_c7 <|
    noThree_drop_step w46 32 4 w46_c8 <|
    noThree_drop_step w46 36 4 w46_c9 <|
    noThree_drop_step w46 40 4 w46_c10 <|
    noThree_drop_step w46 44 4 w46_c11 <|
    noThree_drop_step w46 48 4 w46_c12 <|
    noThree_drop_step w46 52 4 w46_c13 <|
    noThree_drop_step w46 56 4 w46_c14 <|
    noThree_drop_step w46 60 4 w46_c15 <|
    noThree_drop_step w46 64 4 w46_c16 <|
    noThree_drop_step w46 68 4 w46_c17 <|
    noThree_drop_step w46 72 4 w46_c18 <|
    noThree_drop_step w46 76 4 w46_c19 <|
    noThree_drop_step w46 80 4 w46_c20 <|
    noThree_drop_step w46 84 4 w46_c21 <|
    noThree_drop_step w46 88 4 w46_c22 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w46_ok : noThree w46 = true ∧ inGrid 46 w46 = true ∧ w46.Nodup ∧ w46.length = 2 * 46 :=
  ⟨w46_noThree, by decide +kernel⟩

end Green72Data
