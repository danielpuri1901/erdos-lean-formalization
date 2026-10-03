import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 56, split into 31 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w56_s0 : segOk (w56.drop 0) 1 = true := by
  decide +kernel

theorem w56_s1 : segOk (w56.drop 1) 1 = true := by
  decide +kernel

theorem w56_s2 : segOk (w56.drop 2) 1 = true := by
  decide +kernel

theorem w56_s3 : segOk (w56.drop 3) 1 = true := by
  decide +kernel

theorem w56_s4 : segOk (w56.drop 4) 1 = true := by
  decide +kernel

theorem w56_s5 : segOk (w56.drop 5) 1 = true := by
  decide +kernel

theorem w56_s6 : segOk (w56.drop 6) 1 = true := by
  decide +kernel

theorem w56_s7 : segOk (w56.drop 7) 1 = true := by
  decide +kernel

theorem w56_s8 : segOk (w56.drop 8) 1 = true := by
  decide +kernel

theorem w56_s9 : segOk (w56.drop 9) 1 = true := by
  decide +kernel

theorem w56_s10 : segOk (w56.drop 10) 1 = true := by
  decide +kernel

theorem w56_s11 : segOk (w56.drop 11) 2 = true := by
  decide +kernel

theorem w56_s12 : segOk (w56.drop 13) 2 = true := by
  decide +kernel

theorem w56_s13 : segOk (w56.drop 15) 2 = true := by
  decide +kernel

theorem w56_s14 : segOk (w56.drop 17) 2 = true := by
  decide +kernel

theorem w56_s15 : segOk (w56.drop 19) 2 = true := by
  decide +kernel

theorem w56_s16 : segOk (w56.drop 21) 2 = true := by
  decide +kernel

theorem w56_s17 : segOk (w56.drop 23) 2 = true := by
  decide +kernel

theorem w56_s18 : segOk (w56.drop 25) 2 = true := by
  decide +kernel

theorem w56_s19 : segOk (w56.drop 27) 2 = true := by
  decide +kernel

theorem w56_s20 : segOk (w56.drop 29) 3 = true := by
  decide +kernel

theorem w56_s21 : segOk (w56.drop 32) 3 = true := by
  decide +kernel

theorem w56_s22 : segOk (w56.drop 35) 3 = true := by
  decide +kernel

theorem w56_s23 : segOk (w56.drop 38) 3 = true := by
  decide +kernel

theorem w56_s24 : segOk (w56.drop 41) 4 = true := by
  decide +kernel

theorem w56_s25 : segOk (w56.drop 45) 4 = true := by
  decide +kernel

theorem w56_s26 : segOk (w56.drop 49) 5 = true := by
  decide +kernel

theorem w56_s27 : segOk (w56.drop 54) 6 = true := by
  decide +kernel

theorem w56_s28 : segOk (w56.drop 60) 8 = true := by
  decide +kernel

theorem w56_s29 : segOk (w56.drop 68) 14 = true := by
  decide +kernel

theorem w56_s30 : segOk (w56.drop 82) 30 = true := by
  decide +kernel

theorem w56_end : noThree (w56.drop 112) = true := by
  decide +kernel

theorem w56_noThree : noThree (w56.drop 0) = true :=
  chain (a := 0) (k := 1) w56_s0
    (chain (a := 1) (k := 1) w56_s1
    (chain (a := 2) (k := 1) w56_s2
    (chain (a := 3) (k := 1) w56_s3
    (chain (a := 4) (k := 1) w56_s4
    (chain (a := 5) (k := 1) w56_s5
    (chain (a := 6) (k := 1) w56_s6
    (chain (a := 7) (k := 1) w56_s7
    (chain (a := 8) (k := 1) w56_s8
    (chain (a := 9) (k := 1) w56_s9
    (chain (a := 10) (k := 1) w56_s10
    (chain (a := 11) (k := 2) w56_s11
    (chain (a := 13) (k := 2) w56_s12
    (chain (a := 15) (k := 2) w56_s13
    (chain (a := 17) (k := 2) w56_s14
    (chain (a := 19) (k := 2) w56_s15
    (chain (a := 21) (k := 2) w56_s16
    (chain (a := 23) (k := 2) w56_s17
    (chain (a := 25) (k := 2) w56_s18
    (chain (a := 27) (k := 2) w56_s19
    (chain (a := 29) (k := 3) w56_s20
    (chain (a := 32) (k := 3) w56_s21
    (chain (a := 35) (k := 3) w56_s22
    (chain (a := 38) (k := 3) w56_s23
    (chain (a := 41) (k := 4) w56_s24
    (chain (a := 45) (k := 4) w56_s25
    (chain (a := 49) (k := 5) w56_s26
    (chain (a := 54) (k := 6) w56_s27
    (chain (a := 60) (k := 8) w56_s28
    (chain (a := 68) (k := 14) w56_s29
    (chain (a := 82) (k := 30) w56_s30
    (w56_end)))))))))))))))))))))))))))))))

theorem w56_rest : inGrid 56 w56 = true ∧ w56.Nodup ∧ w56.length = 2 * 56 := by
  decide +kernel

theorem w56_ok : noThree w56 = true ∧ inGrid 56 w56 = true ∧ w56.Nodup ∧ w56.length = 2 * 56 :=
  ⟨w56_noThree, w56_rest⟩

end Green72Data
