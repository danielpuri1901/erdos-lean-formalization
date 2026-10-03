import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 36, split into 7 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w36_s0 : segOk (w36.drop 0) 4 = true := by
  decide +kernel

theorem w36_s1 : segOk (w36.drop 4) 4 = true := by
  decide +kernel

theorem w36_s2 : segOk (w36.drop 8) 5 = true := by
  decide +kernel

theorem w36_s3 : segOk (w36.drop 13) 6 = true := by
  decide +kernel

theorem w36_s4 : segOk (w36.drop 19) 8 = true := by
  decide +kernel

theorem w36_s5 : segOk (w36.drop 27) 13 = true := by
  decide +kernel

theorem w36_s6 : segOk (w36.drop 40) 32 = true := by
  decide +kernel

theorem w36_end : noThree (w36.drop 72) = true := by
  decide +kernel

theorem w36_noThree : noThree (w36.drop 0) = true :=
  chain (a := 0) (k := 4) w36_s0
    (chain (a := 4) (k := 4) w36_s1
    (chain (a := 8) (k := 5) w36_s2
    (chain (a := 13) (k := 6) w36_s3
    (chain (a := 19) (k := 8) w36_s4
    (chain (a := 27) (k := 13) w36_s5
    (chain (a := 40) (k := 32) w36_s6
    (w36_end)))))))

theorem w36_rest : inGrid 36 w36 = true ∧ w36.Nodup ∧ w36.length = 2 * 36 := by
  decide +kernel

theorem w36_ok : noThree w36 = true ∧ inGrid 36 w36 = true ∧ w36.Nodup ∧ w36.length = 2 * 36 :=
  ⟨w36_noThree, w36_rest⟩

end Green72Data
