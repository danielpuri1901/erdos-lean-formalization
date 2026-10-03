import Solution.Green72.Chunk

/-! Kernel check of the N = 3 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w3_c0 : prefOk ((w3.drop 0).take 4) ((w3.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w3_c1 : prefOk ((w3.drop 4).take 4) ((w3.drop 4).drop 4) = true := by
  decide +kernel

theorem w3_noThree : noThree w3 = true := by
  have h : noThree (w3.drop 0) = true :=
    noThree_drop_step w3 0 4 w3_c0 <|
    noThree_drop_step w3 4 4 w3_c1 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w3_ok : noThree w3 = true ∧ inGrid 3 w3 = true ∧ w3.Nodup ∧ w3.length = 2 * 3 :=
  ⟨w3_noThree, by decide +kernel⟩

end Green72Data
