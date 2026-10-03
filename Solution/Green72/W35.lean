import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 35, split into 7 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w35_s0 : segOk (w35.drop 0) 4 = true := by
  decide +kernel

theorem w35_s1 : segOk (w35.drop 4) 4 = true := by
  decide +kernel

theorem w35_s2 : segOk (w35.drop 8) 5 = true := by
  decide +kernel

theorem w35_s3 : segOk (w35.drop 13) 6 = true := by
  decide +kernel

theorem w35_s4 : segOk (w35.drop 19) 9 = true := by
  decide +kernel

theorem w35_s5 : segOk (w35.drop 28) 17 = true := by
  decide +kernel

theorem w35_s6 : segOk (w35.drop 45) 25 = true := by
  decide +kernel

theorem w35_end : noThree (w35.drop 70) = true := by
  decide +kernel

theorem w35_noThree : noThree (w35.drop 0) = true :=
  chain (a := 0) (k := 4) w35_s0
    (chain (a := 4) (k := 4) w35_s1
    (chain (a := 8) (k := 5) w35_s2
    (chain (a := 13) (k := 6) w35_s3
    (chain (a := 19) (k := 9) w35_s4
    (chain (a := 28) (k := 17) w35_s5
    (chain (a := 45) (k := 25) w35_s6
    (w35_end)))))))

theorem w35_rest : inGrid 35 w35 = true ∧ w35.Nodup ∧ w35.length = 2 * 35 := by
  decide +kernel

theorem w35_ok : noThree w35 = true ∧ inGrid 35 w35 = true ∧ w35.Nodup ∧ w35.length = 2 * 35 :=
  ⟨w35_noThree, w35_rest⟩

end Green72Data
