import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 3, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w3_s0 : segOk (w3.drop 0) 6 = true := by
  decide +kernel

theorem w3_end : noThree (w3.drop 6) = true := by
  decide +kernel

theorem w3_noThree : noThree (w3.drop 0) = true :=
  chain (a := 0) (k := 6) w3_s0
    (w3_end)

theorem w3_rest : inGrid 3 w3 = true ∧ w3.Nodup ∧ w3.length = 2 * 3 := by
  decide +kernel

theorem w3_ok : noThree w3 = true ∧ inGrid 3 w3 = true ∧ w3.Nodup ∧ w3.length = 2 * 3 :=
  ⟨w3_noThree, w3_rest⟩

end Green72Data
