import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 52, split into 23 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w52_s0 : segOk (w52.drop 0) 1 = true := by
  decide +kernel

theorem w52_s1 : segOk (w52.drop 1) 1 = true := by
  decide +kernel

theorem w52_s2 : segOk (w52.drop 2) 1 = true := by
  decide +kernel

theorem w52_s3 : segOk (w52.drop 3) 2 = true := by
  decide +kernel

theorem w52_s4 : segOk (w52.drop 5) 2 = true := by
  decide +kernel

theorem w52_s5 : segOk (w52.drop 7) 2 = true := by
  decide +kernel

theorem w52_s6 : segOk (w52.drop 9) 2 = true := by
  decide +kernel

theorem w52_s7 : segOk (w52.drop 11) 2 = true := by
  decide +kernel

theorem w52_s8 : segOk (w52.drop 13) 2 = true := by
  decide +kernel

theorem w52_s9 : segOk (w52.drop 15) 2 = true := by
  decide +kernel

theorem w52_s10 : segOk (w52.drop 17) 2 = true := by
  decide +kernel

theorem w52_s11 : segOk (w52.drop 19) 2 = true := by
  decide +kernel

theorem w52_s12 : segOk (w52.drop 21) 3 = true := by
  decide +kernel

theorem w52_s13 : segOk (w52.drop 24) 3 = true := by
  decide +kernel

theorem w52_s14 : segOk (w52.drop 27) 3 = true := by
  decide +kernel

theorem w52_s15 : segOk (w52.drop 30) 3 = true := by
  decide +kernel

theorem w52_s16 : segOk (w52.drop 33) 4 = true := by
  decide +kernel

theorem w52_s17 : segOk (w52.drop 37) 4 = true := by
  decide +kernel

theorem w52_s18 : segOk (w52.drop 41) 5 = true := by
  decide +kernel

theorem w52_s19 : segOk (w52.drop 46) 6 = true := by
  decide +kernel

theorem w52_s20 : segOk (w52.drop 52) 8 = true := by
  decide +kernel

theorem w52_s21 : segOk (w52.drop 60) 14 = true := by
  decide +kernel

theorem w52_s22 : segOk (w52.drop 74) 30 = true := by
  decide +kernel

theorem w52_end : noThree (w52.drop 104) = true := by
  decide +kernel

theorem w52_noThree : noThree (w52.drop 0) = true :=
  chain (a := 0) (k := 1) w52_s0
    (chain (a := 1) (k := 1) w52_s1
    (chain (a := 2) (k := 1) w52_s2
    (chain (a := 3) (k := 2) w52_s3
    (chain (a := 5) (k := 2) w52_s4
    (chain (a := 7) (k := 2) w52_s5
    (chain (a := 9) (k := 2) w52_s6
    (chain (a := 11) (k := 2) w52_s7
    (chain (a := 13) (k := 2) w52_s8
    (chain (a := 15) (k := 2) w52_s9
    (chain (a := 17) (k := 2) w52_s10
    (chain (a := 19) (k := 2) w52_s11
    (chain (a := 21) (k := 3) w52_s12
    (chain (a := 24) (k := 3) w52_s13
    (chain (a := 27) (k := 3) w52_s14
    (chain (a := 30) (k := 3) w52_s15
    (chain (a := 33) (k := 4) w52_s16
    (chain (a := 37) (k := 4) w52_s17
    (chain (a := 41) (k := 5) w52_s18
    (chain (a := 46) (k := 6) w52_s19
    (chain (a := 52) (k := 8) w52_s20
    (chain (a := 60) (k := 14) w52_s21
    (chain (a := 74) (k := 30) w52_s22
    (w52_end)))))))))))))))))))))))

theorem w52_rest : inGrid 52 w52 = true ∧ w52.Nodup ∧ w52.length = 2 * 52 := by
  decide +kernel

theorem w52_ok : noThree w52 = true ∧ inGrid 52 w52 = true ∧ w52.Nodup ∧ w52.length = 2 * 52 :=
  ⟨w52_noThree, w52_rest⟩

end Green72Data
