import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 57, split into 33 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w57_s0 : segOk (w57.drop 0) 1 = true := by
  decide +kernel

theorem w57_s1 : segOk (w57.drop 1) 1 = true := by
  decide +kernel

theorem w57_s2 : segOk (w57.drop 2) 1 = true := by
  decide +kernel

theorem w57_s3 : segOk (w57.drop 3) 1 = true := by
  decide +kernel

theorem w57_s4 : segOk (w57.drop 4) 1 = true := by
  decide +kernel

theorem w57_s5 : segOk (w57.drop 5) 1 = true := by
  decide +kernel

theorem w57_s6 : segOk (w57.drop 6) 1 = true := by
  decide +kernel

theorem w57_s7 : segOk (w57.drop 7) 1 = true := by
  decide +kernel

theorem w57_s8 : segOk (w57.drop 8) 1 = true := by
  decide +kernel

theorem w57_s9 : segOk (w57.drop 9) 1 = true := by
  decide +kernel

theorem w57_s10 : segOk (w57.drop 10) 1 = true := by
  decide +kernel

theorem w57_s11 : segOk (w57.drop 11) 1 = true := by
  decide +kernel

theorem w57_s12 : segOk (w57.drop 12) 1 = true := by
  decide +kernel

theorem w57_s13 : segOk (w57.drop 13) 2 = true := by
  decide +kernel

theorem w57_s14 : segOk (w57.drop 15) 2 = true := by
  decide +kernel

theorem w57_s15 : segOk (w57.drop 17) 2 = true := by
  decide +kernel

theorem w57_s16 : segOk (w57.drop 19) 2 = true := by
  decide +kernel

theorem w57_s17 : segOk (w57.drop 21) 2 = true := by
  decide +kernel

theorem w57_s18 : segOk (w57.drop 23) 2 = true := by
  decide +kernel

theorem w57_s19 : segOk (w57.drop 25) 2 = true := by
  decide +kernel

theorem w57_s20 : segOk (w57.drop 27) 2 = true := by
  decide +kernel

theorem w57_s21 : segOk (w57.drop 29) 2 = true := by
  decide +kernel

theorem w57_s22 : segOk (w57.drop 31) 3 = true := by
  decide +kernel

theorem w57_s23 : segOk (w57.drop 34) 3 = true := by
  decide +kernel

theorem w57_s24 : segOk (w57.drop 37) 3 = true := by
  decide +kernel

theorem w57_s25 : segOk (w57.drop 40) 3 = true := by
  decide +kernel

theorem w57_s26 : segOk (w57.drop 43) 4 = true := by
  decide +kernel

theorem w57_s27 : segOk (w57.drop 47) 4 = true := by
  decide +kernel

theorem w57_s28 : segOk (w57.drop 51) 5 = true := by
  decide +kernel

theorem w57_s29 : segOk (w57.drop 56) 6 = true := by
  decide +kernel

theorem w57_s30 : segOk (w57.drop 62) 8 = true := by
  decide +kernel

theorem w57_s31 : segOk (w57.drop 70) 14 = true := by
  decide +kernel

theorem w57_s32 : segOk (w57.drop 84) 30 = true := by
  decide +kernel

theorem w57_end : noThree (w57.drop 114) = true := by
  decide +kernel

theorem w57_noThree : noThree (w57.drop 0) = true :=
  chain (a := 0) (k := 1) w57_s0
    (chain (a := 1) (k := 1) w57_s1
    (chain (a := 2) (k := 1) w57_s2
    (chain (a := 3) (k := 1) w57_s3
    (chain (a := 4) (k := 1) w57_s4
    (chain (a := 5) (k := 1) w57_s5
    (chain (a := 6) (k := 1) w57_s6
    (chain (a := 7) (k := 1) w57_s7
    (chain (a := 8) (k := 1) w57_s8
    (chain (a := 9) (k := 1) w57_s9
    (chain (a := 10) (k := 1) w57_s10
    (chain (a := 11) (k := 1) w57_s11
    (chain (a := 12) (k := 1) w57_s12
    (chain (a := 13) (k := 2) w57_s13
    (chain (a := 15) (k := 2) w57_s14
    (chain (a := 17) (k := 2) w57_s15
    (chain (a := 19) (k := 2) w57_s16
    (chain (a := 21) (k := 2) w57_s17
    (chain (a := 23) (k := 2) w57_s18
    (chain (a := 25) (k := 2) w57_s19
    (chain (a := 27) (k := 2) w57_s20
    (chain (a := 29) (k := 2) w57_s21
    (chain (a := 31) (k := 3) w57_s22
    (chain (a := 34) (k := 3) w57_s23
    (chain (a := 37) (k := 3) w57_s24
    (chain (a := 40) (k := 3) w57_s25
    (chain (a := 43) (k := 4) w57_s26
    (chain (a := 47) (k := 4) w57_s27
    (chain (a := 51) (k := 5) w57_s28
    (chain (a := 56) (k := 6) w57_s29
    (chain (a := 62) (k := 8) w57_s30
    (chain (a := 70) (k := 14) w57_s31
    (chain (a := 84) (k := 30) w57_s32
    (w57_end)))))))))))))))))))))))))))))))))

theorem w57_rest : inGrid 57 w57 = true ∧ w57.Nodup ∧ w57.length = 2 * 57 := by
  decide +kernel

theorem w57_ok : noThree w57 = true ∧ inGrid 57 w57 = true ∧ w57.Nodup ∧ w57.length = 2 * 57 :=
  ⟨w57_noThree, w57_rest⟩

end Green72Data
