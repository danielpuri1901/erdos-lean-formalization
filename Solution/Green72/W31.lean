import Solution.Green72.Chunk

/-! Kernel check of the N = 31 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w31_c0 : prefOk ((w31.drop 0).take 4) ((w31.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c1 : prefOk ((w31.drop 4).take 4) ((w31.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c2 : prefOk ((w31.drop 8).take 4) ((w31.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c3 : prefOk ((w31.drop 12).take 4) ((w31.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c4 : prefOk ((w31.drop 16).take 4) ((w31.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c5 : prefOk ((w31.drop 20).take 4) ((w31.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c6 : prefOk ((w31.drop 24).take 4) ((w31.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c7 : prefOk ((w31.drop 28).take 4) ((w31.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c8 : prefOk ((w31.drop 32).take 4) ((w31.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c9 : prefOk ((w31.drop 36).take 4) ((w31.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c10 : prefOk ((w31.drop 40).take 4) ((w31.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c11 : prefOk ((w31.drop 44).take 4) ((w31.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c12 : prefOk ((w31.drop 48).take 4) ((w31.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c13 : prefOk ((w31.drop 52).take 4) ((w31.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c14 : prefOk ((w31.drop 56).take 4) ((w31.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c15 : prefOk ((w31.drop 60).take 4) ((w31.drop 60).drop 4) = true := by
  decide +kernel

theorem w31_noThree : noThree w31 = true := by
  have h : noThree (w31.drop 0) = true :=
    noThree_drop_step w31 0 4 w31_c0 <|
    noThree_drop_step w31 4 4 w31_c1 <|
    noThree_drop_step w31 8 4 w31_c2 <|
    noThree_drop_step w31 12 4 w31_c3 <|
    noThree_drop_step w31 16 4 w31_c4 <|
    noThree_drop_step w31 20 4 w31_c5 <|
    noThree_drop_step w31 24 4 w31_c6 <|
    noThree_drop_step w31 28 4 w31_c7 <|
    noThree_drop_step w31 32 4 w31_c8 <|
    noThree_drop_step w31 36 4 w31_c9 <|
    noThree_drop_step w31 40 4 w31_c10 <|
    noThree_drop_step w31 44 4 w31_c11 <|
    noThree_drop_step w31 48 4 w31_c12 <|
    noThree_drop_step w31 52 4 w31_c13 <|
    noThree_drop_step w31 56 4 w31_c14 <|
    noThree_drop_step w31 60 4 w31_c15 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w31_ok : noThree w31 = true ∧ inGrid 31 w31 = true ∧ w31.Nodup ∧ w31.length = 2 * 31 :=
  ⟨w31_noThree, by decide +kernel⟩

end Green72Data
