import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 30, split into 4 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w30_s0 : segOk (w30.drop 0) 6 = true := by
  decide +kernel

theorem w30_s1 : segOk (w30.drop 6) 7 = true := by
  decide +kernel

theorem w30_s2 : segOk (w30.drop 13) 11 = true := by
  decide +kernel

theorem w30_s3 : segOk (w30.drop 24) 36 = true := by
  decide +kernel

theorem w30_end : noThree (w30.drop 60) = true := by
  decide +kernel

theorem w30_noThree : noThree (w30.drop 0) = true :=
  chain (a := 0) (k := 6) w30_s0
    (chain (a := 6) (k := 7) w30_s1
    (chain (a := 13) (k := 11) w30_s2
    (chain (a := 24) (k := 36) w30_s3
    (w30_end))))

theorem w30_rest : inGrid 30 w30 = true ∧ w30.Nodup ∧ w30.length = 2 * 30 := by
  decide +kernel

theorem w30_ok : noThree w30 = true ∧ inGrid 30 w30 = true ∧ w30.Nodup ∧ w30.length = 2 * 30 :=
  ⟨w30_noThree, w30_rest⟩

end Green72Data
