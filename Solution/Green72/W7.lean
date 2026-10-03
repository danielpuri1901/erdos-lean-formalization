import Solution.Green72.Chunk

/-! Kernel check of the N = 7 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w7_c0 : prefOk ((w7.drop 0).take 4) ((w7.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w7_c1 : prefOk ((w7.drop 4).take 4) ((w7.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w7_c2 : prefOk ((w7.drop 8).take 4) ((w7.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w7_c3 : prefOk ((w7.drop 12).take 4) ((w7.drop 12).drop 4) = true := by
  decide +kernel

theorem w7_noThree : noThree w7 = true := by
  have h : noThree (w7.drop 0) = true :=
    noThree_drop_step w7 0 4 w7_c0 <|
    noThree_drop_step w7 4 4 w7_c1 <|
    noThree_drop_step w7 8 4 w7_c2 <|
    noThree_drop_step w7 12 4 w7_c3 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w7_ok : noThree w7 = true ∧ inGrid 7 w7 = true ∧ w7.Nodup ∧ w7.length = 2 * 7 :=
  ⟨w7_noThree, by decide +kernel⟩

end Green72Data
