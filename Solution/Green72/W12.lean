import Solution.Green72.Chunk

/-! Kernel check of the N = 12 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w12_c0 : prefOk ((w12.drop 0).take 4) ((w12.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w12_c1 : prefOk ((w12.drop 4).take 4) ((w12.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w12_c2 : prefOk ((w12.drop 8).take 4) ((w12.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w12_c3 : prefOk ((w12.drop 12).take 4) ((w12.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w12_c4 : prefOk ((w12.drop 16).take 4) ((w12.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w12_c5 : prefOk ((w12.drop 20).take 4) ((w12.drop 20).drop 4) = true := by
  decide +kernel

theorem w12_noThree : noThree w12 = true := by
  have h : noThree (w12.drop 0) = true :=
    noThree_drop_step w12 0 4 w12_c0 <|
    noThree_drop_step w12 4 4 w12_c1 <|
    noThree_drop_step w12 8 4 w12_c2 <|
    noThree_drop_step w12 12 4 w12_c3 <|
    noThree_drop_step w12 16 4 w12_c4 <|
    noThree_drop_step w12 20 4 w12_c5 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w12_ok : noThree w12 = true ∧ inGrid 12 w12 = true ∧ w12.Nodup ∧ w12.length = 2 * 12 :=
  ⟨w12_noThree, by decide +kernel⟩

end Green72Data
