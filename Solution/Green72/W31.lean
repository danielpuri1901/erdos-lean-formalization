import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 31, split into 5 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w31_s0 : segOk (w31.drop 0) 5 = true := by
  decide +kernel

theorem w31_s1 : segOk (w31.drop 5) 6 = true := by
  decide +kernel

theorem w31_s2 : segOk (w31.drop 11) 9 = true := by
  decide +kernel

theorem w31_s3 : segOk (w31.drop 20) 17 = true := by
  decide +kernel

theorem w31_s4 : segOk (w31.drop 37) 25 = true := by
  decide +kernel

theorem w31_end : noThree (w31.drop 62) = true := by
  decide +kernel

theorem w31_noThree : noThree (w31.drop 0) = true :=
  chain (a := 0) (k := 5) w31_s0
    (chain (a := 5) (k := 6) w31_s1
    (chain (a := 11) (k := 9) w31_s2
    (chain (a := 20) (k := 17) w31_s3
    (chain (a := 37) (k := 25) w31_s4
    (w31_end)))))

theorem w31_rest : inGrid 31 w31 = true ∧ w31.Nodup ∧ w31.length = 2 * 31 := by
  decide +kernel

theorem w31_ok : noThree w31 = true ∧ inGrid 31 w31 = true ∧ w31.Nodup ∧ w31.length = 2 * 31 :=
  ⟨w31_noThree, w31_rest⟩

end Green72Data
