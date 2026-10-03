import Solution.Green72.Chunk

/-! Kernel check of the N = 38 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w38_c0 : prefOk ((w38.drop 0).take 4) ((w38.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c1 : prefOk ((w38.drop 4).take 4) ((w38.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c2 : prefOk ((w38.drop 8).take 4) ((w38.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c3 : prefOk ((w38.drop 12).take 4) ((w38.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c4 : prefOk ((w38.drop 16).take 4) ((w38.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c5 : prefOk ((w38.drop 20).take 4) ((w38.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c6 : prefOk ((w38.drop 24).take 4) ((w38.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c7 : prefOk ((w38.drop 28).take 4) ((w38.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c8 : prefOk ((w38.drop 32).take 4) ((w38.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c9 : prefOk ((w38.drop 36).take 4) ((w38.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c10 : prefOk ((w38.drop 40).take 4) ((w38.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c11 : prefOk ((w38.drop 44).take 4) ((w38.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c12 : prefOk ((w38.drop 48).take 4) ((w38.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c13 : prefOk ((w38.drop 52).take 4) ((w38.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c14 : prefOk ((w38.drop 56).take 4) ((w38.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c15 : prefOk ((w38.drop 60).take 4) ((w38.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c16 : prefOk ((w38.drop 64).take 4) ((w38.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c17 : prefOk ((w38.drop 68).take 4) ((w38.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c18 : prefOk ((w38.drop 72).take 4) ((w38.drop 72).drop 4) = true := by
  decide +kernel

theorem w38_noThree : noThree w38 = true := by
  have h : noThree (w38.drop 0) = true :=
    noThree_drop_step w38 0 4 w38_c0 <|
    noThree_drop_step w38 4 4 w38_c1 <|
    noThree_drop_step w38 8 4 w38_c2 <|
    noThree_drop_step w38 12 4 w38_c3 <|
    noThree_drop_step w38 16 4 w38_c4 <|
    noThree_drop_step w38 20 4 w38_c5 <|
    noThree_drop_step w38 24 4 w38_c6 <|
    noThree_drop_step w38 28 4 w38_c7 <|
    noThree_drop_step w38 32 4 w38_c8 <|
    noThree_drop_step w38 36 4 w38_c9 <|
    noThree_drop_step w38 40 4 w38_c10 <|
    noThree_drop_step w38 44 4 w38_c11 <|
    noThree_drop_step w38 48 4 w38_c12 <|
    noThree_drop_step w38 52 4 w38_c13 <|
    noThree_drop_step w38 56 4 w38_c14 <|
    noThree_drop_step w38 60 4 w38_c15 <|
    noThree_drop_step w38 64 4 w38_c16 <|
    noThree_drop_step w38 68 4 w38_c17 <|
    noThree_drop_step w38 72 4 w38_c18 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w38_ok : noThree w38 = true ∧ inGrid 38 w38 = true ∧ w38.Nodup ∧ w38.length = 2 * 38 :=
  ⟨w38_noThree, by decide +kernel⟩

end Green72Data
