import Solution.Green72.Chunk

/-! Kernel check of the N = 56 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w56_c0 : prefOk ((w56.drop 0).take 4) ((w56.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c1 : prefOk ((w56.drop 4).take 4) ((w56.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c2 : prefOk ((w56.drop 8).take 4) ((w56.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c3 : prefOk ((w56.drop 12).take 4) ((w56.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c4 : prefOk ((w56.drop 16).take 4) ((w56.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c5 : prefOk ((w56.drop 20).take 4) ((w56.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c6 : prefOk ((w56.drop 24).take 4) ((w56.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c7 : prefOk ((w56.drop 28).take 4) ((w56.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c8 : prefOk ((w56.drop 32).take 4) ((w56.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c9 : prefOk ((w56.drop 36).take 4) ((w56.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c10 : prefOk ((w56.drop 40).take 4) ((w56.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c11 : prefOk ((w56.drop 44).take 4) ((w56.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c12 : prefOk ((w56.drop 48).take 4) ((w56.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c13 : prefOk ((w56.drop 52).take 4) ((w56.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c14 : prefOk ((w56.drop 56).take 4) ((w56.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c15 : prefOk ((w56.drop 60).take 4) ((w56.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c16 : prefOk ((w56.drop 64).take 4) ((w56.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c17 : prefOk ((w56.drop 68).take 4) ((w56.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c18 : prefOk ((w56.drop 72).take 4) ((w56.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c19 : prefOk ((w56.drop 76).take 4) ((w56.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c20 : prefOk ((w56.drop 80).take 4) ((w56.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c21 : prefOk ((w56.drop 84).take 4) ((w56.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c22 : prefOk ((w56.drop 88).take 4) ((w56.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c23 : prefOk ((w56.drop 92).take 4) ((w56.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c24 : prefOk ((w56.drop 96).take 4) ((w56.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c25 : prefOk ((w56.drop 100).take 4) ((w56.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c26 : prefOk ((w56.drop 104).take 4) ((w56.drop 104).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c27 : prefOk ((w56.drop 108).take 4) ((w56.drop 108).drop 4) = true := by
  decide +kernel

theorem w56_noThree : noThree w56 = true := by
  have h : noThree (w56.drop 0) = true :=
    noThree_drop_step w56 0 4 w56_c0 <|
    noThree_drop_step w56 4 4 w56_c1 <|
    noThree_drop_step w56 8 4 w56_c2 <|
    noThree_drop_step w56 12 4 w56_c3 <|
    noThree_drop_step w56 16 4 w56_c4 <|
    noThree_drop_step w56 20 4 w56_c5 <|
    noThree_drop_step w56 24 4 w56_c6 <|
    noThree_drop_step w56 28 4 w56_c7 <|
    noThree_drop_step w56 32 4 w56_c8 <|
    noThree_drop_step w56 36 4 w56_c9 <|
    noThree_drop_step w56 40 4 w56_c10 <|
    noThree_drop_step w56 44 4 w56_c11 <|
    noThree_drop_step w56 48 4 w56_c12 <|
    noThree_drop_step w56 52 4 w56_c13 <|
    noThree_drop_step w56 56 4 w56_c14 <|
    noThree_drop_step w56 60 4 w56_c15 <|
    noThree_drop_step w56 64 4 w56_c16 <|
    noThree_drop_step w56 68 4 w56_c17 <|
    noThree_drop_step w56 72 4 w56_c18 <|
    noThree_drop_step w56 76 4 w56_c19 <|
    noThree_drop_step w56 80 4 w56_c20 <|
    noThree_drop_step w56 84 4 w56_c21 <|
    noThree_drop_step w56 88 4 w56_c22 <|
    noThree_drop_step w56 92 4 w56_c23 <|
    noThree_drop_step w56 96 4 w56_c24 <|
    noThree_drop_step w56 100 4 w56_c25 <|
    noThree_drop_step w56 104 4 w56_c26 <|
    noThree_drop_step w56 108 4 w56_c27 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w56_ok : noThree w56 = true ∧ inGrid 56 w56 = true ∧ w56.Nodup ∧ w56.length = 2 * 56 :=
  ⟨w56_noThree, by decide +kernel⟩

end Green72Data
