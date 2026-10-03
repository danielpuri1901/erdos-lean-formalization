import Solution.Green72.Chunk

/-! Kernel check of the N = 6 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w6_c0 : prefOk ((w6.drop 0).take 4) ((w6.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w6_c1 : prefOk ((w6.drop 4).take 4) ((w6.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w6_c2 : prefOk ((w6.drop 8).take 4) ((w6.drop 8).drop 4) = true := by
  decide +kernel

theorem w6_noThree : noThree w6 = true := by
  have h : noThree (w6.drop 0) = true :=
    noThree_drop_step w6 0 4 w6_c0 <|
    noThree_drop_step w6 4 4 w6_c1 <|
    noThree_drop_step w6 8 4 w6_c2 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w6_ok : noThree w6 = true ∧ inGrid 6 w6 = true ∧ w6.Nodup ∧ w6.length = 2 * 6 :=
  ⟨w6_noThree, by decide +kernel⟩

end Green72Data
