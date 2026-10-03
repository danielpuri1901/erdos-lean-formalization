import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 32, split into 5 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w32_s0 : segOk (w32.drop 0) 5 = true := by
  decide +kernel

theorem w32_s1 : segOk (w32.drop 5) 6 = true := by
  decide +kernel

theorem w32_s2 : segOk (w32.drop 11) 8 = true := by
  decide +kernel

theorem w32_s3 : segOk (w32.drop 19) 13 = true := by
  decide +kernel

theorem w32_s4 : segOk (w32.drop 32) 32 = true := by
  decide +kernel

theorem w32_end : noThree (w32.drop 64) = true := by
  decide +kernel

theorem w32_noThree : noThree (w32.drop 0) = true :=
  chain (a := 0) (k := 5) w32_s0
    (chain (a := 5) (k := 6) w32_s1
    (chain (a := 11) (k := 8) w32_s2
    (chain (a := 19) (k := 13) w32_s3
    (chain (a := 32) (k := 32) w32_s4
    (w32_end)))))

theorem w32_rest : inGrid 32 w32 = true ∧ w32.Nodup ∧ w32.length = 2 * 32 := by
  decide +kernel

theorem w32_ok : noThree w32 = true ∧ inGrid 32 w32 = true ∧ w32.Nodup ∧ w32.length = 2 * 32 :=
  ⟨w32_noThree, w32_rest⟩

end Green72Data
