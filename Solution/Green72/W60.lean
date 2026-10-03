import Solution.Green72.Chunk

/-! Kernel check of the N = 60 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w60_c0 : prefOk ((w60.drop 0).take 4) ((w60.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c1 : prefOk ((w60.drop 4).take 4) ((w60.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c2 : prefOk ((w60.drop 8).take 4) ((w60.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c3 : prefOk ((w60.drop 12).take 4) ((w60.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c4 : prefOk ((w60.drop 16).take 4) ((w60.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c5 : prefOk ((w60.drop 20).take 4) ((w60.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c6 : prefOk ((w60.drop 24).take 4) ((w60.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c7 : prefOk ((w60.drop 28).take 4) ((w60.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c8 : prefOk ((w60.drop 32).take 4) ((w60.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c9 : prefOk ((w60.drop 36).take 4) ((w60.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c10 : prefOk ((w60.drop 40).take 4) ((w60.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c11 : prefOk ((w60.drop 44).take 4) ((w60.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c12 : prefOk ((w60.drop 48).take 4) ((w60.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c13 : prefOk ((w60.drop 52).take 4) ((w60.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c14 : prefOk ((w60.drop 56).take 4) ((w60.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c15 : prefOk ((w60.drop 60).take 4) ((w60.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c16 : prefOk ((w60.drop 64).take 4) ((w60.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c17 : prefOk ((w60.drop 68).take 4) ((w60.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c18 : prefOk ((w60.drop 72).take 4) ((w60.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c19 : prefOk ((w60.drop 76).take 4) ((w60.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c20 : prefOk ((w60.drop 80).take 4) ((w60.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c21 : prefOk ((w60.drop 84).take 4) ((w60.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c22 : prefOk ((w60.drop 88).take 4) ((w60.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c23 : prefOk ((w60.drop 92).take 4) ((w60.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c24 : prefOk ((w60.drop 96).take 4) ((w60.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c25 : prefOk ((w60.drop 100).take 4) ((w60.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c26 : prefOk ((w60.drop 104).take 4) ((w60.drop 104).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c27 : prefOk ((w60.drop 108).take 4) ((w60.drop 108).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c28 : prefOk ((w60.drop 112).take 4) ((w60.drop 112).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w60_c29 : prefOk ((w60.drop 116).take 4) ((w60.drop 116).drop 4) = true := by
  decide +kernel

theorem w60_noThree : noThree w60 = true := by
  have h : noThree (w60.drop 0) = true :=
    noThree_drop_step w60 0 4 w60_c0 <|
    noThree_drop_step w60 4 4 w60_c1 <|
    noThree_drop_step w60 8 4 w60_c2 <|
    noThree_drop_step w60 12 4 w60_c3 <|
    noThree_drop_step w60 16 4 w60_c4 <|
    noThree_drop_step w60 20 4 w60_c5 <|
    noThree_drop_step w60 24 4 w60_c6 <|
    noThree_drop_step w60 28 4 w60_c7 <|
    noThree_drop_step w60 32 4 w60_c8 <|
    noThree_drop_step w60 36 4 w60_c9 <|
    noThree_drop_step w60 40 4 w60_c10 <|
    noThree_drop_step w60 44 4 w60_c11 <|
    noThree_drop_step w60 48 4 w60_c12 <|
    noThree_drop_step w60 52 4 w60_c13 <|
    noThree_drop_step w60 56 4 w60_c14 <|
    noThree_drop_step w60 60 4 w60_c15 <|
    noThree_drop_step w60 64 4 w60_c16 <|
    noThree_drop_step w60 68 4 w60_c17 <|
    noThree_drop_step w60 72 4 w60_c18 <|
    noThree_drop_step w60 76 4 w60_c19 <|
    noThree_drop_step w60 80 4 w60_c20 <|
    noThree_drop_step w60 84 4 w60_c21 <|
    noThree_drop_step w60 88 4 w60_c22 <|
    noThree_drop_step w60 92 4 w60_c23 <|
    noThree_drop_step w60 96 4 w60_c24 <|
    noThree_drop_step w60 100 4 w60_c25 <|
    noThree_drop_step w60 104 4 w60_c26 <|
    noThree_drop_step w60 108 4 w60_c27 <|
    noThree_drop_step w60 112 4 w60_c28 <|
    noThree_drop_step w60 116 4 w60_c29 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w60_ok : noThree w60 = true ∧ inGrid 60 w60 = true ∧ w60.Nodup ∧ w60.length = 2 * 60 :=
  ⟨w60_noThree, by decide +kernel⟩

end Green72Data
