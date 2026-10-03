import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w48_c0 : prefixOk 5 (w48.drop (0 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c1 : prefixOk 5 (w48.drop (1 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c2 : prefixOk 5 (w48.drop (2 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c3 : prefixOk 5 (w48.drop (3 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c4 : prefixOk 5 (w48.drop (4 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c5 : prefixOk 5 (w48.drop (5 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c6 : prefixOk 5 (w48.drop (6 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c7 : prefixOk 5 (w48.drop (7 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c8 : prefixOk 5 (w48.drop (8 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c9 : prefixOk 5 (w48.drop (9 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c10 : prefixOk 5 (w48.drop (10 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c11 : prefixOk 5 (w48.drop (11 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c12 : prefixOk 5 (w48.drop (12 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c13 : prefixOk 5 (w48.drop (13 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c14 : prefixOk 5 (w48.drop (14 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c15 : prefixOk 5 (w48.drop (15 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c16 : prefixOk 5 (w48.drop (16 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c17 : prefixOk 5 (w48.drop (17 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c18 : prefixOk 5 (w48.drop (18 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_c19 : prefixOk 5 (w48.drop (19 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_nodup : w48.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w48_grid : inGrid 48 w48 = true ∧ w48.length = 2 * 48 := by decide +kernel

theorem w48_ok : noThree w48 = true ∧ inGrid 48 w48 = true ∧ w48.Nodup ∧ w48.length = 2 * 48 :=
  ⟨noThree_of_chunks 5 20 w48 (Nat.le_trans (Nat.le_of_eq w48_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w48_c0
      | 1, _ => w48_c1
      | 2, _ => w48_c2
      | 3, _ => w48_c3
      | 4, _ => w48_c4
      | 5, _ => w48_c5
      | 6, _ => w48_c6
      | 7, _ => w48_c7
      | 8, _ => w48_c8
      | 9, _ => w48_c9
      | 10, _ => w48_c10
      | 11, _ => w48_c11
      | 12, _ => w48_c12
      | 13, _ => w48_c13
      | 14, _ => w48_c14
      | 15, _ => w48_c15
      | 16, _ => w48_c16
      | 17, _ => w48_c17
      | 18, _ => w48_c18
      | 19, _ => w48_c19
      | _ + 20, h => absurd h (by omega)),
    w48_grid.1, w48_nodup, w48_grid.2⟩

end Green72Data
