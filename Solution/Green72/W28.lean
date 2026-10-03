import Solution.Green72.Chunk

/-! Kernel check of the N = 28 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w28_c0 : prefOk ((w28.drop 0).take 4) ((w28.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c1 : prefOk ((w28.drop 4).take 4) ((w28.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c2 : prefOk ((w28.drop 8).take 4) ((w28.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c3 : prefOk ((w28.drop 12).take 4) ((w28.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c4 : prefOk ((w28.drop 16).take 4) ((w28.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c5 : prefOk ((w28.drop 20).take 4) ((w28.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c6 : prefOk ((w28.drop 24).take 4) ((w28.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c7 : prefOk ((w28.drop 28).take 4) ((w28.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c8 : prefOk ((w28.drop 32).take 4) ((w28.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c9 : prefOk ((w28.drop 36).take 4) ((w28.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c10 : prefOk ((w28.drop 40).take 4) ((w28.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c11 : prefOk ((w28.drop 44).take 4) ((w28.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c12 : prefOk ((w28.drop 48).take 4) ((w28.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c13 : prefOk ((w28.drop 52).take 4) ((w28.drop 52).drop 4) = true := by
  decide +kernel

theorem w28_noThree : noThree w28 = true := by
  have h : noThree (w28.drop 0) = true :=
    noThree_drop_step w28 0 4 w28_c0 <|
    noThree_drop_step w28 4 4 w28_c1 <|
    noThree_drop_step w28 8 4 w28_c2 <|
    noThree_drop_step w28 12 4 w28_c3 <|
    noThree_drop_step w28 16 4 w28_c4 <|
    noThree_drop_step w28 20 4 w28_c5 <|
    noThree_drop_step w28 24 4 w28_c6 <|
    noThree_drop_step w28 28 4 w28_c7 <|
    noThree_drop_step w28 32 4 w28_c8 <|
    noThree_drop_step w28 36 4 w28_c9 <|
    noThree_drop_step w28 40 4 w28_c10 <|
    noThree_drop_step w28 44 4 w28_c11 <|
    noThree_drop_step w28 48 4 w28_c12 <|
    noThree_drop_step w28 52 4 w28_c13 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w28_ok : noThree w28 = true ∧ inGrid 28 w28 = true ∧ w28.Nodup ∧ w28.length = 2 * 28 :=
  ⟨w28_noThree, by decide +kernel⟩

end Green72Data
