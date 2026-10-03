import Solution.Green72.Chunk

/-! Kernel check of the N = 48 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w48_c0 : prefOk ((w48.drop 0).take 4) ((w48.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c1 : prefOk ((w48.drop 4).take 4) ((w48.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c2 : prefOk ((w48.drop 8).take 4) ((w48.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c3 : prefOk ((w48.drop 12).take 4) ((w48.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c4 : prefOk ((w48.drop 16).take 4) ((w48.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c5 : prefOk ((w48.drop 20).take 4) ((w48.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c6 : prefOk ((w48.drop 24).take 4) ((w48.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c7 : prefOk ((w48.drop 28).take 4) ((w48.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c8 : prefOk ((w48.drop 32).take 4) ((w48.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c9 : prefOk ((w48.drop 36).take 4) ((w48.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c10 : prefOk ((w48.drop 40).take 4) ((w48.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c11 : prefOk ((w48.drop 44).take 4) ((w48.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c12 : prefOk ((w48.drop 48).take 4) ((w48.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c13 : prefOk ((w48.drop 52).take 4) ((w48.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c14 : prefOk ((w48.drop 56).take 4) ((w48.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c15 : prefOk ((w48.drop 60).take 4) ((w48.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c16 : prefOk ((w48.drop 64).take 4) ((w48.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c17 : prefOk ((w48.drop 68).take 4) ((w48.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c18 : prefOk ((w48.drop 72).take 4) ((w48.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c19 : prefOk ((w48.drop 76).take 4) ((w48.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c20 : prefOk ((w48.drop 80).take 4) ((w48.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c21 : prefOk ((w48.drop 84).take 4) ((w48.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c22 : prefOk ((w48.drop 88).take 4) ((w48.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c23 : prefOk ((w48.drop 92).take 4) ((w48.drop 92).drop 4) = true := by
  decide +kernel

theorem w48_noThree : noThree w48 = true := by
  have h : noThree (w48.drop 0) = true :=
    noThree_drop_step w48 0 4 w48_c0 <|
    noThree_drop_step w48 4 4 w48_c1 <|
    noThree_drop_step w48 8 4 w48_c2 <|
    noThree_drop_step w48 12 4 w48_c3 <|
    noThree_drop_step w48 16 4 w48_c4 <|
    noThree_drop_step w48 20 4 w48_c5 <|
    noThree_drop_step w48 24 4 w48_c6 <|
    noThree_drop_step w48 28 4 w48_c7 <|
    noThree_drop_step w48 32 4 w48_c8 <|
    noThree_drop_step w48 36 4 w48_c9 <|
    noThree_drop_step w48 40 4 w48_c10 <|
    noThree_drop_step w48 44 4 w48_c11 <|
    noThree_drop_step w48 48 4 w48_c12 <|
    noThree_drop_step w48 52 4 w48_c13 <|
    noThree_drop_step w48 56 4 w48_c14 <|
    noThree_drop_step w48 60 4 w48_c15 <|
    noThree_drop_step w48 64 4 w48_c16 <|
    noThree_drop_step w48 68 4 w48_c17 <|
    noThree_drop_step w48 72 4 w48_c18 <|
    noThree_drop_step w48 76 4 w48_c19 <|
    noThree_drop_step w48 80 4 w48_c20 <|
    noThree_drop_step w48 84 4 w48_c21 <|
    noThree_drop_step w48 88 4 w48_c22 <|
    noThree_drop_step w48 92 4 w48_c23 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w48_ok : noThree w48 = true ∧ inGrid 48 w48 = true ∧ w48.Nodup ∧ w48.length = 2 * 48 :=
  ⟨w48_noThree, by decide +kernel⟩

end Green72Data
