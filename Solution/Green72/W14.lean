import Solution.Green72.Chunk

/-! Kernel check of the N = 14 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w14_c0 : prefOk ((w14.drop 0).take 4) ((w14.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w14_c1 : prefOk ((w14.drop 4).take 4) ((w14.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w14_c2 : prefOk ((w14.drop 8).take 4) ((w14.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w14_c3 : prefOk ((w14.drop 12).take 4) ((w14.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w14_c4 : prefOk ((w14.drop 16).take 4) ((w14.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w14_c5 : prefOk ((w14.drop 20).take 4) ((w14.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w14_c6 : prefOk ((w14.drop 24).take 4) ((w14.drop 24).drop 4) = true := by
  decide +kernel

theorem w14_noThree : noThree w14 = true := by
  have h : noThree (w14.drop 0) = true :=
    noThree_drop_step w14 0 4 w14_c0 <|
    noThree_drop_step w14 4 4 w14_c1 <|
    noThree_drop_step w14 8 4 w14_c2 <|
    noThree_drop_step w14 12 4 w14_c3 <|
    noThree_drop_step w14 16 4 w14_c4 <|
    noThree_drop_step w14 20 4 w14_c5 <|
    noThree_drop_step w14 24 4 w14_c6 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w14_ok : noThree w14 = true ∧ inGrid 14 w14 = true ∧ w14.Nodup ∧ w14.length = 2 * 14 :=
  ⟨w14_noThree, by decide +kernel⟩

end Green72Data
