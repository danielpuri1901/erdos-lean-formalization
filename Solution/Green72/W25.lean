import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 25, split into 3 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w25_s0 : segOk (w25.drop 0) 9 = true := by
  decide +kernel

theorem w25_s1 : segOk (w25.drop 9) 20 = true := by
  decide +kernel

theorem w25_s2 : segOk (w25.drop 29) 21 = true := by
  decide +kernel

theorem w25_end : noThree (w25.drop 50) = true := by
  decide +kernel

theorem w25_noThree : noThree (w25.drop 0) = true :=
  chain (a := 0) (k := 9) w25_s0
    (chain (a := 9) (k := 20) w25_s1
    (chain (a := 29) (k := 21) w25_s2
    (w25_end)))

theorem w25_rest : inGrid 25 w25 = true ∧ w25.Nodup ∧ w25.length = 2 * 25 := by
  decide +kernel

theorem w25_ok : noThree w25 = true ∧ inGrid 25 w25 = true ∧ w25.Nodup ∧ w25.length = 2 * 25 :=
  ⟨w25_noThree, w25_rest⟩

end Green72Data
