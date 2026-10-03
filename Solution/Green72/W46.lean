import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 46, split into 16 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w46_s0 : segOk (w46.drop 0) 2 = true := by
  decide +kernel

theorem w46_s1 : segOk (w46.drop 2) 2 = true := by
  decide +kernel

theorem w46_s2 : segOk (w46.drop 4) 2 = true := by
  decide +kernel

theorem w46_s3 : segOk (w46.drop 6) 2 = true := by
  decide +kernel

theorem w46_s4 : segOk (w46.drop 8) 2 = true := by
  decide +kernel

theorem w46_s5 : segOk (w46.drop 10) 3 = true := by
  decide +kernel

theorem w46_s6 : segOk (w46.drop 13) 3 = true := by
  decide +kernel

theorem w46_s7 : segOk (w46.drop 16) 3 = true := by
  decide +kernel

theorem w46_s8 : segOk (w46.drop 19) 3 = true := by
  decide +kernel

theorem w46_s9 : segOk (w46.drop 22) 4 = true := by
  decide +kernel

theorem w46_s10 : segOk (w46.drop 26) 4 = true := by
  decide +kernel

theorem w46_s11 : segOk (w46.drop 30) 5 = true := by
  decide +kernel

theorem w46_s12 : segOk (w46.drop 35) 6 = true := by
  decide +kernel

theorem w46_s13 : segOk (w46.drop 41) 9 = true := by
  decide +kernel

theorem w46_s14 : segOk (w46.drop 50) 17 = true := by
  decide +kernel

theorem w46_s15 : segOk (w46.drop 67) 25 = true := by
  decide +kernel

theorem w46_end : noThree (w46.drop 92) = true := by
  decide +kernel

theorem w46_noThree : noThree (w46.drop 0) = true :=
  chain (a := 0) (k := 2) w46_s0
    (chain (a := 2) (k := 2) w46_s1
    (chain (a := 4) (k := 2) w46_s2
    (chain (a := 6) (k := 2) w46_s3
    (chain (a := 8) (k := 2) w46_s4
    (chain (a := 10) (k := 3) w46_s5
    (chain (a := 13) (k := 3) w46_s6
    (chain (a := 16) (k := 3) w46_s7
    (chain (a := 19) (k := 3) w46_s8
    (chain (a := 22) (k := 4) w46_s9
    (chain (a := 26) (k := 4) w46_s10
    (chain (a := 30) (k := 5) w46_s11
    (chain (a := 35) (k := 6) w46_s12
    (chain (a := 41) (k := 9) w46_s13
    (chain (a := 50) (k := 17) w46_s14
    (chain (a := 67) (k := 25) w46_s15
    (w46_end))))))))))))))))

theorem w46_rest : inGrid 46 w46 = true ∧ w46.Nodup ∧ w46.length = 2 * 46 := by
  decide +kernel

theorem w46_ok : noThree w46 = true ∧ inGrid 46 w46 = true ∧ w46.Nodup ∧ w46.length = 2 * 46 :=
  ⟨w46_noThree, w46_rest⟩

end Green72Data
