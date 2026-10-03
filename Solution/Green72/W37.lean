import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 37, split into 8 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w37_s0 : segOk (w37.drop 0) 3 = true := by
  decide +kernel

theorem w37_s1 : segOk (w37.drop 3) 4 = true := by
  decide +kernel

theorem w37_s2 : segOk (w37.drop 7) 4 = true := by
  decide +kernel

theorem w37_s3 : segOk (w37.drop 11) 5 = true := by
  decide +kernel

theorem w37_s4 : segOk (w37.drop 16) 6 = true := by
  decide +kernel

theorem w37_s5 : segOk (w37.drop 22) 8 = true := by
  decide +kernel

theorem w37_s6 : segOk (w37.drop 30) 14 = true := by
  decide +kernel

theorem w37_s7 : segOk (w37.drop 44) 30 = true := by
  decide +kernel

theorem w37_end : noThree (w37.drop 74) = true := by
  decide +kernel

theorem w37_noThree : noThree (w37.drop 0) = true :=
  chain (a := 0) (k := 3) w37_s0
    (chain (a := 3) (k := 4) w37_s1
    (chain (a := 7) (k := 4) w37_s2
    (chain (a := 11) (k := 5) w37_s3
    (chain (a := 16) (k := 6) w37_s4
    (chain (a := 22) (k := 8) w37_s5
    (chain (a := 30) (k := 14) w37_s6
    (chain (a := 44) (k := 30) w37_s7
    (w37_end))))))))

theorem w37_rest : inGrid 37 w37 = true ∧ w37.Nodup ∧ w37.length = 2 * 37 := by
  decide +kernel

theorem w37_ok : noThree w37 = true ∧ inGrid 37 w37 = true ∧ w37.Nodup ∧ w37.length = 2 * 37 :=
  ⟨w37_noThree, w37_rest⟩

end Green72Data
