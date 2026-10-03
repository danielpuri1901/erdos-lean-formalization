import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 50, split into 20 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w50_s0 : segOk (w50.drop 0) 2 = true := by
  decide +kernel

theorem w50_s1 : segOk (w50.drop 2) 2 = true := by
  decide +kernel

theorem w50_s2 : segOk (w50.drop 4) 2 = true := by
  decide +kernel

theorem w50_s3 : segOk (w50.drop 6) 2 = true := by
  decide +kernel

theorem w50_s4 : segOk (w50.drop 8) 2 = true := by
  decide +kernel

theorem w50_s5 : segOk (w50.drop 10) 2 = true := by
  decide +kernel

theorem w50_s6 : segOk (w50.drop 12) 2 = true := by
  decide +kernel

theorem w50_s7 : segOk (w50.drop 14) 2 = true := by
  decide +kernel

theorem w50_s8 : segOk (w50.drop 16) 2 = true := by
  decide +kernel

theorem w50_s9 : segOk (w50.drop 18) 3 = true := by
  decide +kernel

theorem w50_s10 : segOk (w50.drop 21) 3 = true := by
  decide +kernel

theorem w50_s11 : segOk (w50.drop 24) 3 = true := by
  decide +kernel

theorem w50_s12 : segOk (w50.drop 27) 3 = true := by
  decide +kernel

theorem w50_s13 : segOk (w50.drop 30) 4 = true := by
  decide +kernel

theorem w50_s14 : segOk (w50.drop 34) 4 = true := by
  decide +kernel

theorem w50_s15 : segOk (w50.drop 38) 5 = true := by
  decide +kernel

theorem w50_s16 : segOk (w50.drop 43) 6 = true := by
  decide +kernel

theorem w50_s17 : segOk (w50.drop 49) 9 = true := by
  decide +kernel

theorem w50_s18 : segOk (w50.drop 58) 17 = true := by
  decide +kernel

theorem w50_s19 : segOk (w50.drop 75) 25 = true := by
  decide +kernel

theorem w50_end : noThree (w50.drop 100) = true := by
  decide +kernel

theorem w50_noThree : noThree (w50.drop 0) = true :=
  chain (a := 0) (k := 2) w50_s0
    (chain (a := 2) (k := 2) w50_s1
    (chain (a := 4) (k := 2) w50_s2
    (chain (a := 6) (k := 2) w50_s3
    (chain (a := 8) (k := 2) w50_s4
    (chain (a := 10) (k := 2) w50_s5
    (chain (a := 12) (k := 2) w50_s6
    (chain (a := 14) (k := 2) w50_s7
    (chain (a := 16) (k := 2) w50_s8
    (chain (a := 18) (k := 3) w50_s9
    (chain (a := 21) (k := 3) w50_s10
    (chain (a := 24) (k := 3) w50_s11
    (chain (a := 27) (k := 3) w50_s12
    (chain (a := 30) (k := 4) w50_s13
    (chain (a := 34) (k := 4) w50_s14
    (chain (a := 38) (k := 5) w50_s15
    (chain (a := 43) (k := 6) w50_s16
    (chain (a := 49) (k := 9) w50_s17
    (chain (a := 58) (k := 17) w50_s18
    (chain (a := 75) (k := 25) w50_s19
    (w50_end))))))))))))))))))))

theorem w50_rest : inGrid 50 w50 = true ∧ w50.Nodup ∧ w50.length = 2 * 50 := by
  decide +kernel

theorem w50_ok : noThree w50 = true ∧ inGrid 50 w50 = true ∧ w50.Nodup ∧ w50.length = 2 * 50 :=
  ⟨w50_noThree, w50_rest⟩

end Green72Data
