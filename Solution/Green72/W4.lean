import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 4, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w4_s0 : segOk (w4.drop 0) 8 = true := by
  decide +kernel

theorem w4_end : noThree (w4.drop 8) = true := by
  decide +kernel

theorem w4_noThree : noThree (w4.drop 0) = true :=
  chain (a := 0) (k := 8) w4_s0
    (w4_end)

theorem w4_rest : inGrid 4 w4 = true ∧ w4.Nodup ∧ w4.length = 2 * 4 := by
  decide +kernel

theorem w4_ok : noThree w4 = true ∧ inGrid 4 w4 = true ∧ w4.Nodup ∧ w4.length = 2 * 4 :=
  ⟨w4_noThree, w4_rest⟩

end Green72Data
