import Solution.Green72.Chunk

/-! Kernel check of the N = 21 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w21_c0 : prefOk ((w21.drop 0).take 4) ((w21.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c1 : prefOk ((w21.drop 4).take 4) ((w21.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c2 : prefOk ((w21.drop 8).take 4) ((w21.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c3 : prefOk ((w21.drop 12).take 4) ((w21.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c4 : prefOk ((w21.drop 16).take 4) ((w21.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c5 : prefOk ((w21.drop 20).take 4) ((w21.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c6 : prefOk ((w21.drop 24).take 4) ((w21.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c7 : prefOk ((w21.drop 28).take 4) ((w21.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c8 : prefOk ((w21.drop 32).take 4) ((w21.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c9 : prefOk ((w21.drop 36).take 4) ((w21.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c10 : prefOk ((w21.drop 40).take 4) ((w21.drop 40).drop 4) = true := by
  decide +kernel

theorem w21_noThree : noThree w21 = true := by
  have h : noThree (w21.drop 0) = true :=
    noThree_drop_step w21 0 4 w21_c0 <|
    noThree_drop_step w21 4 4 w21_c1 <|
    noThree_drop_step w21 8 4 w21_c2 <|
    noThree_drop_step w21 12 4 w21_c3 <|
    noThree_drop_step w21 16 4 w21_c4 <|
    noThree_drop_step w21 20 4 w21_c5 <|
    noThree_drop_step w21 24 4 w21_c6 <|
    noThree_drop_step w21 28 4 w21_c7 <|
    noThree_drop_step w21 32 4 w21_c8 <|
    noThree_drop_step w21 36 4 w21_c9 <|
    noThree_drop_step w21 40 4 w21_c10 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w21_ok : noThree w21 = true ∧ inGrid 21 w21 = true ∧ w21.Nodup ∧ w21.length = 2 * 21 :=
  ⟨w21_noThree, by decide +kernel⟩

end Green72Data
