import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 15, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w15_s0 : segOk (w15.drop 0) 30 = true := by
  decide +kernel

theorem w15_end : noThree (w15.drop 30) = true := by
  decide +kernel

theorem w15_noThree : noThree (w15.drop 0) = true :=
  chain (a := 0) (k := 30) w15_s0
    (w15_end)

theorem w15_rest : inGrid 15 w15 = true ∧ w15.Nodup ∧ w15.length = 2 * 15 := by
  decide +kernel

theorem w15_ok : noThree w15 = true ∧ inGrid 15 w15 = true ∧ w15.Nodup ∧ w15.length = 2 * 15 :=
  ⟨w15_noThree, w15_rest⟩

end Green72Data
