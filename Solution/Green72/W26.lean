import Solution.Green72.Chunk

/-! Kernel check of the N = 26 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w26_c0 : prefOk ((w26.drop 0).take 4) ((w26.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c1 : prefOk ((w26.drop 4).take 4) ((w26.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c2 : prefOk ((w26.drop 8).take 4) ((w26.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c3 : prefOk ((w26.drop 12).take 4) ((w26.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c4 : prefOk ((w26.drop 16).take 4) ((w26.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c5 : prefOk ((w26.drop 20).take 4) ((w26.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c6 : prefOk ((w26.drop 24).take 4) ((w26.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c7 : prefOk ((w26.drop 28).take 4) ((w26.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c8 : prefOk ((w26.drop 32).take 4) ((w26.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c9 : prefOk ((w26.drop 36).take 4) ((w26.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c10 : prefOk ((w26.drop 40).take 4) ((w26.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c11 : prefOk ((w26.drop 44).take 4) ((w26.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c12 : prefOk ((w26.drop 48).take 4) ((w26.drop 48).drop 4) = true := by
  decide +kernel

theorem w26_noThree : noThree w26 = true := by
  have h : noThree (w26.drop 0) = true :=
    noThree_drop_step w26 0 4 w26_c0 <|
    noThree_drop_step w26 4 4 w26_c1 <|
    noThree_drop_step w26 8 4 w26_c2 <|
    noThree_drop_step w26 12 4 w26_c3 <|
    noThree_drop_step w26 16 4 w26_c4 <|
    noThree_drop_step w26 20 4 w26_c5 <|
    noThree_drop_step w26 24 4 w26_c6 <|
    noThree_drop_step w26 28 4 w26_c7 <|
    noThree_drop_step w26 32 4 w26_c8 <|
    noThree_drop_step w26 36 4 w26_c9 <|
    noThree_drop_step w26 40 4 w26_c10 <|
    noThree_drop_step w26 44 4 w26_c11 <|
    noThree_drop_step w26 48 4 w26_c12 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w26_ok : noThree w26 = true ∧ inGrid 26 w26 = true ∧ w26.Nodup ∧ w26.length = 2 * 26 :=
  ⟨w26_noThree, by decide +kernel⟩

end Green72Data
