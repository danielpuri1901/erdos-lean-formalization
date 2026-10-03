import Solution.Green72.Chunk

/-! Kernel check of the N = 8 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w8_c0 : prefOk ((w8.drop 0).take 4) ((w8.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w8_c1 : prefOk ((w8.drop 4).take 4) ((w8.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w8_c2 : prefOk ((w8.drop 8).take 4) ((w8.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w8_c3 : prefOk ((w8.drop 12).take 4) ((w8.drop 12).drop 4) = true := by
  decide +kernel

theorem w8_noThree : noThree w8 = true := by
  have h : noThree (w8.drop 0) = true :=
    noThree_drop_step w8 0 4 w8_c0 <|
    noThree_drop_step w8 4 4 w8_c1 <|
    noThree_drop_step w8 8 4 w8_c2 <|
    noThree_drop_step w8 12 4 w8_c3 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w8_ok : noThree w8 = true ∧ inGrid 8 w8 = true ∧ w8.Nodup ∧ w8.length = 2 * 8 :=
  ⟨w8_noThree, by decide +kernel⟩

end Green72Data
