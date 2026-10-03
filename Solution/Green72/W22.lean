import Solution.Green72.Chunk

/-! Kernel check of the N = 22 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w22_c0 : prefOk ((w22.drop 0).take 4) ((w22.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c1 : prefOk ((w22.drop 4).take 4) ((w22.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c2 : prefOk ((w22.drop 8).take 4) ((w22.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c3 : prefOk ((w22.drop 12).take 4) ((w22.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c4 : prefOk ((w22.drop 16).take 4) ((w22.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c5 : prefOk ((w22.drop 20).take 4) ((w22.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c6 : prefOk ((w22.drop 24).take 4) ((w22.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c7 : prefOk ((w22.drop 28).take 4) ((w22.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c8 : prefOk ((w22.drop 32).take 4) ((w22.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c9 : prefOk ((w22.drop 36).take 4) ((w22.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c10 : prefOk ((w22.drop 40).take 4) ((w22.drop 40).drop 4) = true := by
  decide +kernel

theorem w22_noThree : noThree w22 = true := by
  have h : noThree (w22.drop 0) = true :=
    noThree_drop_step w22 0 4 w22_c0 <|
    noThree_drop_step w22 4 4 w22_c1 <|
    noThree_drop_step w22 8 4 w22_c2 <|
    noThree_drop_step w22 12 4 w22_c3 <|
    noThree_drop_step w22 16 4 w22_c4 <|
    noThree_drop_step w22 20 4 w22_c5 <|
    noThree_drop_step w22 24 4 w22_c6 <|
    noThree_drop_step w22 28 4 w22_c7 <|
    noThree_drop_step w22 32 4 w22_c8 <|
    noThree_drop_step w22 36 4 w22_c9 <|
    noThree_drop_step w22 40 4 w22_c10 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w22_ok : noThree w22 = true ∧ inGrid 22 w22 = true ∧ w22.Nodup ∧ w22.length = 2 * 22 :=
  ⟨w22_noThree, by decide +kernel⟩

end Green72Data
