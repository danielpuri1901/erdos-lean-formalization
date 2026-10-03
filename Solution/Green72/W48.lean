import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 48, split into 18 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w48_s0 : segOk (w48.drop 0) 2 = true := by
  decide +kernel

theorem w48_s1 : segOk (w48.drop 2) 2 = true := by
  decide +kernel

theorem w48_s2 : segOk (w48.drop 4) 2 = true := by
  decide +kernel

theorem w48_s3 : segOk (w48.drop 6) 2 = true := by
  decide +kernel

theorem w48_s4 : segOk (w48.drop 8) 2 = true := by
  decide +kernel

theorem w48_s5 : segOk (w48.drop 10) 2 = true := by
  decide +kernel

theorem w48_s6 : segOk (w48.drop 12) 2 = true := by
  decide +kernel

theorem w48_s7 : segOk (w48.drop 14) 3 = true := by
  decide +kernel

theorem w48_s8 : segOk (w48.drop 17) 3 = true := by
  decide +kernel

theorem w48_s9 : segOk (w48.drop 20) 3 = true := by
  decide +kernel

theorem w48_s10 : segOk (w48.drop 23) 3 = true := by
  decide +kernel

theorem w48_s11 : segOk (w48.drop 26) 4 = true := by
  decide +kernel

theorem w48_s12 : segOk (w48.drop 30) 4 = true := by
  decide +kernel

theorem w48_s13 : segOk (w48.drop 34) 5 = true := by
  decide +kernel

theorem w48_s14 : segOk (w48.drop 39) 6 = true := by
  decide +kernel

theorem w48_s15 : segOk (w48.drop 45) 9 = true := by
  decide +kernel

theorem w48_s16 : segOk (w48.drop 54) 17 = true := by
  decide +kernel

theorem w48_s17 : segOk (w48.drop 71) 25 = true := by
  decide +kernel

theorem w48_end : noThree (w48.drop 96) = true := by
  decide +kernel

theorem w48_noThree : noThree (w48.drop 0) = true :=
  chain (a := 0) (k := 2) w48_s0
    (chain (a := 2) (k := 2) w48_s1
    (chain (a := 4) (k := 2) w48_s2
    (chain (a := 6) (k := 2) w48_s3
    (chain (a := 8) (k := 2) w48_s4
    (chain (a := 10) (k := 2) w48_s5
    (chain (a := 12) (k := 2) w48_s6
    (chain (a := 14) (k := 3) w48_s7
    (chain (a := 17) (k := 3) w48_s8
    (chain (a := 20) (k := 3) w48_s9
    (chain (a := 23) (k := 3) w48_s10
    (chain (a := 26) (k := 4) w48_s11
    (chain (a := 30) (k := 4) w48_s12
    (chain (a := 34) (k := 5) w48_s13
    (chain (a := 39) (k := 6) w48_s14
    (chain (a := 45) (k := 9) w48_s15
    (chain (a := 54) (k := 17) w48_s16
    (chain (a := 71) (k := 25) w48_s17
    (w48_end))))))))))))))))))

theorem w48_rest : inGrid 48 w48 = true ∧ w48.Nodup ∧ w48.length = 2 * 48 := by
  decide +kernel

theorem w48_ok : noThree w48 = true ∧ inGrid 48 w48 = true ∧ w48.Nodup ∧ w48.length = 2 * 48 :=
  ⟨w48_noThree, w48_rest⟩

end Green72Data
