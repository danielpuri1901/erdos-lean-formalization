import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 14, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w14_s0 : segOk (w14.drop 0) 28 = true := by
  decide +kernel

theorem w14_end : noThree (w14.drop 28) = true := by
  decide +kernel

theorem w14_noThree : noThree (w14.drop 0) = true :=
  chain (a := 0) (k := 28) w14_s0
    (w14_end)

theorem w14_rest : inGrid 14 w14 = true ∧ w14.Nodup ∧ w14.length = 2 * 14 := by
  decide +kernel

theorem w14_ok : noThree w14 = true ∧ inGrid 14 w14 = true ∧ w14.Nodup ∧ w14.length = 2 * 14 :=
  ⟨w14_noThree, w14_rest⟩

end Green72Data
