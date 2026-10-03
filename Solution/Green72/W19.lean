import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 19, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w19_s0 : segOk (w19.drop 0) 38 = true := by
  decide +kernel

theorem w19_end : noThree (w19.drop 38) = true := by
  decide +kernel

theorem w19_noThree : noThree (w19.drop 0) = true :=
  chain (a := 0) (k := 38) w19_s0
    (w19_end)

theorem w19_rest : inGrid 19 w19 = true ∧ w19.Nodup ∧ w19.length = 2 * 19 := by
  decide +kernel

theorem w19_ok : noThree w19 = true ∧ inGrid 19 w19 = true ∧ w19.Nodup ∧ w19.length = 2 * 19 :=
  ⟨w19_noThree, w19_rest⟩

end Green72Data
