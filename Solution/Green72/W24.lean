import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 24, split into 2 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w24_s0 : segOk (w24.drop 0) 11 = true := by
  decide +kernel

theorem w24_s1 : segOk (w24.drop 11) 37 = true := by
  decide +kernel

theorem w24_end : noThree (w24.drop 48) = true := by
  decide +kernel

theorem w24_noThree : noThree (w24.drop 0) = true :=
  chain (a := 0) (k := 11) w24_s0
    (chain (a := 11) (k := 37) w24_s1
    (w24_end))

theorem w24_rest : inGrid 24 w24 = true ∧ w24.Nodup ∧ w24.length = 2 * 24 := by
  decide +kernel

theorem w24_ok : noThree w24 = true ∧ inGrid 24 w24 = true ∧ w24.Nodup ∧ w24.length = 2 * 24 :=
  ⟨w24_noThree, w24_rest⟩

end Green72Data
