import Solution.Green72.Chunk

/-! Kernel check of the N = 19 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w19_c0 : prefOk ((w19.drop 0).take 4) ((w19.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c1 : prefOk ((w19.drop 4).take 4) ((w19.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c2 : prefOk ((w19.drop 8).take 4) ((w19.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c3 : prefOk ((w19.drop 12).take 4) ((w19.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c4 : prefOk ((w19.drop 16).take 4) ((w19.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c5 : prefOk ((w19.drop 20).take 4) ((w19.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c6 : prefOk ((w19.drop 24).take 4) ((w19.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c7 : prefOk ((w19.drop 28).take 4) ((w19.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c8 : prefOk ((w19.drop 32).take 4) ((w19.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c9 : prefOk ((w19.drop 36).take 4) ((w19.drop 36).drop 4) = true := by
  decide +kernel

theorem w19_noThree : noThree w19 = true := by
  have h : noThree (w19.drop 0) = true :=
    noThree_drop_step w19 0 4 w19_c0 <|
    noThree_drop_step w19 4 4 w19_c1 <|
    noThree_drop_step w19 8 4 w19_c2 <|
    noThree_drop_step w19 12 4 w19_c3 <|
    noThree_drop_step w19 16 4 w19_c4 <|
    noThree_drop_step w19 20 4 w19_c5 <|
    noThree_drop_step w19 24 4 w19_c6 <|
    noThree_drop_step w19 28 4 w19_c7 <|
    noThree_drop_step w19 32 4 w19_c8 <|
    noThree_drop_step w19 36 4 w19_c9 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w19_ok : noThree w19 = true ∧ inGrid 19 w19 = true ∧ w19.Nodup ∧ w19.length = 2 * 19 :=
  ⟨w19_noThree, by decide +kernel⟩

end Green72Data
