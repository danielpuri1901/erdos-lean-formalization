import Solution.Green72.Chunk

/-! Kernel check of the N = 20 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w20_c0 : prefOk ((w20.drop 0).take 4) ((w20.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c1 : prefOk ((w20.drop 4).take 4) ((w20.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c2 : prefOk ((w20.drop 8).take 4) ((w20.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c3 : prefOk ((w20.drop 12).take 4) ((w20.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c4 : prefOk ((w20.drop 16).take 4) ((w20.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c5 : prefOk ((w20.drop 20).take 4) ((w20.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c6 : prefOk ((w20.drop 24).take 4) ((w20.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c7 : prefOk ((w20.drop 28).take 4) ((w20.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c8 : prefOk ((w20.drop 32).take 4) ((w20.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c9 : prefOk ((w20.drop 36).take 4) ((w20.drop 36).drop 4) = true := by
  decide +kernel

theorem w20_noThree : noThree w20 = true := by
  have h : noThree (w20.drop 0) = true :=
    noThree_drop_step w20 0 4 w20_c0 <|
    noThree_drop_step w20 4 4 w20_c1 <|
    noThree_drop_step w20 8 4 w20_c2 <|
    noThree_drop_step w20 12 4 w20_c3 <|
    noThree_drop_step w20 16 4 w20_c4 <|
    noThree_drop_step w20 20 4 w20_c5 <|
    noThree_drop_step w20 24 4 w20_c6 <|
    noThree_drop_step w20 28 4 w20_c7 <|
    noThree_drop_step w20 32 4 w20_c8 <|
    noThree_drop_step w20 36 4 w20_c9 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w20_ok : noThree w20 = true ∧ inGrid 20 w20 = true ∧ w20.Nodup ∧ w20.length = 2 * 20 :=
  ⟨w20_noThree, by decide +kernel⟩

end Green72Data
