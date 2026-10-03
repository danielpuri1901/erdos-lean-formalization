import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 58, split into 35 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w58_s0 : segOk (w58.drop 0) 1 = true := by
  decide +kernel

theorem w58_s1 : segOk (w58.drop 1) 1 = true := by
  decide +kernel

theorem w58_s2 : segOk (w58.drop 2) 1 = true := by
  decide +kernel

theorem w58_s3 : segOk (w58.drop 3) 1 = true := by
  decide +kernel

theorem w58_s4 : segOk (w58.drop 4) 1 = true := by
  decide +kernel

theorem w58_s5 : segOk (w58.drop 5) 1 = true := by
  decide +kernel

theorem w58_s6 : segOk (w58.drop 6) 1 = true := by
  decide +kernel

theorem w58_s7 : segOk (w58.drop 7) 1 = true := by
  decide +kernel

theorem w58_s8 : segOk (w58.drop 8) 1 = true := by
  decide +kernel

theorem w58_s9 : segOk (w58.drop 9) 1 = true := by
  decide +kernel

theorem w58_s10 : segOk (w58.drop 10) 1 = true := by
  decide +kernel

theorem w58_s11 : segOk (w58.drop 11) 1 = true := by
  decide +kernel

theorem w58_s12 : segOk (w58.drop 12) 1 = true := by
  decide +kernel

theorem w58_s13 : segOk (w58.drop 13) 1 = true := by
  decide +kernel

theorem w58_s14 : segOk (w58.drop 14) 1 = true := by
  decide +kernel

theorem w58_s15 : segOk (w58.drop 15) 2 = true := by
  decide +kernel

theorem w58_s16 : segOk (w58.drop 17) 2 = true := by
  decide +kernel

theorem w58_s17 : segOk (w58.drop 19) 2 = true := by
  decide +kernel

theorem w58_s18 : segOk (w58.drop 21) 2 = true := by
  decide +kernel

theorem w58_s19 : segOk (w58.drop 23) 2 = true := by
  decide +kernel

theorem w58_s20 : segOk (w58.drop 25) 2 = true := by
  decide +kernel

theorem w58_s21 : segOk (w58.drop 27) 2 = true := by
  decide +kernel

theorem w58_s22 : segOk (w58.drop 29) 2 = true := by
  decide +kernel

theorem w58_s23 : segOk (w58.drop 31) 2 = true := by
  decide +kernel

theorem w58_s24 : segOk (w58.drop 33) 3 = true := by
  decide +kernel

theorem w58_s25 : segOk (w58.drop 36) 3 = true := by
  decide +kernel

theorem w58_s26 : segOk (w58.drop 39) 3 = true := by
  decide +kernel

theorem w58_s27 : segOk (w58.drop 42) 3 = true := by
  decide +kernel

theorem w58_s28 : segOk (w58.drop 45) 4 = true := by
  decide +kernel

theorem w58_s29 : segOk (w58.drop 49) 4 = true := by
  decide +kernel

theorem w58_s30 : segOk (w58.drop 53) 5 = true := by
  decide +kernel

theorem w58_s31 : segOk (w58.drop 58) 6 = true := by
  decide +kernel

theorem w58_s32 : segOk (w58.drop 64) 8 = true := by
  decide +kernel

theorem w58_s33 : segOk (w58.drop 72) 14 = true := by
  decide +kernel

theorem w58_s34 : segOk (w58.drop 86) 30 = true := by
  decide +kernel

theorem w58_end : noThree (w58.drop 116) = true := by
  decide +kernel

theorem w58_noThree : noThree (w58.drop 0) = true :=
  chain (a := 0) (k := 1) w58_s0
    (chain (a := 1) (k := 1) w58_s1
    (chain (a := 2) (k := 1) w58_s2
    (chain (a := 3) (k := 1) w58_s3
    (chain (a := 4) (k := 1) w58_s4
    (chain (a := 5) (k := 1) w58_s5
    (chain (a := 6) (k := 1) w58_s6
    (chain (a := 7) (k := 1) w58_s7
    (chain (a := 8) (k := 1) w58_s8
    (chain (a := 9) (k := 1) w58_s9
    (chain (a := 10) (k := 1) w58_s10
    (chain (a := 11) (k := 1) w58_s11
    (chain (a := 12) (k := 1) w58_s12
    (chain (a := 13) (k := 1) w58_s13
    (chain (a := 14) (k := 1) w58_s14
    (chain (a := 15) (k := 2) w58_s15
    (chain (a := 17) (k := 2) w58_s16
    (chain (a := 19) (k := 2) w58_s17
    (chain (a := 21) (k := 2) w58_s18
    (chain (a := 23) (k := 2) w58_s19
    (chain (a := 25) (k := 2) w58_s20
    (chain (a := 27) (k := 2) w58_s21
    (chain (a := 29) (k := 2) w58_s22
    (chain (a := 31) (k := 2) w58_s23
    (chain (a := 33) (k := 3) w58_s24
    (chain (a := 36) (k := 3) w58_s25
    (chain (a := 39) (k := 3) w58_s26
    (chain (a := 42) (k := 3) w58_s27
    (chain (a := 45) (k := 4) w58_s28
    (chain (a := 49) (k := 4) w58_s29
    (chain (a := 53) (k := 5) w58_s30
    (chain (a := 58) (k := 6) w58_s31
    (chain (a := 64) (k := 8) w58_s32
    (chain (a := 72) (k := 14) w58_s33
    (chain (a := 86) (k := 30) w58_s34
    (w58_end)))))))))))))))))))))))))))))))))))

theorem w58_rest : inGrid 58 w58 = true ∧ w58.Nodup ∧ w58.length = 2 * 58 := by
  decide +kernel

theorem w58_ok : noThree w58 = true ∧ inGrid 58 w58 = true ∧ w58.Nodup ∧ w58.length = 2 * 58 :=
  ⟨w58_noThree, w58_rest⟩

end Green72Data
