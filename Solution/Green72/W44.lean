import Solution.Green72.Chunk

/-! Kernel check of the N = 44 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w44_c0 : prefOk ((w44.drop 0).take 4) ((w44.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c1 : prefOk ((w44.drop 4).take 4) ((w44.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c2 : prefOk ((w44.drop 8).take 4) ((w44.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c3 : prefOk ((w44.drop 12).take 4) ((w44.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c4 : prefOk ((w44.drop 16).take 4) ((w44.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c5 : prefOk ((w44.drop 20).take 4) ((w44.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c6 : prefOk ((w44.drop 24).take 4) ((w44.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c7 : prefOk ((w44.drop 28).take 4) ((w44.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c8 : prefOk ((w44.drop 32).take 4) ((w44.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c9 : prefOk ((w44.drop 36).take 4) ((w44.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c10 : prefOk ((w44.drop 40).take 4) ((w44.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c11 : prefOk ((w44.drop 44).take 4) ((w44.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c12 : prefOk ((w44.drop 48).take 4) ((w44.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c13 : prefOk ((w44.drop 52).take 4) ((w44.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c14 : prefOk ((w44.drop 56).take 4) ((w44.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c15 : prefOk ((w44.drop 60).take 4) ((w44.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c16 : prefOk ((w44.drop 64).take 4) ((w44.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c17 : prefOk ((w44.drop 68).take 4) ((w44.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c18 : prefOk ((w44.drop 72).take 4) ((w44.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c19 : prefOk ((w44.drop 76).take 4) ((w44.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c20 : prefOk ((w44.drop 80).take 4) ((w44.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c21 : prefOk ((w44.drop 84).take 4) ((w44.drop 84).drop 4) = true := by
  decide +kernel

theorem w44_noThree : noThree w44 = true := by
  have h : noThree (w44.drop 0) = true :=
    noThree_drop_step w44 0 4 w44_c0 <|
    noThree_drop_step w44 4 4 w44_c1 <|
    noThree_drop_step w44 8 4 w44_c2 <|
    noThree_drop_step w44 12 4 w44_c3 <|
    noThree_drop_step w44 16 4 w44_c4 <|
    noThree_drop_step w44 20 4 w44_c5 <|
    noThree_drop_step w44 24 4 w44_c6 <|
    noThree_drop_step w44 28 4 w44_c7 <|
    noThree_drop_step w44 32 4 w44_c8 <|
    noThree_drop_step w44 36 4 w44_c9 <|
    noThree_drop_step w44 40 4 w44_c10 <|
    noThree_drop_step w44 44 4 w44_c11 <|
    noThree_drop_step w44 48 4 w44_c12 <|
    noThree_drop_step w44 52 4 w44_c13 <|
    noThree_drop_step w44 56 4 w44_c14 <|
    noThree_drop_step w44 60 4 w44_c15 <|
    noThree_drop_step w44 64 4 w44_c16 <|
    noThree_drop_step w44 68 4 w44_c17 <|
    noThree_drop_step w44 72 4 w44_c18 <|
    noThree_drop_step w44 76 4 w44_c19 <|
    noThree_drop_step w44 80 4 w44_c20 <|
    noThree_drop_step w44 84 4 w44_c21 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w44_ok : noThree w44 = true ∧ inGrid 44 w44 = true ∧ w44.Nodup ∧ w44.length = 2 * 44 :=
  ⟨w44_noThree, by decide +kernel⟩

end Green72Data
