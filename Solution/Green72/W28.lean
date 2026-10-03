import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 28, split into 3 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w28_s0 : segOk (w28.drop 0) 7 = true := by
  decide +kernel

theorem w28_s1 : segOk (w28.drop 7) 10 = true := by
  decide +kernel

theorem w28_s2 : segOk (w28.drop 17) 39 = true := by
  decide +kernel

theorem w28_end : noThree (w28.drop 56) = true := by
  decide +kernel

theorem w28_noThree : noThree (w28.drop 0) = true :=
  chain (a := 0) (k := 7) w28_s0
    (chain (a := 7) (k := 10) w28_s1
    (chain (a := 17) (k := 39) w28_s2
    (w28_end)))

theorem w28_rest : inGrid 28 w28 = true ∧ w28.Nodup ∧ w28.length = 2 * 28 := by
  decide +kernel

theorem w28_ok : noThree w28 = true ∧ inGrid 28 w28 = true ∧ w28.Nodup ∧ w28.length = 2 * 28 :=
  ⟨w28_noThree, w28_rest⟩

end Green72Data
