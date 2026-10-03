import Solution.Green72.Chunk

/-! Kernel check of the N = 35 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w35_c0 : prefOk ((w35.drop 0).take 4) ((w35.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c1 : prefOk ((w35.drop 4).take 4) ((w35.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c2 : prefOk ((w35.drop 8).take 4) ((w35.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c3 : prefOk ((w35.drop 12).take 4) ((w35.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c4 : prefOk ((w35.drop 16).take 4) ((w35.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c5 : prefOk ((w35.drop 20).take 4) ((w35.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c6 : prefOk ((w35.drop 24).take 4) ((w35.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c7 : prefOk ((w35.drop 28).take 4) ((w35.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c8 : prefOk ((w35.drop 32).take 4) ((w35.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c9 : prefOk ((w35.drop 36).take 4) ((w35.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c10 : prefOk ((w35.drop 40).take 4) ((w35.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c11 : prefOk ((w35.drop 44).take 4) ((w35.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c12 : prefOk ((w35.drop 48).take 4) ((w35.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c13 : prefOk ((w35.drop 52).take 4) ((w35.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c14 : prefOk ((w35.drop 56).take 4) ((w35.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c15 : prefOk ((w35.drop 60).take 4) ((w35.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c16 : prefOk ((w35.drop 64).take 4) ((w35.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c17 : prefOk ((w35.drop 68).take 4) ((w35.drop 68).drop 4) = true := by
  decide +kernel

theorem w35_noThree : noThree w35 = true := by
  have h : noThree (w35.drop 0) = true :=
    noThree_drop_step w35 0 4 w35_c0 <|
    noThree_drop_step w35 4 4 w35_c1 <|
    noThree_drop_step w35 8 4 w35_c2 <|
    noThree_drop_step w35 12 4 w35_c3 <|
    noThree_drop_step w35 16 4 w35_c4 <|
    noThree_drop_step w35 20 4 w35_c5 <|
    noThree_drop_step w35 24 4 w35_c6 <|
    noThree_drop_step w35 28 4 w35_c7 <|
    noThree_drop_step w35 32 4 w35_c8 <|
    noThree_drop_step w35 36 4 w35_c9 <|
    noThree_drop_step w35 40 4 w35_c10 <|
    noThree_drop_step w35 44 4 w35_c11 <|
    noThree_drop_step w35 48 4 w35_c12 <|
    noThree_drop_step w35 52 4 w35_c13 <|
    noThree_drop_step w35 56 4 w35_c14 <|
    noThree_drop_step w35 60 4 w35_c15 <|
    noThree_drop_step w35 64 4 w35_c16 <|
    noThree_drop_step w35 68 4 w35_c17 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w35_ok : noThree w35 = true ∧ inGrid 35 w35 = true ∧ w35.Nodup ∧ w35.length = 2 * 35 :=
  ⟨w35_noThree, by decide +kernel⟩

end Green72Data
