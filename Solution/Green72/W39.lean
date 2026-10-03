import Solution.Green72.Chunk

/-! Kernel check of the N = 39 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w39_c0 : prefOk ((w39.drop 0).take 4) ((w39.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c1 : prefOk ((w39.drop 4).take 4) ((w39.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c2 : prefOk ((w39.drop 8).take 4) ((w39.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c3 : prefOk ((w39.drop 12).take 4) ((w39.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c4 : prefOk ((w39.drop 16).take 4) ((w39.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c5 : prefOk ((w39.drop 20).take 4) ((w39.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c6 : prefOk ((w39.drop 24).take 4) ((w39.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c7 : prefOk ((w39.drop 28).take 4) ((w39.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c8 : prefOk ((w39.drop 32).take 4) ((w39.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c9 : prefOk ((w39.drop 36).take 4) ((w39.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c10 : prefOk ((w39.drop 40).take 4) ((w39.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c11 : prefOk ((w39.drop 44).take 4) ((w39.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c12 : prefOk ((w39.drop 48).take 4) ((w39.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c13 : prefOk ((w39.drop 52).take 4) ((w39.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c14 : prefOk ((w39.drop 56).take 4) ((w39.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c15 : prefOk ((w39.drop 60).take 4) ((w39.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c16 : prefOk ((w39.drop 64).take 4) ((w39.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c17 : prefOk ((w39.drop 68).take 4) ((w39.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c18 : prefOk ((w39.drop 72).take 4) ((w39.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c19 : prefOk ((w39.drop 76).take 4) ((w39.drop 76).drop 4) = true := by
  decide +kernel

theorem w39_noThree : noThree w39 = true := by
  have h : noThree (w39.drop 0) = true :=
    noThree_drop_step w39 0 4 w39_c0 <|
    noThree_drop_step w39 4 4 w39_c1 <|
    noThree_drop_step w39 8 4 w39_c2 <|
    noThree_drop_step w39 12 4 w39_c3 <|
    noThree_drop_step w39 16 4 w39_c4 <|
    noThree_drop_step w39 20 4 w39_c5 <|
    noThree_drop_step w39 24 4 w39_c6 <|
    noThree_drop_step w39 28 4 w39_c7 <|
    noThree_drop_step w39 32 4 w39_c8 <|
    noThree_drop_step w39 36 4 w39_c9 <|
    noThree_drop_step w39 40 4 w39_c10 <|
    noThree_drop_step w39 44 4 w39_c11 <|
    noThree_drop_step w39 48 4 w39_c12 <|
    noThree_drop_step w39 52 4 w39_c13 <|
    noThree_drop_step w39 56 4 w39_c14 <|
    noThree_drop_step w39 60 4 w39_c15 <|
    noThree_drop_step w39 64 4 w39_c16 <|
    noThree_drop_step w39 68 4 w39_c17 <|
    noThree_drop_step w39 72 4 w39_c18 <|
    noThree_drop_step w39 76 4 w39_c19 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w39_ok : noThree w39 = true ∧ inGrid 39 w39 = true ∧ w39.Nodup ∧ w39.length = 2 * 39 :=
  ⟨w39_noThree, by decide +kernel⟩

end Green72Data
