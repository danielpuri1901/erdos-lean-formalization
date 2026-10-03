import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 43, split into 13 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w43_s0 : segOk (w43.drop 0) 2 = true := by
  decide +kernel

theorem w43_s1 : segOk (w43.drop 2) 2 = true := by
  decide +kernel

theorem w43_s2 : segOk (w43.drop 4) 3 = true := by
  decide +kernel

theorem w43_s3 : segOk (w43.drop 7) 3 = true := by
  decide +kernel

theorem w43_s4 : segOk (w43.drop 10) 3 = true := by
  decide +kernel

theorem w43_s5 : segOk (w43.drop 13) 3 = true := by
  decide +kernel

theorem w43_s6 : segOk (w43.drop 16) 4 = true := by
  decide +kernel

theorem w43_s7 : segOk (w43.drop 20) 4 = true := by
  decide +kernel

theorem w43_s8 : segOk (w43.drop 24) 5 = true := by
  decide +kernel

theorem w43_s9 : segOk (w43.drop 29) 6 = true := by
  decide +kernel

theorem w43_s10 : segOk (w43.drop 35) 9 = true := by
  decide +kernel

theorem w43_s11 : segOk (w43.drop 44) 17 = true := by
  decide +kernel

theorem w43_s12 : segOk (w43.drop 61) 25 = true := by
  decide +kernel

theorem w43_end : noThree (w43.drop 86) = true := by
  decide +kernel

theorem w43_noThree : noThree (w43.drop 0) = true :=
  chain (a := 0) (k := 2) w43_s0
    (chain (a := 2) (k := 2) w43_s1
    (chain (a := 4) (k := 3) w43_s2
    (chain (a := 7) (k := 3) w43_s3
    (chain (a := 10) (k := 3) w43_s4
    (chain (a := 13) (k := 3) w43_s5
    (chain (a := 16) (k := 4) w43_s6
    (chain (a := 20) (k := 4) w43_s7
    (chain (a := 24) (k := 5) w43_s8
    (chain (a := 29) (k := 6) w43_s9
    (chain (a := 35) (k := 9) w43_s10
    (chain (a := 44) (k := 17) w43_s11
    (chain (a := 61) (k := 25) w43_s12
    (w43_end)))))))))))))

theorem w43_rest : inGrid 43 w43 = true ∧ w43.Nodup ∧ w43.length = 2 * 43 := by
  decide +kernel

theorem w43_ok : noThree w43 = true ∧ inGrid 43 w43 = true ∧ w43.Nodup ∧ w43.length = 2 * 43 :=
  ⟨w43_noThree, w43_rest⟩

end Green72Data
