import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 16, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w16_s0 : segOk (w16.drop 0) 32 = true := by
  decide +kernel

theorem w16_end : noThree (w16.drop 32) = true := by
  decide +kernel

theorem w16_noThree : noThree (w16.drop 0) = true :=
  chain (a := 0) (k := 32) w16_s0
    (w16_end)

theorem w16_rest : inGrid 16 w16 = true ∧ w16.Nodup ∧ w16.length = 2 * 16 := by
  decide +kernel

theorem w16_ok : noThree w16 = true ∧ inGrid 16 w16 = true ∧ w16.Nodup ∧ w16.length = 2 * 16 :=
  ⟨w16_noThree, w16_rest⟩

end Green72Data
