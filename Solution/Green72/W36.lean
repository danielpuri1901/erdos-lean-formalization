import Solution.Green72.Chunk

/-! Kernel check of the N = 36 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w36_c0 : prefOk ((w36.drop 0).take 4) ((w36.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c1 : prefOk ((w36.drop 4).take 4) ((w36.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c2 : prefOk ((w36.drop 8).take 4) ((w36.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c3 : prefOk ((w36.drop 12).take 4) ((w36.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c4 : prefOk ((w36.drop 16).take 4) ((w36.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c5 : prefOk ((w36.drop 20).take 4) ((w36.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c6 : prefOk ((w36.drop 24).take 4) ((w36.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c7 : prefOk ((w36.drop 28).take 4) ((w36.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c8 : prefOk ((w36.drop 32).take 4) ((w36.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c9 : prefOk ((w36.drop 36).take 4) ((w36.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c10 : prefOk ((w36.drop 40).take 4) ((w36.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c11 : prefOk ((w36.drop 44).take 4) ((w36.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c12 : prefOk ((w36.drop 48).take 4) ((w36.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c13 : prefOk ((w36.drop 52).take 4) ((w36.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c14 : prefOk ((w36.drop 56).take 4) ((w36.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c15 : prefOk ((w36.drop 60).take 4) ((w36.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c16 : prefOk ((w36.drop 64).take 4) ((w36.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c17 : prefOk ((w36.drop 68).take 4) ((w36.drop 68).drop 4) = true := by
  decide +kernel

theorem w36_noThree : noThree w36 = true := by
  have h : noThree (w36.drop 0) = true :=
    noThree_drop_step w36 0 4 w36_c0 <|
    noThree_drop_step w36 4 4 w36_c1 <|
    noThree_drop_step w36 8 4 w36_c2 <|
    noThree_drop_step w36 12 4 w36_c3 <|
    noThree_drop_step w36 16 4 w36_c4 <|
    noThree_drop_step w36 20 4 w36_c5 <|
    noThree_drop_step w36 24 4 w36_c6 <|
    noThree_drop_step w36 28 4 w36_c7 <|
    noThree_drop_step w36 32 4 w36_c8 <|
    noThree_drop_step w36 36 4 w36_c9 <|
    noThree_drop_step w36 40 4 w36_c10 <|
    noThree_drop_step w36 44 4 w36_c11 <|
    noThree_drop_step w36 48 4 w36_c12 <|
    noThree_drop_step w36 52 4 w36_c13 <|
    noThree_drop_step w36 56 4 w36_c14 <|
    noThree_drop_step w36 60 4 w36_c15 <|
    noThree_drop_step w36 64 4 w36_c16 <|
    noThree_drop_step w36 68 4 w36_c17 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w36_ok : noThree w36 = true ∧ inGrid 36 w36 = true ∧ w36.Nodup ∧ w36.length = 2 * 36 :=
  ⟨w36_noThree, by decide +kernel⟩

end Green72Data
