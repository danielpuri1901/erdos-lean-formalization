import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w49_c0 : prefixOk 5 (w49.drop (0 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c1 : prefixOk 5 (w49.drop (1 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c2 : prefixOk 5 (w49.drop (2 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c3 : prefixOk 5 (w49.drop (3 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c4 : prefixOk 5 (w49.drop (4 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c5 : prefixOk 5 (w49.drop (5 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c6 : prefixOk 5 (w49.drop (6 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c7 : prefixOk 5 (w49.drop (7 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c8 : prefixOk 5 (w49.drop (8 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c9 : prefixOk 5 (w49.drop (9 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c10 : prefixOk 5 (w49.drop (10 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c11 : prefixOk 5 (w49.drop (11 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c12 : prefixOk 5 (w49.drop (12 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c13 : prefixOk 5 (w49.drop (13 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c14 : prefixOk 5 (w49.drop (14 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c15 : prefixOk 5 (w49.drop (15 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c16 : prefixOk 5 (w49.drop (16 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c17 : prefixOk 5 (w49.drop (17 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c18 : prefixOk 5 (w49.drop (18 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_c19 : prefixOk 5 (w49.drop (19 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_nodup : w49.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w49_grid : inGrid 49 w49 = true ∧ w49.length = 2 * 49 := by decide +kernel

theorem w49_ok : noThree w49 = true ∧ inGrid 49 w49 = true ∧ w49.Nodup ∧ w49.length = 2 * 49 :=
  ⟨noThree_of_chunks 5 20 w49 (Nat.le_trans (Nat.le_of_eq w49_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w49_c0
      | 1, _ => w49_c1
      | 2, _ => w49_c2
      | 3, _ => w49_c3
      | 4, _ => w49_c4
      | 5, _ => w49_c5
      | 6, _ => w49_c6
      | 7, _ => w49_c7
      | 8, _ => w49_c8
      | 9, _ => w49_c9
      | 10, _ => w49_c10
      | 11, _ => w49_c11
      | 12, _ => w49_c12
      | 13, _ => w49_c13
      | 14, _ => w49_c14
      | 15, _ => w49_c15
      | 16, _ => w49_c16
      | 17, _ => w49_c17
      | 18, _ => w49_c18
      | 19, _ => w49_c19
      | _ + 20, h => absurd h (by omega)),
    w49_grid.1, w49_nodup, w49_grid.2⟩

end Green72Data
