import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 45, split into 15 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w45_s0 : segOk (w45.drop 0) 2 = true := by
  decide +kernel

theorem w45_s1 : segOk (w45.drop 2) 2 = true := by
  decide +kernel

theorem w45_s2 : segOk (w45.drop 4) 2 = true := by
  decide +kernel

theorem w45_s3 : segOk (w45.drop 6) 2 = true := by
  decide +kernel

theorem w45_s4 : segOk (w45.drop 8) 3 = true := by
  decide +kernel

theorem w45_s5 : segOk (w45.drop 11) 3 = true := by
  decide +kernel

theorem w45_s6 : segOk (w45.drop 14) 3 = true := by
  decide +kernel

theorem w45_s7 : segOk (w45.drop 17) 3 = true := by
  decide +kernel

theorem w45_s8 : segOk (w45.drop 20) 4 = true := by
  decide +kernel

theorem w45_s9 : segOk (w45.drop 24) 4 = true := by
  decide +kernel

theorem w45_s10 : segOk (w45.drop 28) 5 = true := by
  decide +kernel

theorem w45_s11 : segOk (w45.drop 33) 6 = true := by
  decide +kernel

theorem w45_s12 : segOk (w45.drop 39) 9 = true := by
  decide +kernel

theorem w45_s13 : segOk (w45.drop 48) 17 = true := by
  decide +kernel

theorem w45_s14 : segOk (w45.drop 65) 25 = true := by
  decide +kernel

theorem w45_end : noThree (w45.drop 90) = true := by
  decide +kernel

theorem w45_noThree : noThree (w45.drop 0) = true :=
  chain (a := 0) (k := 2) w45_s0
    (chain (a := 2) (k := 2) w45_s1
    (chain (a := 4) (k := 2) w45_s2
    (chain (a := 6) (k := 2) w45_s3
    (chain (a := 8) (k := 3) w45_s4
    (chain (a := 11) (k := 3) w45_s5
    (chain (a := 14) (k := 3) w45_s6
    (chain (a := 17) (k := 3) w45_s7
    (chain (a := 20) (k := 4) w45_s8
    (chain (a := 24) (k := 4) w45_s9
    (chain (a := 28) (k := 5) w45_s10
    (chain (a := 33) (k := 6) w45_s11
    (chain (a := 39) (k := 9) w45_s12
    (chain (a := 48) (k := 17) w45_s13
    (chain (a := 65) (k := 25) w45_s14
    (w45_end)))))))))))))))

theorem w45_rest : inGrid 45 w45 = true ∧ w45.Nodup ∧ w45.length = 2 * 45 := by
  decide +kernel

theorem w45_ok : noThree w45 = true ∧ inGrid 45 w45 = true ∧ w45.Nodup ∧ w45.length = 2 * 45 :=
  ⟨w45_noThree, w45_rest⟩

end Green72Data
