import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 54, split into 27 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w54_s0 : segOk (w54.drop 0) 1 = true := by
  decide +kernel

theorem w54_s1 : segOk (w54.drop 1) 1 = true := by
  decide +kernel

theorem w54_s2 : segOk (w54.drop 2) 1 = true := by
  decide +kernel

theorem w54_s3 : segOk (w54.drop 3) 1 = true := by
  decide +kernel

theorem w54_s4 : segOk (w54.drop 4) 1 = true := by
  decide +kernel

theorem w54_s5 : segOk (w54.drop 5) 1 = true := by
  decide +kernel

theorem w54_s6 : segOk (w54.drop 6) 1 = true := by
  decide +kernel

theorem w54_s7 : segOk (w54.drop 7) 2 = true := by
  decide +kernel

theorem w54_s8 : segOk (w54.drop 9) 2 = true := by
  decide +kernel

theorem w54_s9 : segOk (w54.drop 11) 2 = true := by
  decide +kernel

theorem w54_s10 : segOk (w54.drop 13) 2 = true := by
  decide +kernel

theorem w54_s11 : segOk (w54.drop 15) 2 = true := by
  decide +kernel

theorem w54_s12 : segOk (w54.drop 17) 2 = true := by
  decide +kernel

theorem w54_s13 : segOk (w54.drop 19) 2 = true := by
  decide +kernel

theorem w54_s14 : segOk (w54.drop 21) 2 = true := by
  decide +kernel

theorem w54_s15 : segOk (w54.drop 23) 2 = true := by
  decide +kernel

theorem w54_s16 : segOk (w54.drop 25) 3 = true := by
  decide +kernel

theorem w54_s17 : segOk (w54.drop 28) 3 = true := by
  decide +kernel

theorem w54_s18 : segOk (w54.drop 31) 3 = true := by
  decide +kernel

theorem w54_s19 : segOk (w54.drop 34) 3 = true := by
  decide +kernel

theorem w54_s20 : segOk (w54.drop 37) 4 = true := by
  decide +kernel

theorem w54_s21 : segOk (w54.drop 41) 4 = true := by
  decide +kernel

theorem w54_s22 : segOk (w54.drop 45) 5 = true := by
  decide +kernel

theorem w54_s23 : segOk (w54.drop 50) 6 = true := by
  decide +kernel

theorem w54_s24 : segOk (w54.drop 56) 8 = true := by
  decide +kernel

theorem w54_s25 : segOk (w54.drop 64) 14 = true := by
  decide +kernel

theorem w54_s26 : segOk (w54.drop 78) 30 = true := by
  decide +kernel

theorem w54_end : noThree (w54.drop 108) = true := by
  decide +kernel

theorem w54_noThree : noThree (w54.drop 0) = true :=
  chain (a := 0) (k := 1) w54_s0
    (chain (a := 1) (k := 1) w54_s1
    (chain (a := 2) (k := 1) w54_s2
    (chain (a := 3) (k := 1) w54_s3
    (chain (a := 4) (k := 1) w54_s4
    (chain (a := 5) (k := 1) w54_s5
    (chain (a := 6) (k := 1) w54_s6
    (chain (a := 7) (k := 2) w54_s7
    (chain (a := 9) (k := 2) w54_s8
    (chain (a := 11) (k := 2) w54_s9
    (chain (a := 13) (k := 2) w54_s10
    (chain (a := 15) (k := 2) w54_s11
    (chain (a := 17) (k := 2) w54_s12
    (chain (a := 19) (k := 2) w54_s13
    (chain (a := 21) (k := 2) w54_s14
    (chain (a := 23) (k := 2) w54_s15
    (chain (a := 25) (k := 3) w54_s16
    (chain (a := 28) (k := 3) w54_s17
    (chain (a := 31) (k := 3) w54_s18
    (chain (a := 34) (k := 3) w54_s19
    (chain (a := 37) (k := 4) w54_s20
    (chain (a := 41) (k := 4) w54_s21
    (chain (a := 45) (k := 5) w54_s22
    (chain (a := 50) (k := 6) w54_s23
    (chain (a := 56) (k := 8) w54_s24
    (chain (a := 64) (k := 14) w54_s25
    (chain (a := 78) (k := 30) w54_s26
    (w54_end)))))))))))))))))))))))))))

theorem w54_rest : inGrid 54 w54 = true ∧ w54.Nodup ∧ w54.length = 2 * 54 := by
  decide +kernel

theorem w54_ok : noThree w54 = true ∧ inGrid 54 w54 = true ∧ w54.Nodup ∧ w54.length = 2 * 54 :=
  ⟨w54_noThree, w54_rest⟩

end Green72Data
