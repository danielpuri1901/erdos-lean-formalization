import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 17, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w17_s0 : segOk (w17.drop 0) 34 = true := by
  decide +kernel

theorem w17_end : noThree (w17.drop 34) = true := by
  decide +kernel

theorem w17_noThree : noThree (w17.drop 0) = true :=
  chain (a := 0) (k := 34) w17_s0
    (w17_end)

theorem w17_rest : inGrid 17 w17 = true ∧ w17.Nodup ∧ w17.length = 2 * 17 := by
  decide +kernel

theorem w17_ok : noThree w17 = true ∧ inGrid 17 w17 = true ∧ w17.Nodup ∧ w17.length = 2 * 17 :=
  ⟨w17_noThree, w17_rest⟩

end Green72Data
