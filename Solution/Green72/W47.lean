import Solution.Green72.Chunk

/-! Kernel check of the N = 47 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w47_c0 : prefOk ((w47.drop 0).take 4) ((w47.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c1 : prefOk ((w47.drop 4).take 4) ((w47.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c2 : prefOk ((w47.drop 8).take 4) ((w47.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c3 : prefOk ((w47.drop 12).take 4) ((w47.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c4 : prefOk ((w47.drop 16).take 4) ((w47.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c5 : prefOk ((w47.drop 20).take 4) ((w47.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c6 : prefOk ((w47.drop 24).take 4) ((w47.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c7 : prefOk ((w47.drop 28).take 4) ((w47.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c8 : prefOk ((w47.drop 32).take 4) ((w47.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c9 : prefOk ((w47.drop 36).take 4) ((w47.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c10 : prefOk ((w47.drop 40).take 4) ((w47.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c11 : prefOk ((w47.drop 44).take 4) ((w47.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c12 : prefOk ((w47.drop 48).take 4) ((w47.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c13 : prefOk ((w47.drop 52).take 4) ((w47.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c14 : prefOk ((w47.drop 56).take 4) ((w47.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c15 : prefOk ((w47.drop 60).take 4) ((w47.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c16 : prefOk ((w47.drop 64).take 4) ((w47.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c17 : prefOk ((w47.drop 68).take 4) ((w47.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c18 : prefOk ((w47.drop 72).take 4) ((w47.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c19 : prefOk ((w47.drop 76).take 4) ((w47.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c20 : prefOk ((w47.drop 80).take 4) ((w47.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c21 : prefOk ((w47.drop 84).take 4) ((w47.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c22 : prefOk ((w47.drop 88).take 4) ((w47.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c23 : prefOk ((w47.drop 92).take 4) ((w47.drop 92).drop 4) = true := by
  decide +kernel

theorem w47_noThree : noThree w47 = true := by
  have h : noThree (w47.drop 0) = true :=
    noThree_drop_step w47 0 4 w47_c0 <|
    noThree_drop_step w47 4 4 w47_c1 <|
    noThree_drop_step w47 8 4 w47_c2 <|
    noThree_drop_step w47 12 4 w47_c3 <|
    noThree_drop_step w47 16 4 w47_c4 <|
    noThree_drop_step w47 20 4 w47_c5 <|
    noThree_drop_step w47 24 4 w47_c6 <|
    noThree_drop_step w47 28 4 w47_c7 <|
    noThree_drop_step w47 32 4 w47_c8 <|
    noThree_drop_step w47 36 4 w47_c9 <|
    noThree_drop_step w47 40 4 w47_c10 <|
    noThree_drop_step w47 44 4 w47_c11 <|
    noThree_drop_step w47 48 4 w47_c12 <|
    noThree_drop_step w47 52 4 w47_c13 <|
    noThree_drop_step w47 56 4 w47_c14 <|
    noThree_drop_step w47 60 4 w47_c15 <|
    noThree_drop_step w47 64 4 w47_c16 <|
    noThree_drop_step w47 68 4 w47_c17 <|
    noThree_drop_step w47 72 4 w47_c18 <|
    noThree_drop_step w47 76 4 w47_c19 <|
    noThree_drop_step w47 80 4 w47_c20 <|
    noThree_drop_step w47 84 4 w47_c21 <|
    noThree_drop_step w47 88 4 w47_c22 <|
    noThree_drop_step w47 92 4 w47_c23 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w47_ok : noThree w47 = true ∧ inGrid 47 w47 = true ∧ w47.Nodup ∧ w47.length = 2 * 47 :=
  ⟨w47_noThree, by decide +kernel⟩

end Green72Data
