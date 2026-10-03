import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 5, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w5_s0 : segOk (w5.drop 0) 10 = true := by
  decide +kernel

theorem w5_end : noThree (w5.drop 10) = true := by
  decide +kernel

theorem w5_noThree : noThree (w5.drop 0) = true :=
  chain (a := 0) (k := 10) w5_s0
    (w5_end)

theorem w5_rest : inGrid 5 w5 = true ∧ w5.Nodup ∧ w5.length = 2 * 5 := by
  decide +kernel

theorem w5_ok : noThree w5 = true ∧ inGrid 5 w5 = true ∧ w5.Nodup ∧ w5.length = 2 * 5 :=
  ⟨w5_noThree, w5_rest⟩

end Green72Data
