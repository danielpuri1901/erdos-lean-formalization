import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 12, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w12_s0 : segOk (w12.drop 0) 24 = true := by
  decide +kernel

theorem w12_end : noThree (w12.drop 24) = true := by
  decide +kernel

theorem w12_noThree : noThree (w12.drop 0) = true :=
  chain (a := 0) (k := 24) w12_s0
    (w12_end)

theorem w12_rest : inGrid 12 w12 = true ∧ w12.Nodup ∧ w12.length = 2 * 12 := by
  decide +kernel

theorem w12_ok : noThree w12 = true ∧ inGrid 12 w12 = true ∧ w12.Nodup ∧ w12.length = 2 * 12 :=
  ⟨w12_noThree, w12_rest⟩

end Green72Data
