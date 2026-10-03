import Solution.Green72.Seg

/-! Kernel check of the green72 witness for N = 51, split into 21 chunks of about 10000 triples. -/

-- Check the chunks one after another, so only one kernel check is live at a time.
set_option Elab.async false

namespace Green72Data

theorem w51_s0 : segOk (w51.drop 0) 1 = true := by
  decide +kernel

theorem w51_s1 : segOk (w51.drop 1) 2 = true := by
  decide +kernel

theorem w51_s2 : segOk (w51.drop 3) 2 = true := by
  decide +kernel

theorem w51_s3 : segOk (w51.drop 5) 2 = true := by
  decide +kernel

theorem w51_s4 : segOk (w51.drop 7) 2 = true := by
  decide +kernel

theorem w51_s5 : segOk (w51.drop 9) 2 = true := by
  decide +kernel

theorem w51_s6 : segOk (w51.drop 11) 2 = true := by
  decide +kernel

theorem w51_s7 : segOk (w51.drop 13) 2 = true := by
  decide +kernel

theorem w51_s8 : segOk (w51.drop 15) 2 = true := by
  decide +kernel

theorem w51_s9 : segOk (w51.drop 17) 2 = true := by
  decide +kernel

theorem w51_s10 : segOk (w51.drop 19) 3 = true := by
  decide +kernel

theorem w51_s11 : segOk (w51.drop 22) 3 = true := by
  decide +kernel

theorem w51_s12 : segOk (w51.drop 25) 3 = true := by
  decide +kernel

theorem w51_s13 : segOk (w51.drop 28) 3 = true := by
  decide +kernel

theorem w51_s14 : segOk (w51.drop 31) 4 = true := by
  decide +kernel

theorem w51_s15 : segOk (w51.drop 35) 4 = true := by
  decide +kernel

theorem w51_s16 : segOk (w51.drop 39) 5 = true := by
  decide +kernel

theorem w51_s17 : segOk (w51.drop 44) 6 = true := by
  decide +kernel

theorem w51_s18 : segOk (w51.drop 50) 8 = true := by
  decide +kernel

theorem w51_s19 : segOk (w51.drop 58) 14 = true := by
  decide +kernel

theorem w51_s20 : segOk (w51.drop 72) 30 = true := by
  decide +kernel

theorem w51_end : noThree (w51.drop 102) = true := by
  decide +kernel

theorem w51_noThree : noThree (w51.drop 0) = true :=
  chain (a := 0) (k := 1) w51_s0
    (chain (a := 1) (k := 2) w51_s1
    (chain (a := 3) (k := 2) w51_s2
    (chain (a := 5) (k := 2) w51_s3
    (chain (a := 7) (k := 2) w51_s4
    (chain (a := 9) (k := 2) w51_s5
    (chain (a := 11) (k := 2) w51_s6
    (chain (a := 13) (k := 2) w51_s7
    (chain (a := 15) (k := 2) w51_s8
    (chain (a := 17) (k := 2) w51_s9
    (chain (a := 19) (k := 3) w51_s10
    (chain (a := 22) (k := 3) w51_s11
    (chain (a := 25) (k := 3) w51_s12
    (chain (a := 28) (k := 3) w51_s13
    (chain (a := 31) (k := 4) w51_s14
    (chain (a := 35) (k := 4) w51_s15
    (chain (a := 39) (k := 5) w51_s16
    (chain (a := 44) (k := 6) w51_s17
    (chain (a := 50) (k := 8) w51_s18
    (chain (a := 58) (k := 14) w51_s19
    (chain (a := 72) (k := 30) w51_s20
    (w51_end)))))))))))))))))))))

theorem w51_rest : inGrid 51 w51 = true ∧ w51.Nodup ∧ w51.length = 2 * 51 := by
  decide +kernel

theorem w51_ok : noThree w51 = true ∧ inGrid 51 w51 = true ∧ w51.Nodup ∧ w51.length = 2 * 51 :=
  ⟨w51_noThree, w51_rest⟩

end Green72Data
