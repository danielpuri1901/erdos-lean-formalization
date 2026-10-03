import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 22, split into 2 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w22_s0 : segOk (w22.drop 0) 14 = true := by
  decide +kernel

theorem w22_s1 : segOk (w22.drop 14) 30 = true := by
  decide +kernel

theorem w22_end : noThree (w22.drop 44) = true := by
  decide +kernel

theorem w22_noThree : noThree (w22.drop 0) = true :=
  chain (a := 0) (k := 14) w22_s0
    (chain (a := 14) (k := 30) w22_s1
    (w22_end))

theorem w22_rest : inGrid 22 w22 = true ∧ w22.Nodup ∧ w22.length = 2 * 22 := by
  decide +kernel

theorem w22_ok : noThree w22 = true ∧ inGrid 22 w22 = true ∧ w22.Nodup ∧ w22.length = 2 * 22 :=
  ⟨w22_noThree, w22_rest⟩

end Green72Data
