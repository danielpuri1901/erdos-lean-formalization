import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 41, split into 11 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w41_s0 : segOk (w41.drop 0) 3 = true := by
  decide +kernel

theorem w41_s1 : segOk (w41.drop 3) 3 = true := by
  decide +kernel

theorem w41_s2 : segOk (w41.drop 6) 3 = true := by
  decide +kernel

theorem w41_s3 : segOk (w41.drop 9) 3 = true := by
  decide +kernel

theorem w41_s4 : segOk (w41.drop 12) 4 = true := by
  decide +kernel

theorem w41_s5 : segOk (w41.drop 16) 4 = true := by
  decide +kernel

theorem w41_s6 : segOk (w41.drop 20) 5 = true := by
  decide +kernel

theorem w41_s7 : segOk (w41.drop 25) 6 = true := by
  decide +kernel

theorem w41_s8 : segOk (w41.drop 31) 9 = true := by
  decide +kernel

theorem w41_s9 : segOk (w41.drop 40) 17 = true := by
  decide +kernel

theorem w41_s10 : segOk (w41.drop 57) 25 = true := by
  decide +kernel

theorem w41_end : noThree (w41.drop 82) = true := by
  decide +kernel

theorem w41_noThree : noThree (w41.drop 0) = true :=
  chain (a := 0) (k := 3) w41_s0
    (chain (a := 3) (k := 3) w41_s1
    (chain (a := 6) (k := 3) w41_s2
    (chain (a := 9) (k := 3) w41_s3
    (chain (a := 12) (k := 4) w41_s4
    (chain (a := 16) (k := 4) w41_s5
    (chain (a := 20) (k := 5) w41_s6
    (chain (a := 25) (k := 6) w41_s7
    (chain (a := 31) (k := 9) w41_s8
    (chain (a := 40) (k := 17) w41_s9
    (chain (a := 57) (k := 25) w41_s10
    (w41_end)))))))))))

theorem w41_rest : inGrid 41 w41 = true ∧ w41.Nodup ∧ w41.length = 2 * 41 := by
  decide +kernel

theorem w41_ok : noThree w41 = true ∧ inGrid 41 w41 = true ∧ w41.Nodup ∧ w41.length = 2 * 41 :=
  ⟨w41_noThree, w41_rest⟩

end Green72Data
