import Solution.Green72.Chunk

/-! Kernel check of the N = 34 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w34_c0 : prefOk ((w34.drop 0).take 4) ((w34.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c1 : prefOk ((w34.drop 4).take 4) ((w34.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c2 : prefOk ((w34.drop 8).take 4) ((w34.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c3 : prefOk ((w34.drop 12).take 4) ((w34.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c4 : prefOk ((w34.drop 16).take 4) ((w34.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c5 : prefOk ((w34.drop 20).take 4) ((w34.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c6 : prefOk ((w34.drop 24).take 4) ((w34.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c7 : prefOk ((w34.drop 28).take 4) ((w34.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c8 : prefOk ((w34.drop 32).take 4) ((w34.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c9 : prefOk ((w34.drop 36).take 4) ((w34.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c10 : prefOk ((w34.drop 40).take 4) ((w34.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c11 : prefOk ((w34.drop 44).take 4) ((w34.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c12 : prefOk ((w34.drop 48).take 4) ((w34.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c13 : prefOk ((w34.drop 52).take 4) ((w34.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c14 : prefOk ((w34.drop 56).take 4) ((w34.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c15 : prefOk ((w34.drop 60).take 4) ((w34.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c16 : prefOk ((w34.drop 64).take 4) ((w34.drop 64).drop 4) = true := by
  decide +kernel

theorem w34_noThree : noThree w34 = true := by
  have h : noThree (w34.drop 0) = true :=
    noThree_drop_step w34 0 4 w34_c0 <|
    noThree_drop_step w34 4 4 w34_c1 <|
    noThree_drop_step w34 8 4 w34_c2 <|
    noThree_drop_step w34 12 4 w34_c3 <|
    noThree_drop_step w34 16 4 w34_c4 <|
    noThree_drop_step w34 20 4 w34_c5 <|
    noThree_drop_step w34 24 4 w34_c6 <|
    noThree_drop_step w34 28 4 w34_c7 <|
    noThree_drop_step w34 32 4 w34_c8 <|
    noThree_drop_step w34 36 4 w34_c9 <|
    noThree_drop_step w34 40 4 w34_c10 <|
    noThree_drop_step w34 44 4 w34_c11 <|
    noThree_drop_step w34 48 4 w34_c12 <|
    noThree_drop_step w34 52 4 w34_c13 <|
    noThree_drop_step w34 56 4 w34_c14 <|
    noThree_drop_step w34 60 4 w34_c15 <|
    noThree_drop_step w34 64 4 w34_c16 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w34_ok : noThree w34 = true ∧ inGrid 34 w34 = true ∧ w34.Nodup ∧ w34.length = 2 * 34 :=
  ⟨w34_noThree, by decide +kernel⟩

end Green72Data
