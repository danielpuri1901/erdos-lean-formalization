import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 53, split into 25 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w53_s0 : segOk (w53.drop 0) 1 = true := by
  decide +kernel

theorem w53_s1 : segOk (w53.drop 1) 1 = true := by
  decide +kernel

theorem w53_s2 : segOk (w53.drop 2) 1 = true := by
  decide +kernel

theorem w53_s3 : segOk (w53.drop 3) 1 = true := by
  decide +kernel

theorem w53_s4 : segOk (w53.drop 4) 1 = true := by
  decide +kernel

theorem w53_s5 : segOk (w53.drop 5) 2 = true := by
  decide +kernel

theorem w53_s6 : segOk (w53.drop 7) 2 = true := by
  decide +kernel

theorem w53_s7 : segOk (w53.drop 9) 2 = true := by
  decide +kernel

theorem w53_s8 : segOk (w53.drop 11) 2 = true := by
  decide +kernel

theorem w53_s9 : segOk (w53.drop 13) 2 = true := by
  decide +kernel

theorem w53_s10 : segOk (w53.drop 15) 2 = true := by
  decide +kernel

theorem w53_s11 : segOk (w53.drop 17) 2 = true := by
  decide +kernel

theorem w53_s12 : segOk (w53.drop 19) 2 = true := by
  decide +kernel

theorem w53_s13 : segOk (w53.drop 21) 2 = true := by
  decide +kernel

theorem w53_s14 : segOk (w53.drop 23) 3 = true := by
  decide +kernel

theorem w53_s15 : segOk (w53.drop 26) 3 = true := by
  decide +kernel

theorem w53_s16 : segOk (w53.drop 29) 3 = true := by
  decide +kernel

theorem w53_s17 : segOk (w53.drop 32) 3 = true := by
  decide +kernel

theorem w53_s18 : segOk (w53.drop 35) 4 = true := by
  decide +kernel

theorem w53_s19 : segOk (w53.drop 39) 4 = true := by
  decide +kernel

theorem w53_s20 : segOk (w53.drop 43) 5 = true := by
  decide +kernel

theorem w53_s21 : segOk (w53.drop 48) 6 = true := by
  decide +kernel

theorem w53_s22 : segOk (w53.drop 54) 8 = true := by
  decide +kernel

theorem w53_s23 : segOk (w53.drop 62) 14 = true := by
  decide +kernel

theorem w53_s24 : segOk (w53.drop 76) 30 = true := by
  decide +kernel

theorem w53_end : noThree (w53.drop 106) = true := by
  decide +kernel

theorem w53_noThree : noThree (w53.drop 0) = true :=
  chain (a := 0) (k := 1) w53_s0
    (chain (a := 1) (k := 1) w53_s1
    (chain (a := 2) (k := 1) w53_s2
    (chain (a := 3) (k := 1) w53_s3
    (chain (a := 4) (k := 1) w53_s4
    (chain (a := 5) (k := 2) w53_s5
    (chain (a := 7) (k := 2) w53_s6
    (chain (a := 9) (k := 2) w53_s7
    (chain (a := 11) (k := 2) w53_s8
    (chain (a := 13) (k := 2) w53_s9
    (chain (a := 15) (k := 2) w53_s10
    (chain (a := 17) (k := 2) w53_s11
    (chain (a := 19) (k := 2) w53_s12
    (chain (a := 21) (k := 2) w53_s13
    (chain (a := 23) (k := 3) w53_s14
    (chain (a := 26) (k := 3) w53_s15
    (chain (a := 29) (k := 3) w53_s16
    (chain (a := 32) (k := 3) w53_s17
    (chain (a := 35) (k := 4) w53_s18
    (chain (a := 39) (k := 4) w53_s19
    (chain (a := 43) (k := 5) w53_s20
    (chain (a := 48) (k := 6) w53_s21
    (chain (a := 54) (k := 8) w53_s22
    (chain (a := 62) (k := 14) w53_s23
    (chain (a := 76) (k := 30) w53_s24
    (w53_end)))))))))))))))))))))))))

theorem w53_rest : inGrid 53 w53 = true ∧ w53.Nodup ∧ w53.length = 2 * 53 := by
  decide +kernel

theorem w53_ok : noThree w53 = true ∧ inGrid 53 w53 = true ∧ w53.Nodup ∧ w53.length = 2 * 53 :=
  ⟨w53_noThree, w53_rest⟩

end Green72Data
