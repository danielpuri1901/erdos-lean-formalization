import Solution.Green72.Chunk

/-! Kernel check of the N = 29 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w29_c0 : prefOk ((w29.drop 0).take 4) ((w29.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c1 : prefOk ((w29.drop 4).take 4) ((w29.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c2 : prefOk ((w29.drop 8).take 4) ((w29.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c3 : prefOk ((w29.drop 12).take 4) ((w29.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c4 : prefOk ((w29.drop 16).take 4) ((w29.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c5 : prefOk ((w29.drop 20).take 4) ((w29.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c6 : prefOk ((w29.drop 24).take 4) ((w29.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c7 : prefOk ((w29.drop 28).take 4) ((w29.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c8 : prefOk ((w29.drop 32).take 4) ((w29.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c9 : prefOk ((w29.drop 36).take 4) ((w29.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c10 : prefOk ((w29.drop 40).take 4) ((w29.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c11 : prefOk ((w29.drop 44).take 4) ((w29.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c12 : prefOk ((w29.drop 48).take 4) ((w29.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c13 : prefOk ((w29.drop 52).take 4) ((w29.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c14 : prefOk ((w29.drop 56).take 4) ((w29.drop 56).drop 4) = true := by
  decide +kernel

theorem w29_noThree : noThree w29 = true := by
  have h : noThree (w29.drop 0) = true :=
    noThree_drop_step w29 0 4 w29_c0 <|
    noThree_drop_step w29 4 4 w29_c1 <|
    noThree_drop_step w29 8 4 w29_c2 <|
    noThree_drop_step w29 12 4 w29_c3 <|
    noThree_drop_step w29 16 4 w29_c4 <|
    noThree_drop_step w29 20 4 w29_c5 <|
    noThree_drop_step w29 24 4 w29_c6 <|
    noThree_drop_step w29 28 4 w29_c7 <|
    noThree_drop_step w29 32 4 w29_c8 <|
    noThree_drop_step w29 36 4 w29_c9 <|
    noThree_drop_step w29 40 4 w29_c10 <|
    noThree_drop_step w29 44 4 w29_c11 <|
    noThree_drop_step w29 48 4 w29_c12 <|
    noThree_drop_step w29 52 4 w29_c13 <|
    noThree_drop_step w29 56 4 w29_c14 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w29_ok : noThree w29 = true ∧ inGrid 29 w29 = true ∧ w29.Nodup ∧ w29.length = 2 * 29 :=
  ⟨w29_noThree, by decide +kernel⟩

end Green72Data
