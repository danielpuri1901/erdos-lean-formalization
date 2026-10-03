import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 42, split into 12 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w42_s0 : segOk (w42.drop 0) 2 = true := by
  decide +kernel

theorem w42_s1 : segOk (w42.drop 2) 3 = true := by
  decide +kernel

theorem w42_s2 : segOk (w42.drop 5) 3 = true := by
  decide +kernel

theorem w42_s3 : segOk (w42.drop 8) 3 = true := by
  decide +kernel

theorem w42_s4 : segOk (w42.drop 11) 3 = true := by
  decide +kernel

theorem w42_s5 : segOk (w42.drop 14) 4 = true := by
  decide +kernel

theorem w42_s6 : segOk (w42.drop 18) 4 = true := by
  decide +kernel

theorem w42_s7 : segOk (w42.drop 22) 5 = true := by
  decide +kernel

theorem w42_s8 : segOk (w42.drop 27) 6 = true := by
  decide +kernel

theorem w42_s9 : segOk (w42.drop 33) 9 = true := by
  decide +kernel

theorem w42_s10 : segOk (w42.drop 42) 17 = true := by
  decide +kernel

theorem w42_s11 : segOk (w42.drop 59) 25 = true := by
  decide +kernel

theorem w42_end : noThree (w42.drop 84) = true := by
  decide +kernel

theorem w42_noThree : noThree (w42.drop 0) = true :=
  chain (a := 0) (k := 2) w42_s0
    (chain (a := 2) (k := 3) w42_s1
    (chain (a := 5) (k := 3) w42_s2
    (chain (a := 8) (k := 3) w42_s3
    (chain (a := 11) (k := 3) w42_s4
    (chain (a := 14) (k := 4) w42_s5
    (chain (a := 18) (k := 4) w42_s6
    (chain (a := 22) (k := 5) w42_s7
    (chain (a := 27) (k := 6) w42_s8
    (chain (a := 33) (k := 9) w42_s9
    (chain (a := 42) (k := 17) w42_s10
    (chain (a := 59) (k := 25) w42_s11
    (w42_end))))))))))))

theorem w42_rest : inGrid 42 w42 = true ∧ w42.Nodup ∧ w42.length = 2 * 42 := by
  decide +kernel

theorem w42_ok : noThree w42 = true ∧ inGrid 42 w42 = true ∧ w42.Nodup ∧ w42.length = 2 * 42 :=
  ⟨w42_noThree, w42_rest⟩

end Green72Data
