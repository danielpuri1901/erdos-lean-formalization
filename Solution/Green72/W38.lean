import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 38, split into 9 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w38_s0 : segOk (w38.drop 0) 3 = true := by
  decide +kernel

theorem w38_s1 : segOk (w38.drop 3) 3 = true := by
  decide +kernel

theorem w38_s2 : segOk (w38.drop 6) 4 = true := by
  decide +kernel

theorem w38_s3 : segOk (w38.drop 10) 4 = true := by
  decide +kernel

theorem w38_s4 : segOk (w38.drop 14) 5 = true := by
  decide +kernel

theorem w38_s5 : segOk (w38.drop 19) 6 = true := by
  decide +kernel

theorem w38_s6 : segOk (w38.drop 25) 9 = true := by
  decide +kernel

theorem w38_s7 : segOk (w38.drop 34) 17 = true := by
  decide +kernel

theorem w38_s8 : segOk (w38.drop 51) 25 = true := by
  decide +kernel

theorem w38_end : noThree (w38.drop 76) = true := by
  decide +kernel

theorem w38_noThree : noThree (w38.drop 0) = true :=
  chain (a := 0) (k := 3) w38_s0
    (chain (a := 3) (k := 3) w38_s1
    (chain (a := 6) (k := 4) w38_s2
    (chain (a := 10) (k := 4) w38_s3
    (chain (a := 14) (k := 5) w38_s4
    (chain (a := 19) (k := 6) w38_s5
    (chain (a := 25) (k := 9) w38_s6
    (chain (a := 34) (k := 17) w38_s7
    (chain (a := 51) (k := 25) w38_s8
    (w38_end)))))))))

theorem w38_rest : inGrid 38 w38 = true ∧ w38.Nodup ∧ w38.length = 2 * 38 := by
  decide +kernel

theorem w38_ok : noThree w38 = true ∧ inGrid 38 w38 = true ∧ w38.Nodup ∧ w38.length = 2 * 38 :=
  ⟨w38_noThree, w38_rest⟩

end Green72Data
