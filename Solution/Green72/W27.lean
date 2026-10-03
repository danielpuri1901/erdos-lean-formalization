import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 27, split into 3 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w27_s0 : segOk (w27.drop 0) 7 = true := by
  decide +kernel

theorem w27_s1 : segOk (w27.drop 7) 11 = true := by
  decide +kernel

theorem w27_s2 : segOk (w27.drop 18) 36 = true := by
  decide +kernel

theorem w27_end : noThree (w27.drop 54) = true := by
  decide +kernel

theorem w27_noThree : noThree (w27.drop 0) = true :=
  chain (a := 0) (k := 7) w27_s0
    (chain (a := 7) (k := 11) w27_s1
    (chain (a := 18) (k := 36) w27_s2
    (w27_end)))

theorem w27_rest : inGrid 27 w27 = true ∧ w27.Nodup ∧ w27.length = 2 * 27 := by
  decide +kernel

theorem w27_ok : noThree w27 = true ∧ inGrid 27 w27 = true ∧ w27.Nodup ∧ w27.length = 2 * 27 :=
  ⟨w27_noThree, w27_rest⟩

end Green72Data
