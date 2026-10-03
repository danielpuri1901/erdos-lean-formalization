import Solution.Green72.Chunk

/-! Kernel check of the N = 37 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w37_c0 : prefOk ((w37.drop 0).take 4) ((w37.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c1 : prefOk ((w37.drop 4).take 4) ((w37.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c2 : prefOk ((w37.drop 8).take 4) ((w37.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c3 : prefOk ((w37.drop 12).take 4) ((w37.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c4 : prefOk ((w37.drop 16).take 4) ((w37.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c5 : prefOk ((w37.drop 20).take 4) ((w37.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c6 : prefOk ((w37.drop 24).take 4) ((w37.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c7 : prefOk ((w37.drop 28).take 4) ((w37.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c8 : prefOk ((w37.drop 32).take 4) ((w37.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c9 : prefOk ((w37.drop 36).take 4) ((w37.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c10 : prefOk ((w37.drop 40).take 4) ((w37.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c11 : prefOk ((w37.drop 44).take 4) ((w37.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c12 : prefOk ((w37.drop 48).take 4) ((w37.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c13 : prefOk ((w37.drop 52).take 4) ((w37.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c14 : prefOk ((w37.drop 56).take 4) ((w37.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c15 : prefOk ((w37.drop 60).take 4) ((w37.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c16 : prefOk ((w37.drop 64).take 4) ((w37.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c17 : prefOk ((w37.drop 68).take 4) ((w37.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c18 : prefOk ((w37.drop 72).take 4) ((w37.drop 72).drop 4) = true := by
  decide +kernel

theorem w37_noThree : noThree w37 = true := by
  have h : noThree (w37.drop 0) = true :=
    noThree_drop_step w37 0 4 w37_c0 <|
    noThree_drop_step w37 4 4 w37_c1 <|
    noThree_drop_step w37 8 4 w37_c2 <|
    noThree_drop_step w37 12 4 w37_c3 <|
    noThree_drop_step w37 16 4 w37_c4 <|
    noThree_drop_step w37 20 4 w37_c5 <|
    noThree_drop_step w37 24 4 w37_c6 <|
    noThree_drop_step w37 28 4 w37_c7 <|
    noThree_drop_step w37 32 4 w37_c8 <|
    noThree_drop_step w37 36 4 w37_c9 <|
    noThree_drop_step w37 40 4 w37_c10 <|
    noThree_drop_step w37 44 4 w37_c11 <|
    noThree_drop_step w37 48 4 w37_c12 <|
    noThree_drop_step w37 52 4 w37_c13 <|
    noThree_drop_step w37 56 4 w37_c14 <|
    noThree_drop_step w37 60 4 w37_c15 <|
    noThree_drop_step w37 64 4 w37_c16 <|
    noThree_drop_step w37 68 4 w37_c17 <|
    noThree_drop_step w37 72 4 w37_c18 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w37_ok : noThree w37 = true ∧ inGrid 37 w37 = true ∧ w37.Nodup ∧ w37.length = 2 * 37 :=
  ⟨w37_noThree, by decide +kernel⟩

end Green72Data
