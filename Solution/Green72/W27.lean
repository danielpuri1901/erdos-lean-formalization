import Solution.Green72.Chunk

/-! Kernel check of the N = 27 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w27_c0 : prefOk ((w27.drop 0).take 4) ((w27.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c1 : prefOk ((w27.drop 4).take 4) ((w27.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c2 : prefOk ((w27.drop 8).take 4) ((w27.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c3 : prefOk ((w27.drop 12).take 4) ((w27.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c4 : prefOk ((w27.drop 16).take 4) ((w27.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c5 : prefOk ((w27.drop 20).take 4) ((w27.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c6 : prefOk ((w27.drop 24).take 4) ((w27.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c7 : prefOk ((w27.drop 28).take 4) ((w27.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c8 : prefOk ((w27.drop 32).take 4) ((w27.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c9 : prefOk ((w27.drop 36).take 4) ((w27.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c10 : prefOk ((w27.drop 40).take 4) ((w27.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c11 : prefOk ((w27.drop 44).take 4) ((w27.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c12 : prefOk ((w27.drop 48).take 4) ((w27.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c13 : prefOk ((w27.drop 52).take 4) ((w27.drop 52).drop 4) = true := by
  decide +kernel

theorem w27_noThree : noThree w27 = true := by
  have h : noThree (w27.drop 0) = true :=
    noThree_drop_step w27 0 4 w27_c0 <|
    noThree_drop_step w27 4 4 w27_c1 <|
    noThree_drop_step w27 8 4 w27_c2 <|
    noThree_drop_step w27 12 4 w27_c3 <|
    noThree_drop_step w27 16 4 w27_c4 <|
    noThree_drop_step w27 20 4 w27_c5 <|
    noThree_drop_step w27 24 4 w27_c6 <|
    noThree_drop_step w27 28 4 w27_c7 <|
    noThree_drop_step w27 32 4 w27_c8 <|
    noThree_drop_step w27 36 4 w27_c9 <|
    noThree_drop_step w27 40 4 w27_c10 <|
    noThree_drop_step w27 44 4 w27_c11 <|
    noThree_drop_step w27 48 4 w27_c12 <|
    noThree_drop_step w27 52 4 w27_c13 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w27_ok : noThree w27 = true ∧ inGrid 27 w27 = true ∧ w27.Nodup ∧ w27.length = 2 * 27 :=
  ⟨w27_noThree, by decide +kernel⟩

end Green72Data
