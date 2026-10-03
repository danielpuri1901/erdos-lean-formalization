import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 7, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w7_s0 : segOk (w7.drop 0) 14 = true := by
  decide +kernel

theorem w7_end : noThree (w7.drop 14) = true := by
  decide +kernel

theorem w7_noThree : noThree (w7.drop 0) = true :=
  chain (a := 0) (k := 14) w7_s0
    (w7_end)

theorem w7_rest : inGrid 7 w7 = true ∧ w7.Nodup ∧ w7.length = 2 * 7 := by
  decide +kernel

theorem w7_ok : noThree w7 = true ∧ inGrid 7 w7 = true ∧ w7.Nodup ∧ w7.length = 2 * 7 :=
  ⟨w7_noThree, w7_rest⟩

end Green72Data
