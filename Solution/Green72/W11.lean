import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 11, split into 1 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w11_s0 : segOk (w11.drop 0) 22 = true := by
  decide +kernel

theorem w11_end : noThree (w11.drop 22) = true := by
  decide +kernel

theorem w11_noThree : noThree (w11.drop 0) = true :=
  chain (a := 0) (k := 22) w11_s0
    (w11_end)

theorem w11_rest : inGrid 11 w11 = true ∧ w11.Nodup ∧ w11.length = 2 * 11 := by
  decide +kernel

theorem w11_ok : noThree w11 = true ∧ inGrid 11 w11 = true ∧ w11.Nodup ∧ w11.length = 2 * 11 :=
  ⟨w11_noThree, w11_rest⟩

end Green72Data
