import Solution.Green72.Chunk

/-! Kernel check of the N = 41 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w41_c0 : prefOk ((w41.drop 0).take 4) ((w41.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c1 : prefOk ((w41.drop 4).take 4) ((w41.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c2 : prefOk ((w41.drop 8).take 4) ((w41.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c3 : prefOk ((w41.drop 12).take 4) ((w41.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c4 : prefOk ((w41.drop 16).take 4) ((w41.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c5 : prefOk ((w41.drop 20).take 4) ((w41.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c6 : prefOk ((w41.drop 24).take 4) ((w41.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c7 : prefOk ((w41.drop 28).take 4) ((w41.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c8 : prefOk ((w41.drop 32).take 4) ((w41.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c9 : prefOk ((w41.drop 36).take 4) ((w41.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c10 : prefOk ((w41.drop 40).take 4) ((w41.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c11 : prefOk ((w41.drop 44).take 4) ((w41.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c12 : prefOk ((w41.drop 48).take 4) ((w41.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c13 : prefOk ((w41.drop 52).take 4) ((w41.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c14 : prefOk ((w41.drop 56).take 4) ((w41.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c15 : prefOk ((w41.drop 60).take 4) ((w41.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c16 : prefOk ((w41.drop 64).take 4) ((w41.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c17 : prefOk ((w41.drop 68).take 4) ((w41.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c18 : prefOk ((w41.drop 72).take 4) ((w41.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c19 : prefOk ((w41.drop 76).take 4) ((w41.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c20 : prefOk ((w41.drop 80).take 4) ((w41.drop 80).drop 4) = true := by
  decide +kernel

theorem w41_noThree : noThree w41 = true := by
  have h : noThree (w41.drop 0) = true :=
    noThree_drop_step w41 0 4 w41_c0 <|
    noThree_drop_step w41 4 4 w41_c1 <|
    noThree_drop_step w41 8 4 w41_c2 <|
    noThree_drop_step w41 12 4 w41_c3 <|
    noThree_drop_step w41 16 4 w41_c4 <|
    noThree_drop_step w41 20 4 w41_c5 <|
    noThree_drop_step w41 24 4 w41_c6 <|
    noThree_drop_step w41 28 4 w41_c7 <|
    noThree_drop_step w41 32 4 w41_c8 <|
    noThree_drop_step w41 36 4 w41_c9 <|
    noThree_drop_step w41 40 4 w41_c10 <|
    noThree_drop_step w41 44 4 w41_c11 <|
    noThree_drop_step w41 48 4 w41_c12 <|
    noThree_drop_step w41 52 4 w41_c13 <|
    noThree_drop_step w41 56 4 w41_c14 <|
    noThree_drop_step w41 60 4 w41_c15 <|
    noThree_drop_step w41 64 4 w41_c16 <|
    noThree_drop_step w41 68 4 w41_c17 <|
    noThree_drop_step w41 72 4 w41_c18 <|
    noThree_drop_step w41 76 4 w41_c19 <|
    noThree_drop_step w41 80 4 w41_c20 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w41_ok : noThree w41 = true ∧ inGrid 41 w41 = true ∧ w41.Nodup ∧ w41.length = 2 * 41 :=
  ⟨w41_noThree, by decide +kernel⟩

end Green72Data
