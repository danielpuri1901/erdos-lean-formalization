import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 9, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w9_s0 : segOk (w9.drop 0) 18 = true := by
  decide +kernel

theorem w9_end : noThree (w9.drop 18) = true := by
  decide +kernel

theorem w9_noThree : noThree (w9.drop 0) = true :=
  chain (a := 0) (k := 18) w9_s0
    (w9_end)

theorem w9_rest : inGrid 9 w9 = true ∧ w9.Nodup ∧ w9.length = 2 * 9 := by
  decide +kernel

theorem w9_ok : noThree w9 = true ∧ inGrid 9 w9 = true ∧ w9.Nodup ∧ w9.length = 2 * 9 :=
  ⟨w9_noThree, w9_rest⟩

end Green72Data
