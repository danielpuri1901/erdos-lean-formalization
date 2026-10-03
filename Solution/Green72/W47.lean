import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 47, split into 17 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w47_s0 : segOk (w47.drop 0) 2 = true := by
  decide +kernel

theorem w47_s1 : segOk (w47.drop 2) 2 = true := by
  decide +kernel

theorem w47_s2 : segOk (w47.drop 4) 2 = true := by
  decide +kernel

theorem w47_s3 : segOk (w47.drop 6) 2 = true := by
  decide +kernel

theorem w47_s4 : segOk (w47.drop 8) 2 = true := by
  decide +kernel

theorem w47_s5 : segOk (w47.drop 10) 2 = true := by
  decide +kernel

theorem w47_s6 : segOk (w47.drop 12) 3 = true := by
  decide +kernel

theorem w47_s7 : segOk (w47.drop 15) 3 = true := by
  decide +kernel

theorem w47_s8 : segOk (w47.drop 18) 3 = true := by
  decide +kernel

theorem w47_s9 : segOk (w47.drop 21) 3 = true := by
  decide +kernel

theorem w47_s10 : segOk (w47.drop 24) 4 = true := by
  decide +kernel

theorem w47_s11 : segOk (w47.drop 28) 4 = true := by
  decide +kernel

theorem w47_s12 : segOk (w47.drop 32) 5 = true := by
  decide +kernel

theorem w47_s13 : segOk (w47.drop 37) 6 = true := by
  decide +kernel

theorem w47_s14 : segOk (w47.drop 43) 9 = true := by
  decide +kernel

theorem w47_s15 : segOk (w47.drop 52) 17 = true := by
  decide +kernel

theorem w47_s16 : segOk (w47.drop 69) 25 = true := by
  decide +kernel

theorem w47_end : noThree (w47.drop 94) = true := by
  decide +kernel

theorem w47_noThree : noThree (w47.drop 0) = true :=
  chain (a := 0) (k := 2) w47_s0
    (chain (a := 2) (k := 2) w47_s1
    (chain (a := 4) (k := 2) w47_s2
    (chain (a := 6) (k := 2) w47_s3
    (chain (a := 8) (k := 2) w47_s4
    (chain (a := 10) (k := 2) w47_s5
    (chain (a := 12) (k := 3) w47_s6
    (chain (a := 15) (k := 3) w47_s7
    (chain (a := 18) (k := 3) w47_s8
    (chain (a := 21) (k := 3) w47_s9
    (chain (a := 24) (k := 4) w47_s10
    (chain (a := 28) (k := 4) w47_s11
    (chain (a := 32) (k := 5) w47_s12
    (chain (a := 37) (k := 6) w47_s13
    (chain (a := 43) (k := 9) w47_s14
    (chain (a := 52) (k := 17) w47_s15
    (chain (a := 69) (k := 25) w47_s16
    (w47_end)))))))))))))))))

theorem w47_rest : inGrid 47 w47 = true ∧ w47.Nodup ∧ w47.length = 2 * 47 := by
  decide +kernel

theorem w47_ok : noThree w47 = true ∧ inGrid 47 w47 = true ∧ w47.Nodup ∧ w47.length = 2 * 47 :=
  ⟨w47_noThree, w47_rest⟩

end Green72Data
