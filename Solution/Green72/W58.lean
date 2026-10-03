import Solution.Green72.Chunk

/-! Kernel check of the N = 58 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w58_c0 : prefOk ((w58.drop 0).take 4) ((w58.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c1 : prefOk ((w58.drop 4).take 4) ((w58.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c2 : prefOk ((w58.drop 8).take 4) ((w58.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c3 : prefOk ((w58.drop 12).take 4) ((w58.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c4 : prefOk ((w58.drop 16).take 4) ((w58.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c5 : prefOk ((w58.drop 20).take 4) ((w58.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c6 : prefOk ((w58.drop 24).take 4) ((w58.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c7 : prefOk ((w58.drop 28).take 4) ((w58.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c8 : prefOk ((w58.drop 32).take 4) ((w58.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c9 : prefOk ((w58.drop 36).take 4) ((w58.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c10 : prefOk ((w58.drop 40).take 4) ((w58.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c11 : prefOk ((w58.drop 44).take 4) ((w58.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c12 : prefOk ((w58.drop 48).take 4) ((w58.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c13 : prefOk ((w58.drop 52).take 4) ((w58.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c14 : prefOk ((w58.drop 56).take 4) ((w58.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c15 : prefOk ((w58.drop 60).take 4) ((w58.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c16 : prefOk ((w58.drop 64).take 4) ((w58.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c17 : prefOk ((w58.drop 68).take 4) ((w58.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c18 : prefOk ((w58.drop 72).take 4) ((w58.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c19 : prefOk ((w58.drop 76).take 4) ((w58.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c20 : prefOk ((w58.drop 80).take 4) ((w58.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c21 : prefOk ((w58.drop 84).take 4) ((w58.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c22 : prefOk ((w58.drop 88).take 4) ((w58.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c23 : prefOk ((w58.drop 92).take 4) ((w58.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c24 : prefOk ((w58.drop 96).take 4) ((w58.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c25 : prefOk ((w58.drop 100).take 4) ((w58.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c26 : prefOk ((w58.drop 104).take 4) ((w58.drop 104).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c27 : prefOk ((w58.drop 108).take 4) ((w58.drop 108).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c28 : prefOk ((w58.drop 112).take 4) ((w58.drop 112).drop 4) = true := by
  decide +kernel

theorem w58_noThree : noThree w58 = true := by
  have h : noThree (w58.drop 0) = true :=
    noThree_drop_step w58 0 4 w58_c0 <|
    noThree_drop_step w58 4 4 w58_c1 <|
    noThree_drop_step w58 8 4 w58_c2 <|
    noThree_drop_step w58 12 4 w58_c3 <|
    noThree_drop_step w58 16 4 w58_c4 <|
    noThree_drop_step w58 20 4 w58_c5 <|
    noThree_drop_step w58 24 4 w58_c6 <|
    noThree_drop_step w58 28 4 w58_c7 <|
    noThree_drop_step w58 32 4 w58_c8 <|
    noThree_drop_step w58 36 4 w58_c9 <|
    noThree_drop_step w58 40 4 w58_c10 <|
    noThree_drop_step w58 44 4 w58_c11 <|
    noThree_drop_step w58 48 4 w58_c12 <|
    noThree_drop_step w58 52 4 w58_c13 <|
    noThree_drop_step w58 56 4 w58_c14 <|
    noThree_drop_step w58 60 4 w58_c15 <|
    noThree_drop_step w58 64 4 w58_c16 <|
    noThree_drop_step w58 68 4 w58_c17 <|
    noThree_drop_step w58 72 4 w58_c18 <|
    noThree_drop_step w58 76 4 w58_c19 <|
    noThree_drop_step w58 80 4 w58_c20 <|
    noThree_drop_step w58 84 4 w58_c21 <|
    noThree_drop_step w58 88 4 w58_c22 <|
    noThree_drop_step w58 92 4 w58_c23 <|
    noThree_drop_step w58 96 4 w58_c24 <|
    noThree_drop_step w58 100 4 w58_c25 <|
    noThree_drop_step w58 104 4 w58_c26 <|
    noThree_drop_step w58 108 4 w58_c27 <|
    noThree_drop_step w58 112 4 w58_c28 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w58_ok : noThree w58 = true ∧ inGrid 58 w58 = true ∧ w58.Nodup ∧ w58.length = 2 * 58 :=
  ⟨w58_noThree, by decide +kernel⟩

end Green72Data
