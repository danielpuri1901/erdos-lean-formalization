import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 39, split into 9 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w39_s0 : segOk (w39.drop 0) 3 = true := by
  decide +kernel

theorem w39_s1 : segOk (w39.drop 3) 3 = true := by
  decide +kernel

theorem w39_s2 : segOk (w39.drop 6) 4 = true := by
  decide +kernel

theorem w39_s3 : segOk (w39.drop 10) 4 = true := by
  decide +kernel

theorem w39_s4 : segOk (w39.drop 14) 5 = true := by
  decide +kernel

theorem w39_s5 : segOk (w39.drop 19) 6 = true := by
  decide +kernel

theorem w39_s6 : segOk (w39.drop 25) 8 = true := by
  decide +kernel

theorem w39_s7 : segOk (w39.drop 33) 13 = true := by
  decide +kernel

theorem w39_s8 : segOk (w39.drop 46) 32 = true := by
  decide +kernel

theorem w39_end : noThree (w39.drop 78) = true := by
  decide +kernel

theorem w39_noThree : noThree (w39.drop 0) = true :=
  chain (a := 0) (k := 3) w39_s0
    (chain (a := 3) (k := 3) w39_s1
    (chain (a := 6) (k := 4) w39_s2
    (chain (a := 10) (k := 4) w39_s3
    (chain (a := 14) (k := 5) w39_s4
    (chain (a := 19) (k := 6) w39_s5
    (chain (a := 25) (k := 8) w39_s6
    (chain (a := 33) (k := 13) w39_s7
    (chain (a := 46) (k := 32) w39_s8
    (w39_end)))))))))

theorem w39_rest : inGrid 39 w39 = true ∧ w39.Nodup ∧ w39.length = 2 * 39 := by
  decide +kernel

theorem w39_ok : noThree w39 = true ∧ inGrid 39 w39 = true ∧ w39.Nodup ∧ w39.length = 2 * 39 :=
  ⟨w39_noThree, w39_rest⟩

end Green72Data
