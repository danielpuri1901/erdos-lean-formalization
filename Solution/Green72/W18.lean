import Solution.Green72.Chunk

/-! Kernel check of the N = 18 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w18_c0 : prefOk ((w18.drop 0).take 4) ((w18.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c1 : prefOk ((w18.drop 4).take 4) ((w18.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c2 : prefOk ((w18.drop 8).take 4) ((w18.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c3 : prefOk ((w18.drop 12).take 4) ((w18.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c4 : prefOk ((w18.drop 16).take 4) ((w18.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c5 : prefOk ((w18.drop 20).take 4) ((w18.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c6 : prefOk ((w18.drop 24).take 4) ((w18.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c7 : prefOk ((w18.drop 28).take 4) ((w18.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w18_c8 : prefOk ((w18.drop 32).take 4) ((w18.drop 32).drop 4) = true := by
  decide +kernel

theorem w18_noThree : noThree w18 = true := by
  have h : noThree (w18.drop 0) = true :=
    noThree_drop_step w18 0 4 w18_c0 <|
    noThree_drop_step w18 4 4 w18_c1 <|
    noThree_drop_step w18 8 4 w18_c2 <|
    noThree_drop_step w18 12 4 w18_c3 <|
    noThree_drop_step w18 16 4 w18_c4 <|
    noThree_drop_step w18 20 4 w18_c5 <|
    noThree_drop_step w18 24 4 w18_c6 <|
    noThree_drop_step w18 28 4 w18_c7 <|
    noThree_drop_step w18 32 4 w18_c8 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w18_ok : noThree w18 = true ∧ inGrid 18 w18 = true ∧ w18.Nodup ∧ w18.length = 2 * 18 :=
  ⟨w18_noThree, by decide +kernel⟩

end Green72Data
