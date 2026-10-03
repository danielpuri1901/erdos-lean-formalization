import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 29, split into 4 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w29_s0 : segOk (w29.drop 0) 6 = true := by
  decide +kernel

theorem w29_s1 : segOk (w29.drop 6) 8 = true := by
  decide +kernel

theorem w29_s2 : segOk (w29.drop 14) 14 = true := by
  decide +kernel

theorem w29_s3 : segOk (w29.drop 28) 30 = true := by
  decide +kernel

theorem w29_end : noThree (w29.drop 58) = true := by
  decide +kernel

theorem w29_noThree : noThree (w29.drop 0) = true :=
  chain (a := 0) (k := 6) w29_s0
    (chain (a := 6) (k := 8) w29_s1
    (chain (a := 14) (k := 14) w29_s2
    (chain (a := 28) (k := 30) w29_s3
    (w29_end))))

theorem w29_rest : inGrid 29 w29 = true ∧ w29.Nodup ∧ w29.length = 2 * 29 := by
  decide +kernel

theorem w29_ok : noThree w29 = true ∧ inGrid 29 w29 = true ∧ w29.Nodup ∧ w29.length = 2 * 29 :=
  ⟨w29_noThree, w29_rest⟩

end Green72Data
