import Solution.Green72.Chunk

/-! Kernel check of the N = 53 witness for Green 72, split into chunks of 4 points. -/

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w53_c0 : prefOk ((w53.drop 0).take 4) ((w53.drop 0).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c1 : prefOk ((w53.drop 4).take 4) ((w53.drop 4).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c2 : prefOk ((w53.drop 8).take 4) ((w53.drop 8).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c3 : prefOk ((w53.drop 12).take 4) ((w53.drop 12).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c4 : prefOk ((w53.drop 16).take 4) ((w53.drop 16).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c5 : prefOk ((w53.drop 20).take 4) ((w53.drop 20).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c6 : prefOk ((w53.drop 24).take 4) ((w53.drop 24).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c7 : prefOk ((w53.drop 28).take 4) ((w53.drop 28).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c8 : prefOk ((w53.drop 32).take 4) ((w53.drop 32).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c9 : prefOk ((w53.drop 36).take 4) ((w53.drop 36).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c10 : prefOk ((w53.drop 40).take 4) ((w53.drop 40).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c11 : prefOk ((w53.drop 44).take 4) ((w53.drop 44).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c12 : prefOk ((w53.drop 48).take 4) ((w53.drop 48).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c13 : prefOk ((w53.drop 52).take 4) ((w53.drop 52).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c14 : prefOk ((w53.drop 56).take 4) ((w53.drop 56).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c15 : prefOk ((w53.drop 60).take 4) ((w53.drop 60).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c16 : prefOk ((w53.drop 64).take 4) ((w53.drop 64).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c17 : prefOk ((w53.drop 68).take 4) ((w53.drop 68).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c18 : prefOk ((w53.drop 72).take 4) ((w53.drop 72).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c19 : prefOk ((w53.drop 76).take 4) ((w53.drop 76).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c20 : prefOk ((w53.drop 80).take 4) ((w53.drop 80).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c21 : prefOk ((w53.drop 84).take 4) ((w53.drop 84).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c22 : prefOk ((w53.drop 88).take 4) ((w53.drop 88).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c23 : prefOk ((w53.drop 92).take 4) ((w53.drop 92).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c24 : prefOk ((w53.drop 96).take 4) ((w53.drop 96).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c25 : prefOk ((w53.drop 100).take 4) ((w53.drop 100).drop 4) = true := by
  decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c26 : prefOk ((w53.drop 104).take 4) ((w53.drop 104).drop 4) = true := by
  decide +kernel

theorem w53_noThree : noThree w53 = true := by
  have h : noThree (w53.drop 0) = true :=
    noThree_drop_step w53 0 4 w53_c0 <|
    noThree_drop_step w53 4 4 w53_c1 <|
    noThree_drop_step w53 8 4 w53_c2 <|
    noThree_drop_step w53 12 4 w53_c3 <|
    noThree_drop_step w53 16 4 w53_c4 <|
    noThree_drop_step w53 20 4 w53_c5 <|
    noThree_drop_step w53 24 4 w53_c6 <|
    noThree_drop_step w53 28 4 w53_c7 <|
    noThree_drop_step w53 32 4 w53_c8 <|
    noThree_drop_step w53 36 4 w53_c9 <|
    noThree_drop_step w53 40 4 w53_c10 <|
    noThree_drop_step w53 44 4 w53_c11 <|
    noThree_drop_step w53 48 4 w53_c12 <|
    noThree_drop_step w53 52 4 w53_c13 <|
    noThree_drop_step w53 56 4 w53_c14 <|
    noThree_drop_step w53 60 4 w53_c15 <|
    noThree_drop_step w53 64 4 w53_c16 <|
    noThree_drop_step w53 68 4 w53_c17 <|
    noThree_drop_step w53 72 4 w53_c18 <|
    noThree_drop_step w53 76 4 w53_c19 <|
    noThree_drop_step w53 80 4 w53_c20 <|
    noThree_drop_step w53 84 4 w53_c21 <|
    noThree_drop_step w53 88 4 w53_c22 <|
    noThree_drop_step w53 92 4 w53_c23 <|
    noThree_drop_step w53 96 4 w53_c24 <|
    noThree_drop_step w53 100 4 w53_c25 <|
    noThree_drop_step w53 104 4 w53_c26 <|
    (by decide +kernel)
  simpa using h

set_option maxRecDepth 100000 in
theorem w53_ok : noThree w53 = true ∧ inGrid 53 w53 = true ∧ w53.Nodup ∧ w53.length = 2 * 53 :=
  ⟨w53_noThree, by decide +kernel⟩

end Green72Data
