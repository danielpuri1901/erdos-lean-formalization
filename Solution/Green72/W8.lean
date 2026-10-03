import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 8, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w8_s0 : segOk (w8.drop 0) 16 = true := by
  decide +kernel

theorem w8_end : noThree (w8.drop 16) = true := by
  decide +kernel

theorem w8_noThree : noThree (w8.drop 0) = true :=
  chain (a := 0) (k := 16) w8_s0
    (w8_end)

theorem w8_rest : inGrid 8 w8 = true ∧ w8.Nodup ∧ w8.length = 2 * 8 := by
  decide +kernel

theorem w8_ok : noThree w8 = true ∧ inGrid 8 w8 = true ∧ w8.Nodup ∧ w8.length = 2 * 8 :=
  ⟨w8_noThree, w8_rest⟩

end Green72Data
