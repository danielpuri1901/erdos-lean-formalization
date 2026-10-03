import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 55, split into 29 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w55_s0 : segOk (w55.drop 0) 1 = true := by
  decide +kernel

theorem w55_s1 : segOk (w55.drop 1) 1 = true := by
  decide +kernel

theorem w55_s2 : segOk (w55.drop 2) 1 = true := by
  decide +kernel

theorem w55_s3 : segOk (w55.drop 3) 1 = true := by
  decide +kernel

theorem w55_s4 : segOk (w55.drop 4) 1 = true := by
  decide +kernel

theorem w55_s5 : segOk (w55.drop 5) 1 = true := by
  decide +kernel

theorem w55_s6 : segOk (w55.drop 6) 1 = true := by
  decide +kernel

theorem w55_s7 : segOk (w55.drop 7) 1 = true := by
  decide +kernel

theorem w55_s8 : segOk (w55.drop 8) 1 = true := by
  decide +kernel

theorem w55_s9 : segOk (w55.drop 9) 2 = true := by
  decide +kernel

theorem w55_s10 : segOk (w55.drop 11) 2 = true := by
  decide +kernel

theorem w55_s11 : segOk (w55.drop 13) 2 = true := by
  decide +kernel

theorem w55_s12 : segOk (w55.drop 15) 2 = true := by
  decide +kernel

theorem w55_s13 : segOk (w55.drop 17) 2 = true := by
  decide +kernel

theorem w55_s14 : segOk (w55.drop 19) 2 = true := by
  decide +kernel

theorem w55_s15 : segOk (w55.drop 21) 2 = true := by
  decide +kernel

theorem w55_s16 : segOk (w55.drop 23) 2 = true := by
  decide +kernel

theorem w55_s17 : segOk (w55.drop 25) 2 = true := by
  decide +kernel

theorem w55_s18 : segOk (w55.drop 27) 3 = true := by
  decide +kernel

theorem w55_s19 : segOk (w55.drop 30) 3 = true := by
  decide +kernel

theorem w55_s20 : segOk (w55.drop 33) 3 = true := by
  decide +kernel

theorem w55_s21 : segOk (w55.drop 36) 3 = true := by
  decide +kernel

theorem w55_s22 : segOk (w55.drop 39) 4 = true := by
  decide +kernel

theorem w55_s23 : segOk (w55.drop 43) 4 = true := by
  decide +kernel

theorem w55_s24 : segOk (w55.drop 47) 5 = true := by
  decide +kernel

theorem w55_s25 : segOk (w55.drop 52) 6 = true := by
  decide +kernel

theorem w55_s26 : segOk (w55.drop 58) 8 = true := by
  decide +kernel

theorem w55_s27 : segOk (w55.drop 66) 14 = true := by
  decide +kernel

theorem w55_s28 : segOk (w55.drop 80) 30 = true := by
  decide +kernel

theorem w55_end : noThree (w55.drop 110) = true := by
  decide +kernel

theorem w55_noThree : noThree (w55.drop 0) = true :=
  chain (a := 0) (k := 1) w55_s0
    (chain (a := 1) (k := 1) w55_s1
    (chain (a := 2) (k := 1) w55_s2
    (chain (a := 3) (k := 1) w55_s3
    (chain (a := 4) (k := 1) w55_s4
    (chain (a := 5) (k := 1) w55_s5
    (chain (a := 6) (k := 1) w55_s6
    (chain (a := 7) (k := 1) w55_s7
    (chain (a := 8) (k := 1) w55_s8
    (chain (a := 9) (k := 2) w55_s9
    (chain (a := 11) (k := 2) w55_s10
    (chain (a := 13) (k := 2) w55_s11
    (chain (a := 15) (k := 2) w55_s12
    (chain (a := 17) (k := 2) w55_s13
    (chain (a := 19) (k := 2) w55_s14
    (chain (a := 21) (k := 2) w55_s15
    (chain (a := 23) (k := 2) w55_s16
    (chain (a := 25) (k := 2) w55_s17
    (chain (a := 27) (k := 3) w55_s18
    (chain (a := 30) (k := 3) w55_s19
    (chain (a := 33) (k := 3) w55_s20
    (chain (a := 36) (k := 3) w55_s21
    (chain (a := 39) (k := 4) w55_s22
    (chain (a := 43) (k := 4) w55_s23
    (chain (a := 47) (k := 5) w55_s24
    (chain (a := 52) (k := 6) w55_s25
    (chain (a := 58) (k := 8) w55_s26
    (chain (a := 66) (k := 14) w55_s27
    (chain (a := 80) (k := 30) w55_s28
    (w55_end)))))))))))))))))))))))))))))

theorem w55_rest : inGrid 55 w55 = true ∧ w55.Nodup ∧ w55.length = 2 * 55 := by
  decide +kernel

theorem w55_ok : noThree w55 = true ∧ inGrid 55 w55 = true ∧ w55.Nodup ∧ w55.length = 2 * 55 :=
  ⟨w55_noThree, w55_rest⟩

end Green72Data
