import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 40, split into 10 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w40_s0 : segOk (w40.drop 0) 3 = true := by
  decide +kernel

theorem w40_s1 : segOk (w40.drop 3) 3 = true := by
  decide +kernel

theorem w40_s2 : segOk (w40.drop 6) 3 = true := by
  decide +kernel

theorem w40_s3 : segOk (w40.drop 9) 4 = true := by
  decide +kernel

theorem w40_s4 : segOk (w40.drop 13) 4 = true := by
  decide +kernel

theorem w40_s5 : segOk (w40.drop 17) 5 = true := by
  decide +kernel

theorem w40_s6 : segOk (w40.drop 22) 6 = true := by
  decide +kernel

theorem w40_s7 : segOk (w40.drop 28) 8 = true := by
  decide +kernel

theorem w40_s8 : segOk (w40.drop 36) 14 = true := by
  decide +kernel

theorem w40_s9 : segOk (w40.drop 50) 30 = true := by
  decide +kernel

theorem w40_end : noThree (w40.drop 80) = true := by
  decide +kernel

theorem w40_noThree : noThree (w40.drop 0) = true :=
  chain (a := 0) (k := 3) w40_s0
    (chain (a := 3) (k := 3) w40_s1
    (chain (a := 6) (k := 3) w40_s2
    (chain (a := 9) (k := 4) w40_s3
    (chain (a := 13) (k := 4) w40_s4
    (chain (a := 17) (k := 5) w40_s5
    (chain (a := 22) (k := 6) w40_s6
    (chain (a := 28) (k := 8) w40_s7
    (chain (a := 36) (k := 14) w40_s8
    (chain (a := 50) (k := 30) w40_s9
    (w40_end))))))))))

theorem w40_rest : inGrid 40 w40 = true ∧ w40.Nodup ∧ w40.length = 2 * 40 := by
  decide +kernel

theorem w40_ok : noThree w40 = true ∧ inGrid 40 w40 = true ∧ w40.Nodup ∧ w40.length = 2 * 40 :=
  ⟨w40_noThree, w40_rest⟩

end Green72Data
