import Solution.Green72.Chunk

/-! Kernel check of the N = 13 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w13_c0 : prefOk ((w13.drop 0).take 4) ((w13.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w13_c1 : prefOk ((w13.drop 4).take 4) ((w13.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w13_c2 : prefOk ((w13.drop 8).take 4) ((w13.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w13_c3 : prefOk ((w13.drop 12).take 4) ((w13.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w13_c4 : prefOk ((w13.drop 16).take 4) ((w13.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w13_c5 : prefOk ((w13.drop 20).take 4) ((w13.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w13_c6 : prefOk ((w13.drop 24).take 4) ((w13.drop 24).drop 4) = true := by
  decide +kernel

theorem w13_noThree : noThree w13 = true := by
  have h : noThree (w13.drop 0) = true :=
    noThree_drop_step w13 0 4 w13_c0 <|
    noThree_drop_step w13 4 4 w13_c1 <|
    noThree_drop_step w13 8 4 w13_c2 <|
    noThree_drop_step w13 12 4 w13_c3 <|
    noThree_drop_step w13 16 4 w13_c4 <|
    noThree_drop_step w13 20 4 w13_c5 <|
    noThree_drop_step w13 24 4 w13_c6 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w13_ok : noThree w13 = true ∧ inGrid 13 w13 = true ∧ w13.Nodup ∧ w13.length = 2 * 13 :=
  ⟨w13_noThree, by decide +kernel⟩

end Green72Data
