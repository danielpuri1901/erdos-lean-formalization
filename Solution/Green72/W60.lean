import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 60, split into 39 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w60_s0 : segOk (w60.drop 0) 1 = true := by
  decide +kernel

theorem w60_s1 : segOk (w60.drop 1) 1 = true := by
  decide +kernel

theorem w60_s2 : segOk (w60.drop 2) 1 = true := by
  decide +kernel

theorem w60_s3 : segOk (w60.drop 3) 1 = true := by
  decide +kernel

theorem w60_s4 : segOk (w60.drop 4) 1 = true := by
  decide +kernel

theorem w60_s5 : segOk (w60.drop 5) 1 = true := by
  decide +kernel

theorem w60_s6 : segOk (w60.drop 6) 1 = true := by
  decide +kernel

theorem w60_s7 : segOk (w60.drop 7) 1 = true := by
  decide +kernel

theorem w60_s8 : segOk (w60.drop 8) 1 = true := by
  decide +kernel

theorem w60_s9 : segOk (w60.drop 9) 1 = true := by
  decide +kernel

theorem w60_s10 : segOk (w60.drop 10) 1 = true := by
  decide +kernel

theorem w60_s11 : segOk (w60.drop 11) 1 = true := by
  decide +kernel

theorem w60_s12 : segOk (w60.drop 12) 1 = true := by
  decide +kernel

theorem w60_s13 : segOk (w60.drop 13) 1 = true := by
  decide +kernel

theorem w60_s14 : segOk (w60.drop 14) 1 = true := by
  decide +kernel

theorem w60_s15 : segOk (w60.drop 15) 1 = true := by
  decide +kernel

theorem w60_s16 : segOk (w60.drop 16) 1 = true := by
  decide +kernel

theorem w60_s17 : segOk (w60.drop 17) 1 = true := by
  decide +kernel

theorem w60_s18 : segOk (w60.drop 18) 1 = true := by
  decide +kernel

theorem w60_s19 : segOk (w60.drop 19) 2 = true := by
  decide +kernel

theorem w60_s20 : segOk (w60.drop 21) 2 = true := by
  decide +kernel

theorem w60_s21 : segOk (w60.drop 23) 2 = true := by
  decide +kernel

theorem w60_s22 : segOk (w60.drop 25) 2 = true := by
  decide +kernel

theorem w60_s23 : segOk (w60.drop 27) 2 = true := by
  decide +kernel

theorem w60_s24 : segOk (w60.drop 29) 2 = true := by
  decide +kernel

theorem w60_s25 : segOk (w60.drop 31) 2 = true := by
  decide +kernel

theorem w60_s26 : segOk (w60.drop 33) 2 = true := by
  decide +kernel

theorem w60_s27 : segOk (w60.drop 35) 2 = true := by
  decide +kernel

theorem w60_s28 : segOk (w60.drop 37) 3 = true := by
  decide +kernel

theorem w60_s29 : segOk (w60.drop 40) 3 = true := by
  decide +kernel

theorem w60_s30 : segOk (w60.drop 43) 3 = true := by
  decide +kernel

theorem w60_s31 : segOk (w60.drop 46) 3 = true := by
  decide +kernel

theorem w60_s32 : segOk (w60.drop 49) 4 = true := by
  decide +kernel

theorem w60_s33 : segOk (w60.drop 53) 4 = true := by
  decide +kernel

theorem w60_s34 : segOk (w60.drop 57) 5 = true := by
  decide +kernel

theorem w60_s35 : segOk (w60.drop 62) 6 = true := by
  decide +kernel

theorem w60_s36 : segOk (w60.drop 68) 8 = true := by
  decide +kernel

theorem w60_s37 : segOk (w60.drop 76) 14 = true := by
  decide +kernel

theorem w60_s38 : segOk (w60.drop 90) 30 = true := by
  decide +kernel

theorem w60_end : noThree (w60.drop 120) = true := by
  decide +kernel

theorem w60_noThree : noThree (w60.drop 0) = true :=
  chain (a := 0) (k := 1) w60_s0
    (chain (a := 1) (k := 1) w60_s1
    (chain (a := 2) (k := 1) w60_s2
    (chain (a := 3) (k := 1) w60_s3
    (chain (a := 4) (k := 1) w60_s4
    (chain (a := 5) (k := 1) w60_s5
    (chain (a := 6) (k := 1) w60_s6
    (chain (a := 7) (k := 1) w60_s7
    (chain (a := 8) (k := 1) w60_s8
    (chain (a := 9) (k := 1) w60_s9
    (chain (a := 10) (k := 1) w60_s10
    (chain (a := 11) (k := 1) w60_s11
    (chain (a := 12) (k := 1) w60_s12
    (chain (a := 13) (k := 1) w60_s13
    (chain (a := 14) (k := 1) w60_s14
    (chain (a := 15) (k := 1) w60_s15
    (chain (a := 16) (k := 1) w60_s16
    (chain (a := 17) (k := 1) w60_s17
    (chain (a := 18) (k := 1) w60_s18
    (chain (a := 19) (k := 2) w60_s19
    (chain (a := 21) (k := 2) w60_s20
    (chain (a := 23) (k := 2) w60_s21
    (chain (a := 25) (k := 2) w60_s22
    (chain (a := 27) (k := 2) w60_s23
    (chain (a := 29) (k := 2) w60_s24
    (chain (a := 31) (k := 2) w60_s25
    (chain (a := 33) (k := 2) w60_s26
    (chain (a := 35) (k := 2) w60_s27
    (chain (a := 37) (k := 3) w60_s28
    (chain (a := 40) (k := 3) w60_s29
    (chain (a := 43) (k := 3) w60_s30
    (chain (a := 46) (k := 3) w60_s31
    (chain (a := 49) (k := 4) w60_s32
    (chain (a := 53) (k := 4) w60_s33
    (chain (a := 57) (k := 5) w60_s34
    (chain (a := 62) (k := 6) w60_s35
    (chain (a := 68) (k := 8) w60_s36
    (chain (a := 76) (k := 14) w60_s37
    (chain (a := 90) (k := 30) w60_s38
    (w60_end)))))))))))))))))))))))))))))))))))))))

theorem w60_rest : inGrid 60 w60 = true ∧ w60.Nodup ∧ w60.length = 2 * 60 := by
  decide +kernel

theorem w60_ok : noThree w60 = true ∧ inGrid 60 w60 = true ∧ w60.Nodup ∧ w60.length = 2 * 60 :=
  ⟨w60_noThree, w60_rest⟩

end Green72Data
