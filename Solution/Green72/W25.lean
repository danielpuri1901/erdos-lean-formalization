import Solution.Green72.Chunk

/-! Kernel check of the N = 25 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w25_c0 : prefOk ((w25.drop 0).take 4) ((w25.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c1 : prefOk ((w25.drop 4).take 4) ((w25.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c2 : prefOk ((w25.drop 8).take 4) ((w25.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c3 : prefOk ((w25.drop 12).take 4) ((w25.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c4 : prefOk ((w25.drop 16).take 4) ((w25.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c5 : prefOk ((w25.drop 20).take 4) ((w25.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c6 : prefOk ((w25.drop 24).take 4) ((w25.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c7 : prefOk ((w25.drop 28).take 4) ((w25.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c8 : prefOk ((w25.drop 32).take 4) ((w25.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c9 : prefOk ((w25.drop 36).take 4) ((w25.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c10 : prefOk ((w25.drop 40).take 4) ((w25.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c11 : prefOk ((w25.drop 44).take 4) ((w25.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c12 : prefOk ((w25.drop 48).take 4) ((w25.drop 48).drop 4) = true := by
  decide +kernel

theorem w25_noThree : noThree w25 = true := by
  have h : noThree (w25.drop 0) = true :=
    noThree_drop_step w25 0 4 w25_c0 <|
    noThree_drop_step w25 4 4 w25_c1 <|
    noThree_drop_step w25 8 4 w25_c2 <|
    noThree_drop_step w25 12 4 w25_c3 <|
    noThree_drop_step w25 16 4 w25_c4 <|
    noThree_drop_step w25 20 4 w25_c5 <|
    noThree_drop_step w25 24 4 w25_c6 <|
    noThree_drop_step w25 28 4 w25_c7 <|
    noThree_drop_step w25 32 4 w25_c8 <|
    noThree_drop_step w25 36 4 w25_c9 <|
    noThree_drop_step w25 40 4 w25_c10 <|
    noThree_drop_step w25 44 4 w25_c11 <|
    noThree_drop_step w25 48 4 w25_c12 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w25_ok : noThree w25 = true ∧ inGrid 25 w25 = true ∧ w25.Nodup ∧ w25.length = 2 * 25 :=
  ⟨w25_noThree, by decide +kernel⟩

end Green72Data
