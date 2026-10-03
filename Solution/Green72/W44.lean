import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 44, split into 14 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w44_s0 : segOk (w44.drop 0) 2 = true := by
  decide +kernel

theorem w44_s1 : segOk (w44.drop 2) 2 = true := by
  decide +kernel

theorem w44_s2 : segOk (w44.drop 4) 2 = true := by
  decide +kernel

theorem w44_s3 : segOk (w44.drop 6) 3 = true := by
  decide +kernel

theorem w44_s4 : segOk (w44.drop 9) 3 = true := by
  decide +kernel

theorem w44_s5 : segOk (w44.drop 12) 3 = true := by
  decide +kernel

theorem w44_s6 : segOk (w44.drop 15) 3 = true := by
  decide +kernel

theorem w44_s7 : segOk (w44.drop 18) 4 = true := by
  decide +kernel

theorem w44_s8 : segOk (w44.drop 22) 4 = true := by
  decide +kernel

theorem w44_s9 : segOk (w44.drop 26) 5 = true := by
  decide +kernel

theorem w44_s10 : segOk (w44.drop 31) 6 = true := by
  decide +kernel

theorem w44_s11 : segOk (w44.drop 37) 9 = true := by
  decide +kernel

theorem w44_s12 : segOk (w44.drop 46) 17 = true := by
  decide +kernel

theorem w44_s13 : segOk (w44.drop 63) 25 = true := by
  decide +kernel

theorem w44_end : noThree (w44.drop 88) = true := by
  decide +kernel

theorem w44_noThree : noThree (w44.drop 0) = true :=
  chain (a := 0) (k := 2) w44_s0
    (chain (a := 2) (k := 2) w44_s1
    (chain (a := 4) (k := 2) w44_s2
    (chain (a := 6) (k := 3) w44_s3
    (chain (a := 9) (k := 3) w44_s4
    (chain (a := 12) (k := 3) w44_s5
    (chain (a := 15) (k := 3) w44_s6
    (chain (a := 18) (k := 4) w44_s7
    (chain (a := 22) (k := 4) w44_s8
    (chain (a := 26) (k := 5) w44_s9
    (chain (a := 31) (k := 6) w44_s10
    (chain (a := 37) (k := 9) w44_s11
    (chain (a := 46) (k := 17) w44_s12
    (chain (a := 63) (k := 25) w44_s13
    (w44_end))))))))))))))

theorem w44_rest : inGrid 44 w44 = true ∧ w44.Nodup ∧ w44.length = 2 * 44 := by
  decide +kernel

theorem w44_ok : noThree w44 = true ∧ inGrid 44 w44 = true ∧ w44.Nodup ∧ w44.length = 2 * 44 :=
  ⟨w44_noThree, w44_rest⟩

end Green72Data
