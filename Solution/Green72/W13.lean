import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 13, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w13_s0 : segOk (w13.drop 0) 26 = true := by
  decide +kernel

theorem w13_end : noThree (w13.drop 26) = true := by
  decide +kernel

theorem w13_noThree : noThree (w13.drop 0) = true :=
  chain (a := 0) (k := 26) w13_s0
    (w13_end)

theorem w13_rest : inGrid 13 w13 = true ∧ w13.Nodup ∧ w13.length = 2 * 13 := by
  decide +kernel

theorem w13_ok : noThree w13 = true ∧ inGrid 13 w13 = true ∧ w13.Nodup ∧ w13.length = 2 * 13 :=
  ⟨w13_noThree, w13_rest⟩

end Green72Data
