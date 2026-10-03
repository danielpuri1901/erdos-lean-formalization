import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 23, split into 2 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w23_s0 : segOk (w23.drop 0) 12 = true := by
  decide +kernel

theorem w23_s1 : segOk (w23.drop 12) 34 = true := by
  decide +kernel

theorem w23_end : noThree (w23.drop 46) = true := by
  decide +kernel

theorem w23_noThree : noThree (w23.drop 0) = true :=
  chain (a := 0) (k := 12) w23_s0
    (chain (a := 12) (k := 34) w23_s1
    (w23_end))

theorem w23_rest : inGrid 23 w23 = true ∧ w23.Nodup ∧ w23.length = 2 * 23 := by
  decide +kernel

theorem w23_ok : noThree w23 = true ∧ inGrid 23 w23 = true ∧ w23.Nodup ∧ w23.length = 2 * 23 :=
  ⟨w23_noThree, w23_rest⟩

end Green72Data
