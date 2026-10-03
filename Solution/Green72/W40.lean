import Solution.Green72.Chunk

/-! Kernel check of the N = 40 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w40_c0 : prefOk ((w40.drop 0).take 4) ((w40.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c1 : prefOk ((w40.drop 4).take 4) ((w40.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c2 : prefOk ((w40.drop 8).take 4) ((w40.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c3 : prefOk ((w40.drop 12).take 4) ((w40.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c4 : prefOk ((w40.drop 16).take 4) ((w40.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c5 : prefOk ((w40.drop 20).take 4) ((w40.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c6 : prefOk ((w40.drop 24).take 4) ((w40.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c7 : prefOk ((w40.drop 28).take 4) ((w40.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c8 : prefOk ((w40.drop 32).take 4) ((w40.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c9 : prefOk ((w40.drop 36).take 4) ((w40.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c10 : prefOk ((w40.drop 40).take 4) ((w40.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c11 : prefOk ((w40.drop 44).take 4) ((w40.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c12 : prefOk ((w40.drop 48).take 4) ((w40.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c13 : prefOk ((w40.drop 52).take 4) ((w40.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c14 : prefOk ((w40.drop 56).take 4) ((w40.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c15 : prefOk ((w40.drop 60).take 4) ((w40.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c16 : prefOk ((w40.drop 64).take 4) ((w40.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c17 : prefOk ((w40.drop 68).take 4) ((w40.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c18 : prefOk ((w40.drop 72).take 4) ((w40.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c19 : prefOk ((w40.drop 76).take 4) ((w40.drop 76).drop 4) = true := by
  decide +kernel

theorem w40_noThree : noThree w40 = true := by
  have h : noThree (w40.drop 0) = true :=
    noThree_drop_step w40 0 4 w40_c0 <|
    noThree_drop_step w40 4 4 w40_c1 <|
    noThree_drop_step w40 8 4 w40_c2 <|
    noThree_drop_step w40 12 4 w40_c3 <|
    noThree_drop_step w40 16 4 w40_c4 <|
    noThree_drop_step w40 20 4 w40_c5 <|
    noThree_drop_step w40 24 4 w40_c6 <|
    noThree_drop_step w40 28 4 w40_c7 <|
    noThree_drop_step w40 32 4 w40_c8 <|
    noThree_drop_step w40 36 4 w40_c9 <|
    noThree_drop_step w40 40 4 w40_c10 <|
    noThree_drop_step w40 44 4 w40_c11 <|
    noThree_drop_step w40 48 4 w40_c12 <|
    noThree_drop_step w40 52 4 w40_c13 <|
    noThree_drop_step w40 56 4 w40_c14 <|
    noThree_drop_step w40 60 4 w40_c15 <|
    noThree_drop_step w40 64 4 w40_c16 <|
    noThree_drop_step w40 68 4 w40_c17 <|
    noThree_drop_step w40 72 4 w40_c18 <|
    noThree_drop_step w40 76 4 w40_c19 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w40_ok : noThree w40 = true ∧ inGrid 40 w40 = true ∧ w40.Nodup ∧ w40.length = 2 * 40 :=
  ⟨w40_noThree, by decide +kernel⟩

end Green72Data
