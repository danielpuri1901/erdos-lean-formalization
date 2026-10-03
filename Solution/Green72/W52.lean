import Solution.Green72.Chunk

/-! Kernel check of the N = 52 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w52_c0 : prefOk ((w52.drop 0).take 4) ((w52.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c1 : prefOk ((w52.drop 4).take 4) ((w52.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c2 : prefOk ((w52.drop 8).take 4) ((w52.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c3 : prefOk ((w52.drop 12).take 4) ((w52.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c4 : prefOk ((w52.drop 16).take 4) ((w52.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c5 : prefOk ((w52.drop 20).take 4) ((w52.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c6 : prefOk ((w52.drop 24).take 4) ((w52.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c7 : prefOk ((w52.drop 28).take 4) ((w52.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c8 : prefOk ((w52.drop 32).take 4) ((w52.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c9 : prefOk ((w52.drop 36).take 4) ((w52.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c10 : prefOk ((w52.drop 40).take 4) ((w52.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c11 : prefOk ((w52.drop 44).take 4) ((w52.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c12 : prefOk ((w52.drop 48).take 4) ((w52.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c13 : prefOk ((w52.drop 52).take 4) ((w52.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c14 : prefOk ((w52.drop 56).take 4) ((w52.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c15 : prefOk ((w52.drop 60).take 4) ((w52.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c16 : prefOk ((w52.drop 64).take 4) ((w52.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c17 : prefOk ((w52.drop 68).take 4) ((w52.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c18 : prefOk ((w52.drop 72).take 4) ((w52.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c19 : prefOk ((w52.drop 76).take 4) ((w52.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c20 : prefOk ((w52.drop 80).take 4) ((w52.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c21 : prefOk ((w52.drop 84).take 4) ((w52.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c22 : prefOk ((w52.drop 88).take 4) ((w52.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c23 : prefOk ((w52.drop 92).take 4) ((w52.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c24 : prefOk ((w52.drop 96).take 4) ((w52.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c25 : prefOk ((w52.drop 100).take 4) ((w52.drop 100).drop 4) = true := by
  decide +kernel

theorem w52_noThree : noThree w52 = true := by
  have h : noThree (w52.drop 0) = true :=
    noThree_drop_step w52 0 4 w52_c0 <|
    noThree_drop_step w52 4 4 w52_c1 <|
    noThree_drop_step w52 8 4 w52_c2 <|
    noThree_drop_step w52 12 4 w52_c3 <|
    noThree_drop_step w52 16 4 w52_c4 <|
    noThree_drop_step w52 20 4 w52_c5 <|
    noThree_drop_step w52 24 4 w52_c6 <|
    noThree_drop_step w52 28 4 w52_c7 <|
    noThree_drop_step w52 32 4 w52_c8 <|
    noThree_drop_step w52 36 4 w52_c9 <|
    noThree_drop_step w52 40 4 w52_c10 <|
    noThree_drop_step w52 44 4 w52_c11 <|
    noThree_drop_step w52 48 4 w52_c12 <|
    noThree_drop_step w52 52 4 w52_c13 <|
    noThree_drop_step w52 56 4 w52_c14 <|
    noThree_drop_step w52 60 4 w52_c15 <|
    noThree_drop_step w52 64 4 w52_c16 <|
    noThree_drop_step w52 68 4 w52_c17 <|
    noThree_drop_step w52 72 4 w52_c18 <|
    noThree_drop_step w52 76 4 w52_c19 <|
    noThree_drop_step w52 80 4 w52_c20 <|
    noThree_drop_step w52 84 4 w52_c21 <|
    noThree_drop_step w52 88 4 w52_c22 <|
    noThree_drop_step w52 92 4 w52_c23 <|
    noThree_drop_step w52 96 4 w52_c24 <|
    noThree_drop_step w52 100 4 w52_c25 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w52_ok : noThree w52 = true ∧ inGrid 52 w52 = true ∧ w52.Nodup ∧ w52.length = 2 * 52 :=
  ⟨w52_noThree, by decide +kernel⟩

end Green72Data
