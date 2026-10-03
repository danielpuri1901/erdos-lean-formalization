import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 34, split into 6 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w34_s0 : segOk (w34.drop 0) 4 = true := by
  decide +kernel

theorem w34_s1 : segOk (w34.drop 4) 5 = true := by
  decide +kernel

theorem w34_s2 : segOk (w34.drop 9) 6 = true := by
  decide +kernel

theorem w34_s3 : segOk (w34.drop 15) 8 = true := by
  decide +kernel

theorem w34_s4 : segOk (w34.drop 23) 13 = true := by
  decide +kernel

theorem w34_s5 : segOk (w34.drop 36) 32 = true := by
  decide +kernel

theorem w34_end : noThree (w34.drop 68) = true := by
  decide +kernel

theorem w34_noThree : noThree (w34.drop 0) = true :=
  chain (a := 0) (k := 4) w34_s0
    (chain (a := 4) (k := 5) w34_s1
    (chain (a := 9) (k := 6) w34_s2
    (chain (a := 15) (k := 8) w34_s3
    (chain (a := 23) (k := 13) w34_s4
    (chain (a := 36) (k := 32) w34_s5
    (w34_end))))))

theorem w34_rest : inGrid 34 w34 = true ∧ w34.Nodup ∧ w34.length = 2 * 34 := by
  decide +kernel

theorem w34_ok : noThree w34 = true ∧ inGrid 34 w34 = true ∧ w34.Nodup ∧ w34.length = 2 * 34 :=
  ⟨w34_noThree, w34_rest⟩

end Green72Data
