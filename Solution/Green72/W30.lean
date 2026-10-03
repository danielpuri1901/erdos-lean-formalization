import Solution.Green72.Chunk

/-! Kernel check of the N = 30 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w30_c0 : prefOk ((w30.drop 0).take 4) ((w30.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c1 : prefOk ((w30.drop 4).take 4) ((w30.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c2 : prefOk ((w30.drop 8).take 4) ((w30.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c3 : prefOk ((w30.drop 12).take 4) ((w30.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c4 : prefOk ((w30.drop 16).take 4) ((w30.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c5 : prefOk ((w30.drop 20).take 4) ((w30.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c6 : prefOk ((w30.drop 24).take 4) ((w30.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c7 : prefOk ((w30.drop 28).take 4) ((w30.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c8 : prefOk ((w30.drop 32).take 4) ((w30.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c9 : prefOk ((w30.drop 36).take 4) ((w30.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c10 : prefOk ((w30.drop 40).take 4) ((w30.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c11 : prefOk ((w30.drop 44).take 4) ((w30.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c12 : prefOk ((w30.drop 48).take 4) ((w30.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c13 : prefOk ((w30.drop 52).take 4) ((w30.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c14 : prefOk ((w30.drop 56).take 4) ((w30.drop 56).drop 4) = true := by
  decide +kernel

theorem w30_noThree : noThree w30 = true := by
  have h : noThree (w30.drop 0) = true :=
    noThree_drop_step w30 0 4 w30_c0 <|
    noThree_drop_step w30 4 4 w30_c1 <|
    noThree_drop_step w30 8 4 w30_c2 <|
    noThree_drop_step w30 12 4 w30_c3 <|
    noThree_drop_step w30 16 4 w30_c4 <|
    noThree_drop_step w30 20 4 w30_c5 <|
    noThree_drop_step w30 24 4 w30_c6 <|
    noThree_drop_step w30 28 4 w30_c7 <|
    noThree_drop_step w30 32 4 w30_c8 <|
    noThree_drop_step w30 36 4 w30_c9 <|
    noThree_drop_step w30 40 4 w30_c10 <|
    noThree_drop_step w30 44 4 w30_c11 <|
    noThree_drop_step w30 48 4 w30_c12 <|
    noThree_drop_step w30 52 4 w30_c13 <|
    noThree_drop_step w30 56 4 w30_c14 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w30_ok : noThree w30 = true ∧ inGrid 30 w30 = true ∧ w30.Nodup ∧ w30.length = 2 * 30 :=
  ⟨w30_noThree, by decide +kernel⟩

end Green72Data
