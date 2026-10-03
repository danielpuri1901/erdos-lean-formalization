import Solution.Green72.Chunk

/-! Kernel check of the N = 33 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w33_c0 : prefOk ((w33.drop 0).take 4) ((w33.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c1 : prefOk ((w33.drop 4).take 4) ((w33.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c2 : prefOk ((w33.drop 8).take 4) ((w33.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c3 : prefOk ((w33.drop 12).take 4) ((w33.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c4 : prefOk ((w33.drop 16).take 4) ((w33.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c5 : prefOk ((w33.drop 20).take 4) ((w33.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c6 : prefOk ((w33.drop 24).take 4) ((w33.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c7 : prefOk ((w33.drop 28).take 4) ((w33.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c8 : prefOk ((w33.drop 32).take 4) ((w33.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c9 : prefOk ((w33.drop 36).take 4) ((w33.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c10 : prefOk ((w33.drop 40).take 4) ((w33.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c11 : prefOk ((w33.drop 44).take 4) ((w33.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c12 : prefOk ((w33.drop 48).take 4) ((w33.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c13 : prefOk ((w33.drop 52).take 4) ((w33.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c14 : prefOk ((w33.drop 56).take 4) ((w33.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c15 : prefOk ((w33.drop 60).take 4) ((w33.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c16 : prefOk ((w33.drop 64).take 4) ((w33.drop 64).drop 4) = true := by
  decide +kernel

theorem w33_noThree : noThree w33 = true := by
  have h : noThree (w33.drop 0) = true :=
    noThree_drop_step w33 0 4 w33_c0 <|
    noThree_drop_step w33 4 4 w33_c1 <|
    noThree_drop_step w33 8 4 w33_c2 <|
    noThree_drop_step w33 12 4 w33_c3 <|
    noThree_drop_step w33 16 4 w33_c4 <|
    noThree_drop_step w33 20 4 w33_c5 <|
    noThree_drop_step w33 24 4 w33_c6 <|
    noThree_drop_step w33 28 4 w33_c7 <|
    noThree_drop_step w33 32 4 w33_c8 <|
    noThree_drop_step w33 36 4 w33_c9 <|
    noThree_drop_step w33 40 4 w33_c10 <|
    noThree_drop_step w33 44 4 w33_c11 <|
    noThree_drop_step w33 48 4 w33_c12 <|
    noThree_drop_step w33 52 4 w33_c13 <|
    noThree_drop_step w33 56 4 w33_c14 <|
    noThree_drop_step w33 60 4 w33_c15 <|
    noThree_drop_step w33 64 4 w33_c16 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w33_ok : noThree w33 = true ∧ inGrid 33 w33 = true ∧ w33.Nodup ∧ w33.length = 2 * 33 :=
  ⟨w33_noThree, by decide +kernel⟩

end Green72Data
