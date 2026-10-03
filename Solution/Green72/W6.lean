import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 6, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w6_s0 : segOk (w6.drop 0) 12 = true := by
  decide +kernel

theorem w6_end : noThree (w6.drop 12) = true := by
  decide +kernel

theorem w6_noThree : noThree (w6.drop 0) = true :=
  chain (a := 0) (k := 12) w6_s0
    (w6_end)

theorem w6_rest : inGrid 6 w6 = true ∧ w6.Nodup ∧ w6.length = 2 * 6 := by
  decide +kernel

theorem w6_ok : noThree w6 = true ∧ inGrid 6 w6 = true ∧ w6.Nodup ∧ w6.length = 2 * 6 :=
  ⟨w6_noThree, w6_rest⟩

end Green72Data
