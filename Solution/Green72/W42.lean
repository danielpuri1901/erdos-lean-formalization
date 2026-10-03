import Solution.Green72.Chunk

/-! Kernel check of the N = 42 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w42_c0 : prefOk ((w42.drop 0).take 4) ((w42.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c1 : prefOk ((w42.drop 4).take 4) ((w42.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c2 : prefOk ((w42.drop 8).take 4) ((w42.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c3 : prefOk ((w42.drop 12).take 4) ((w42.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c4 : prefOk ((w42.drop 16).take 4) ((w42.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c5 : prefOk ((w42.drop 20).take 4) ((w42.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c6 : prefOk ((w42.drop 24).take 4) ((w42.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c7 : prefOk ((w42.drop 28).take 4) ((w42.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c8 : prefOk ((w42.drop 32).take 4) ((w42.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c9 : prefOk ((w42.drop 36).take 4) ((w42.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c10 : prefOk ((w42.drop 40).take 4) ((w42.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c11 : prefOk ((w42.drop 44).take 4) ((w42.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c12 : prefOk ((w42.drop 48).take 4) ((w42.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c13 : prefOk ((w42.drop 52).take 4) ((w42.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c14 : prefOk ((w42.drop 56).take 4) ((w42.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c15 : prefOk ((w42.drop 60).take 4) ((w42.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c16 : prefOk ((w42.drop 64).take 4) ((w42.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c17 : prefOk ((w42.drop 68).take 4) ((w42.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c18 : prefOk ((w42.drop 72).take 4) ((w42.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c19 : prefOk ((w42.drop 76).take 4) ((w42.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c20 : prefOk ((w42.drop 80).take 4) ((w42.drop 80).drop 4) = true := by
  decide +kernel

theorem w42_noThree : noThree w42 = true := by
  have h : noThree (w42.drop 0) = true :=
    noThree_drop_step w42 0 4 w42_c0 <|
    noThree_drop_step w42 4 4 w42_c1 <|
    noThree_drop_step w42 8 4 w42_c2 <|
    noThree_drop_step w42 12 4 w42_c3 <|
    noThree_drop_step w42 16 4 w42_c4 <|
    noThree_drop_step w42 20 4 w42_c5 <|
    noThree_drop_step w42 24 4 w42_c6 <|
    noThree_drop_step w42 28 4 w42_c7 <|
    noThree_drop_step w42 32 4 w42_c8 <|
    noThree_drop_step w42 36 4 w42_c9 <|
    noThree_drop_step w42 40 4 w42_c10 <|
    noThree_drop_step w42 44 4 w42_c11 <|
    noThree_drop_step w42 48 4 w42_c12 <|
    noThree_drop_step w42 52 4 w42_c13 <|
    noThree_drop_step w42 56 4 w42_c14 <|
    noThree_drop_step w42 60 4 w42_c15 <|
    noThree_drop_step w42 64 4 w42_c16 <|
    noThree_drop_step w42 68 4 w42_c17 <|
    noThree_drop_step w42 72 4 w42_c18 <|
    noThree_drop_step w42 76 4 w42_c19 <|
    noThree_drop_step w42 80 4 w42_c20 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w42_ok : noThree w42 = true ∧ inGrid 42 w42 = true ∧ w42.Nodup ∧ w42.length = 2 * 42 :=
  ⟨w42_noThree, by decide +kernel⟩

end Green72Data
