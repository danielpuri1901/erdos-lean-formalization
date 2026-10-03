import Solution.Green72.Chunk

/-! Kernel check of the N = 16 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w16_c0 : prefOk ((w16.drop 0).take 4) ((w16.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w16_c1 : prefOk ((w16.drop 4).take 4) ((w16.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w16_c2 : prefOk ((w16.drop 8).take 4) ((w16.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w16_c3 : prefOk ((w16.drop 12).take 4) ((w16.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w16_c4 : prefOk ((w16.drop 16).take 4) ((w16.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w16_c5 : prefOk ((w16.drop 20).take 4) ((w16.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w16_c6 : prefOk ((w16.drop 24).take 4) ((w16.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w16_c7 : prefOk ((w16.drop 28).take 4) ((w16.drop 28).drop 4) = true := by
  decide +kernel

theorem w16_noThree : noThree w16 = true := by
  have h : noThree (w16.drop 0) = true :=
    noThree_drop_step w16 0 4 w16_c0 <|
    noThree_drop_step w16 4 4 w16_c1 <|
    noThree_drop_step w16 8 4 w16_c2 <|
    noThree_drop_step w16 12 4 w16_c3 <|
    noThree_drop_step w16 16 4 w16_c4 <|
    noThree_drop_step w16 20 4 w16_c5 <|
    noThree_drop_step w16 24 4 w16_c6 <|
    noThree_drop_step w16 28 4 w16_c7 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w16_ok : noThree w16 = true ∧ inGrid 16 w16 = true ∧ w16.Nodup ∧ w16.length = 2 * 16 :=
  ⟨w16_noThree, by decide +kernel⟩

end Green72Data
