import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 26, split into 3 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w26_s0 : segOk (w26.drop 0) 8 = true := by
  decide +kernel

theorem w26_s1 : segOk (w26.drop 8) 14 = true := by
  decide +kernel

theorem w26_s2 : segOk (w26.drop 22) 30 = true := by
  decide +kernel

theorem w26_end : noThree (w26.drop 52) = true := by
  decide +kernel

theorem w26_noThree : noThree (w26.drop 0) = true :=
  chain (a := 0) (k := 8) w26_s0
    (chain (a := 8) (k := 14) w26_s1
    (chain (a := 22) (k := 30) w26_s2
    (w26_end)))

theorem w26_rest : inGrid 26 w26 = true ∧ w26.Nodup ∧ w26.length = 2 * 26 := by
  decide +kernel

theorem w26_ok : noThree w26 = true ∧ inGrid 26 w26 = true ∧ w26.Nodup ∧ w26.length = 2 * 26 :=
  ⟨w26_noThree, w26_rest⟩

end Green72Data
