import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 18, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w18_s0 : segOk (w18.drop 0) 36 = true := by
  decide +kernel

theorem w18_end : noThree (w18.drop 36) = true := by
  decide +kernel

theorem w18_noThree : noThree (w18.drop 0) = true :=
  chain (a := 0) (k := 36) w18_s0
    (w18_end)

theorem w18_rest : inGrid 18 w18 = true ∧ w18.Nodup ∧ w18.length = 2 * 18 := by
  decide +kernel

theorem w18_ok : noThree w18 = true ∧ inGrid 18 w18 = true ∧ w18.Nodup ∧ w18.length = 2 * 18 :=
  ⟨w18_noThree, w18_rest⟩

end Green72Data
