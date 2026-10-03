import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 10, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w10_s0 : segOk (w10.drop 0) 20 = true := by
  decide +kernel

theorem w10_end : noThree (w10.drop 20) = true := by
  decide +kernel

theorem w10_noThree : noThree (w10.drop 0) = true :=
  chain (a := 0) (k := 20) w10_s0
    (w10_end)

theorem w10_rest : inGrid 10 w10 = true ∧ w10.Nodup ∧ w10.length = 2 * 10 := by
  decide +kernel

theorem w10_ok : noThree w10 = true ∧ inGrid 10 w10 = true ∧ w10.Nodup ∧ w10.length = 2 * 10 :=
  ⟨w10_noThree, w10_rest⟩

end Green72Data
