import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 21, split into 2 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w21_s0 : segOk (w21.drop 0) 17 = true := by
  decide +kernel

theorem w21_s1 : segOk (w21.drop 17) 25 = true := by
  decide +kernel

theorem w21_end : noThree (w21.drop 42) = true := by
  decide +kernel

theorem w21_noThree : noThree (w21.drop 0) = true :=
  chain (a := 0) (k := 17) w21_s0
    (chain (a := 17) (k := 25) w21_s1
    (w21_end))

theorem w21_rest : inGrid 21 w21 = true ∧ w21.Nodup ∧ w21.length = 2 * 21 := by
  decide +kernel

theorem w21_ok : noThree w21 = true ∧ inGrid 21 w21 = true ∧ w21.Nodup ∧ w21.length = 2 * 21 :=
  ⟨w21_noThree, w21_rest⟩

end Green72Data
