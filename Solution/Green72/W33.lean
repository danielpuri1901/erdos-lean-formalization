import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 33, split into 6 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w33_s0 : segOk (w33.drop 0) 4 = true := by
  decide +kernel

theorem w33_s1 : segOk (w33.drop 4) 5 = true := by
  decide +kernel

theorem w33_s2 : segOk (w33.drop 9) 6 = true := by
  decide +kernel

theorem w33_s3 : segOk (w33.drop 15) 9 = true := by
  decide +kernel

theorem w33_s4 : segOk (w33.drop 24) 17 = true := by
  decide +kernel

theorem w33_s5 : segOk (w33.drop 41) 25 = true := by
  decide +kernel

theorem w33_end : noThree (w33.drop 66) = true := by
  decide +kernel

theorem w33_noThree : noThree (w33.drop 0) = true :=
  chain (a := 0) (k := 4) w33_s0
    (chain (a := 4) (k := 5) w33_s1
    (chain (a := 9) (k := 6) w33_s2
    (chain (a := 15) (k := 9) w33_s3
    (chain (a := 24) (k := 17) w33_s4
    (chain (a := 41) (k := 25) w33_s5
    (w33_end))))))

theorem w33_rest : inGrid 33 w33 = true ∧ w33.Nodup ∧ w33.length = 2 * 33 := by
  decide +kernel

theorem w33_ok : noThree w33 = true ∧ inGrid 33 w33 = true ∧ w33.Nodup ∧ w33.length = 2 * 33 :=
  ⟨w33_noThree, w33_rest⟩

end Green72Data
