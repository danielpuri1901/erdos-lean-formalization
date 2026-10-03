import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 49, split into 19 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w49_s0 : segOk (w49.drop 0) 2 = true := by
  decide +kernel

theorem w49_s1 : segOk (w49.drop 2) 2 = true := by
  decide +kernel

theorem w49_s2 : segOk (w49.drop 4) 2 = true := by
  decide +kernel

theorem w49_s3 : segOk (w49.drop 6) 2 = true := by
  decide +kernel

theorem w49_s4 : segOk (w49.drop 8) 2 = true := by
  decide +kernel

theorem w49_s5 : segOk (w49.drop 10) 2 = true := by
  decide +kernel

theorem w49_s6 : segOk (w49.drop 12) 2 = true := by
  decide +kernel

theorem w49_s7 : segOk (w49.drop 14) 2 = true := by
  decide +kernel

theorem w49_s8 : segOk (w49.drop 16) 3 = true := by
  decide +kernel

theorem w49_s9 : segOk (w49.drop 19) 3 = true := by
  decide +kernel

theorem w49_s10 : segOk (w49.drop 22) 3 = true := by
  decide +kernel

theorem w49_s11 : segOk (w49.drop 25) 3 = true := by
  decide +kernel

theorem w49_s12 : segOk (w49.drop 28) 4 = true := by
  decide +kernel

theorem w49_s13 : segOk (w49.drop 32) 4 = true := by
  decide +kernel

theorem w49_s14 : segOk (w49.drop 36) 5 = true := by
  decide +kernel

theorem w49_s15 : segOk (w49.drop 41) 6 = true := by
  decide +kernel

theorem w49_s16 : segOk (w49.drop 47) 9 = true := by
  decide +kernel

theorem w49_s17 : segOk (w49.drop 56) 17 = true := by
  decide +kernel

theorem w49_s18 : segOk (w49.drop 73) 25 = true := by
  decide +kernel

theorem w49_end : noThree (w49.drop 98) = true := by
  decide +kernel

theorem w49_noThree : noThree (w49.drop 0) = true :=
  chain (a := 0) (k := 2) w49_s0
    (chain (a := 2) (k := 2) w49_s1
    (chain (a := 4) (k := 2) w49_s2
    (chain (a := 6) (k := 2) w49_s3
    (chain (a := 8) (k := 2) w49_s4
    (chain (a := 10) (k := 2) w49_s5
    (chain (a := 12) (k := 2) w49_s6
    (chain (a := 14) (k := 2) w49_s7
    (chain (a := 16) (k := 3) w49_s8
    (chain (a := 19) (k := 3) w49_s9
    (chain (a := 22) (k := 3) w49_s10
    (chain (a := 25) (k := 3) w49_s11
    (chain (a := 28) (k := 4) w49_s12
    (chain (a := 32) (k := 4) w49_s13
    (chain (a := 36) (k := 5) w49_s14
    (chain (a := 41) (k := 6) w49_s15
    (chain (a := 47) (k := 9) w49_s16
    (chain (a := 56) (k := 17) w49_s17
    (chain (a := 73) (k := 25) w49_s18
    (w49_end)))))))))))))))))))

theorem w49_rest : inGrid 49 w49 = true ∧ w49.Nodup ∧ w49.length = 2 * 49 := by
  decide +kernel

theorem w49_ok : noThree w49 = true ∧ inGrid 49 w49 = true ∧ w49.Nodup ∧ w49.length = 2 * 49 :=
  ⟨w49_noThree, w49_rest⟩

end Green72Data
