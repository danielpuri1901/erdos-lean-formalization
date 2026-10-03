import Solution.Green72.Chunk

/-! Kernel check of the N = 32 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w32_c0 : prefOk ((w32.drop 0).take 4) ((w32.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c1 : prefOk ((w32.drop 4).take 4) ((w32.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c2 : prefOk ((w32.drop 8).take 4) ((w32.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c3 : prefOk ((w32.drop 12).take 4) ((w32.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c4 : prefOk ((w32.drop 16).take 4) ((w32.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c5 : prefOk ((w32.drop 20).take 4) ((w32.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c6 : prefOk ((w32.drop 24).take 4) ((w32.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c7 : prefOk ((w32.drop 28).take 4) ((w32.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c8 : prefOk ((w32.drop 32).take 4) ((w32.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c9 : prefOk ((w32.drop 36).take 4) ((w32.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c10 : prefOk ((w32.drop 40).take 4) ((w32.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c11 : prefOk ((w32.drop 44).take 4) ((w32.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c12 : prefOk ((w32.drop 48).take 4) ((w32.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c13 : prefOk ((w32.drop 52).take 4) ((w32.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c14 : prefOk ((w32.drop 56).take 4) ((w32.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c15 : prefOk ((w32.drop 60).take 4) ((w32.drop 60).drop 4) = true := by
  decide +kernel

theorem w32_noThree : noThree w32 = true := by
  have h : noThree (w32.drop 0) = true :=
    noThree_drop_step w32 0 4 w32_c0 <|
    noThree_drop_step w32 4 4 w32_c1 <|
    noThree_drop_step w32 8 4 w32_c2 <|
    noThree_drop_step w32 12 4 w32_c3 <|
    noThree_drop_step w32 16 4 w32_c4 <|
    noThree_drop_step w32 20 4 w32_c5 <|
    noThree_drop_step w32 24 4 w32_c6 <|
    noThree_drop_step w32 28 4 w32_c7 <|
    noThree_drop_step w32 32 4 w32_c8 <|
    noThree_drop_step w32 36 4 w32_c9 <|
    noThree_drop_step w32 40 4 w32_c10 <|
    noThree_drop_step w32 44 4 w32_c11 <|
    noThree_drop_step w32 48 4 w32_c12 <|
    noThree_drop_step w32 52 4 w32_c13 <|
    noThree_drop_step w32 56 4 w32_c14 <|
    noThree_drop_step w32 60 4 w32_c15 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w32_ok : noThree w32 = true ∧ inGrid 32 w32 = true ∧ w32.Nodup ∧ w32.length = 2 * 32 :=
  ⟨w32_noThree, by decide +kernel⟩

end Green72Data
