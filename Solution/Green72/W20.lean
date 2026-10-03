import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 20, split into 2 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w20_s0 : segOk (w20.drop 0) 24 = true := by
  decide +kernel

theorem w20_s1 : segOk (w20.drop 24) 16 = true := by
  decide +kernel

theorem w20_end : noThree (w20.drop 40) = true := by
  decide +kernel

theorem w20_noThree : noThree (w20.drop 0) = true :=
  chain (a := 0) (k := 24) w20_s0
    (chain (a := 24) (k := 16) w20_s1
    (w20_end))

theorem w20_rest : inGrid 20 w20 = true ∧ w20.Nodup ∧ w20.length = 2 * 20 := by
  decide +kernel

theorem w20_ok : noThree w20 = true ∧ inGrid 20 w20 = true ∧ w20.Nodup ∧ w20.length = 2 * 20 :=
  ⟨w20_noThree, w20_rest⟩

end Green72Data
