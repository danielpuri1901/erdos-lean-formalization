import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 59, split into 37 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w59_s0 : segOk (w59.drop 0) 1 = true := by
  decide +kernel

theorem w59_s1 : segOk (w59.drop 1) 1 = true := by
  decide +kernel

theorem w59_s2 : segOk (w59.drop 2) 1 = true := by
  decide +kernel

theorem w59_s3 : segOk (w59.drop 3) 1 = true := by
  decide +kernel

theorem w59_s4 : segOk (w59.drop 4) 1 = true := by
  decide +kernel

theorem w59_s5 : segOk (w59.drop 5) 1 = true := by
  decide +kernel

theorem w59_s6 : segOk (w59.drop 6) 1 = true := by
  decide +kernel

theorem w59_s7 : segOk (w59.drop 7) 1 = true := by
  decide +kernel

theorem w59_s8 : segOk (w59.drop 8) 1 = true := by
  decide +kernel

theorem w59_s9 : segOk (w59.drop 9) 1 = true := by
  decide +kernel

theorem w59_s10 : segOk (w59.drop 10) 1 = true := by
  decide +kernel

theorem w59_s11 : segOk (w59.drop 11) 1 = true := by
  decide +kernel

theorem w59_s12 : segOk (w59.drop 12) 1 = true := by
  decide +kernel

theorem w59_s13 : segOk (w59.drop 13) 1 = true := by
  decide +kernel

theorem w59_s14 : segOk (w59.drop 14) 1 = true := by
  decide +kernel

theorem w59_s15 : segOk (w59.drop 15) 1 = true := by
  decide +kernel

theorem w59_s16 : segOk (w59.drop 16) 1 = true := by
  decide +kernel

theorem w59_s17 : segOk (w59.drop 17) 2 = true := by
  decide +kernel

theorem w59_s18 : segOk (w59.drop 19) 2 = true := by
  decide +kernel

theorem w59_s19 : segOk (w59.drop 21) 2 = true := by
  decide +kernel

theorem w59_s20 : segOk (w59.drop 23) 2 = true := by
  decide +kernel

theorem w59_s21 : segOk (w59.drop 25) 2 = true := by
  decide +kernel

theorem w59_s22 : segOk (w59.drop 27) 2 = true := by
  decide +kernel

theorem w59_s23 : segOk (w59.drop 29) 2 = true := by
  decide +kernel

theorem w59_s24 : segOk (w59.drop 31) 2 = true := by
  decide +kernel

theorem w59_s25 : segOk (w59.drop 33) 2 = true := by
  decide +kernel

theorem w59_s26 : segOk (w59.drop 35) 3 = true := by
  decide +kernel

theorem w59_s27 : segOk (w59.drop 38) 3 = true := by
  decide +kernel

theorem w59_s28 : segOk (w59.drop 41) 3 = true := by
  decide +kernel

theorem w59_s29 : segOk (w59.drop 44) 3 = true := by
  decide +kernel

theorem w59_s30 : segOk (w59.drop 47) 4 = true := by
  decide +kernel

theorem w59_s31 : segOk (w59.drop 51) 4 = true := by
  decide +kernel

theorem w59_s32 : segOk (w59.drop 55) 5 = true := by
  decide +kernel

theorem w59_s33 : segOk (w59.drop 60) 6 = true := by
  decide +kernel

theorem w59_s34 : segOk (w59.drop 66) 8 = true := by
  decide +kernel

theorem w59_s35 : segOk (w59.drop 74) 14 = true := by
  decide +kernel

theorem w59_s36 : segOk (w59.drop 88) 30 = true := by
  decide +kernel

theorem w59_end : noThree (w59.drop 118) = true := by
  decide +kernel

theorem w59_noThree : noThree (w59.drop 0) = true :=
  chain (a := 0) (k := 1) w59_s0
    (chain (a := 1) (k := 1) w59_s1
    (chain (a := 2) (k := 1) w59_s2
    (chain (a := 3) (k := 1) w59_s3
    (chain (a := 4) (k := 1) w59_s4
    (chain (a := 5) (k := 1) w59_s5
    (chain (a := 6) (k := 1) w59_s6
    (chain (a := 7) (k := 1) w59_s7
    (chain (a := 8) (k := 1) w59_s8
    (chain (a := 9) (k := 1) w59_s9
    (chain (a := 10) (k := 1) w59_s10
    (chain (a := 11) (k := 1) w59_s11
    (chain (a := 12) (k := 1) w59_s12
    (chain (a := 13) (k := 1) w59_s13
    (chain (a := 14) (k := 1) w59_s14
    (chain (a := 15) (k := 1) w59_s15
    (chain (a := 16) (k := 1) w59_s16
    (chain (a := 17) (k := 2) w59_s17
    (chain (a := 19) (k := 2) w59_s18
    (chain (a := 21) (k := 2) w59_s19
    (chain (a := 23) (k := 2) w59_s20
    (chain (a := 25) (k := 2) w59_s21
    (chain (a := 27) (k := 2) w59_s22
    (chain (a := 29) (k := 2) w59_s23
    (chain (a := 31) (k := 2) w59_s24
    (chain (a := 33) (k := 2) w59_s25
    (chain (a := 35) (k := 3) w59_s26
    (chain (a := 38) (k := 3) w59_s27
    (chain (a := 41) (k := 3) w59_s28
    (chain (a := 44) (k := 3) w59_s29
    (chain (a := 47) (k := 4) w59_s30
    (chain (a := 51) (k := 4) w59_s31
    (chain (a := 55) (k := 5) w59_s32
    (chain (a := 60) (k := 6) w59_s33
    (chain (a := 66) (k := 8) w59_s34
    (chain (a := 74) (k := 14) w59_s35
    (chain (a := 88) (k := 30) w59_s36
    (w59_end)))))))))))))))))))))))))))))))))))))

theorem w59_rest : inGrid 59 w59 = true ∧ w59.Nodup ∧ w59.length = 2 * 59 := by
  decide +kernel

theorem w59_ok : noThree w59 = true ∧ inGrid 59 w59 = true ∧ w59.Nodup ∧ w59.length = 2 * 59 :=
  ⟨w59_noThree, w59_rest⟩

end Green72Data
