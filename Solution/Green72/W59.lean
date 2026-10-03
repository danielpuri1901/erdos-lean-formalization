import Solution.Green72.Chunk

/-! Kernel check of the N = 59 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w59_c0 : prefOk ((w59.drop 0).take 4) ((w59.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c1 : prefOk ((w59.drop 4).take 4) ((w59.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c2 : prefOk ((w59.drop 8).take 4) ((w59.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c3 : prefOk ((w59.drop 12).take 4) ((w59.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c4 : prefOk ((w59.drop 16).take 4) ((w59.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c5 : prefOk ((w59.drop 20).take 4) ((w59.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c6 : prefOk ((w59.drop 24).take 4) ((w59.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c7 : prefOk ((w59.drop 28).take 4) ((w59.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c8 : prefOk ((w59.drop 32).take 4) ((w59.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c9 : prefOk ((w59.drop 36).take 4) ((w59.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c10 : prefOk ((w59.drop 40).take 4) ((w59.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c11 : prefOk ((w59.drop 44).take 4) ((w59.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c12 : prefOk ((w59.drop 48).take 4) ((w59.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c13 : prefOk ((w59.drop 52).take 4) ((w59.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c14 : prefOk ((w59.drop 56).take 4) ((w59.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c15 : prefOk ((w59.drop 60).take 4) ((w59.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c16 : prefOk ((w59.drop 64).take 4) ((w59.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c17 : prefOk ((w59.drop 68).take 4) ((w59.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c18 : prefOk ((w59.drop 72).take 4) ((w59.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c19 : prefOk ((w59.drop 76).take 4) ((w59.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c20 : prefOk ((w59.drop 80).take 4) ((w59.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c21 : prefOk ((w59.drop 84).take 4) ((w59.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c22 : prefOk ((w59.drop 88).take 4) ((w59.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c23 : prefOk ((w59.drop 92).take 4) ((w59.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c24 : prefOk ((w59.drop 96).take 4) ((w59.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c25 : prefOk ((w59.drop 100).take 4) ((w59.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c26 : prefOk ((w59.drop 104).take 4) ((w59.drop 104).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c27 : prefOk ((w59.drop 108).take 4) ((w59.drop 108).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c28 : prefOk ((w59.drop 112).take 4) ((w59.drop 112).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w59_c29 : prefOk ((w59.drop 116).take 4) ((w59.drop 116).drop 4) = true := by
  decide +kernel

theorem w59_noThree : noThree w59 = true := by
  have h : noThree (w59.drop 0) = true :=
    noThree_drop_step w59 0 4 w59_c0 <|
    noThree_drop_step w59 4 4 w59_c1 <|
    noThree_drop_step w59 8 4 w59_c2 <|
    noThree_drop_step w59 12 4 w59_c3 <|
    noThree_drop_step w59 16 4 w59_c4 <|
    noThree_drop_step w59 20 4 w59_c5 <|
    noThree_drop_step w59 24 4 w59_c6 <|
    noThree_drop_step w59 28 4 w59_c7 <|
    noThree_drop_step w59 32 4 w59_c8 <|
    noThree_drop_step w59 36 4 w59_c9 <|
    noThree_drop_step w59 40 4 w59_c10 <|
    noThree_drop_step w59 44 4 w59_c11 <|
    noThree_drop_step w59 48 4 w59_c12 <|
    noThree_drop_step w59 52 4 w59_c13 <|
    noThree_drop_step w59 56 4 w59_c14 <|
    noThree_drop_step w59 60 4 w59_c15 <|
    noThree_drop_step w59 64 4 w59_c16 <|
    noThree_drop_step w59 68 4 w59_c17 <|
    noThree_drop_step w59 72 4 w59_c18 <|
    noThree_drop_step w59 76 4 w59_c19 <|
    noThree_drop_step w59 80 4 w59_c20 <|
    noThree_drop_step w59 84 4 w59_c21 <|
    noThree_drop_step w59 88 4 w59_c22 <|
    noThree_drop_step w59 92 4 w59_c23 <|
    noThree_drop_step w59 96 4 w59_c24 <|
    noThree_drop_step w59 100 4 w59_c25 <|
    noThree_drop_step w59 104 4 w59_c26 <|
    noThree_drop_step w59 108 4 w59_c27 <|
    noThree_drop_step w59 112 4 w59_c28 <|
    noThree_drop_step w59 116 4 w59_c29 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w59_ok : noThree w59 = true ∧ inGrid 59 w59 = true ∧ w59.Nodup ∧ w59.length = 2 * 59 :=
  ⟨w59_noThree, by decide +kernel⟩

end Green72Data
