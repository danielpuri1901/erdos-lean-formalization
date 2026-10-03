import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w45_c0 : prefixOk 6 (w45.drop (0 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c1 : prefixOk 6 (w45.drop (1 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c2 : prefixOk 6 (w45.drop (2 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c3 : prefixOk 6 (w45.drop (3 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c4 : prefixOk 6 (w45.drop (4 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c5 : prefixOk 6 (w45.drop (5 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c6 : prefixOk 6 (w45.drop (6 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c7 : prefixOk 6 (w45.drop (7 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c8 : prefixOk 6 (w45.drop (8 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c9 : prefixOk 6 (w45.drop (9 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c10 : prefixOk 6 (w45.drop (10 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c11 : prefixOk 6 (w45.drop (11 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c12 : prefixOk 6 (w45.drop (12 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c13 : prefixOk 6 (w45.drop (13 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_c14 : prefixOk 6 (w45.drop (14 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_nodup : w45.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w45_grid : inGrid 45 w45 = true ∧ w45.length = 2 * 45 := by decide +kernel

theorem w45_ok : noThree w45 = true ∧ inGrid 45 w45 = true ∧ w45.Nodup ∧ w45.length = 2 * 45 :=
  ⟨noThree_of_chunks 6 15 w45 (Nat.le_trans (Nat.le_of_eq w45_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w45_c0
      | 1, _ => w45_c1
      | 2, _ => w45_c2
      | 3, _ => w45_c3
      | 4, _ => w45_c4
      | 5, _ => w45_c5
      | 6, _ => w45_c6
      | 7, _ => w45_c7
      | 8, _ => w45_c8
      | 9, _ => w45_c9
      | 10, _ => w45_c10
      | 11, _ => w45_c11
      | 12, _ => w45_c12
      | 13, _ => w45_c13
      | 14, _ => w45_c14
      | _ + 15, h => absurd h (by omega)),
    w45_grid.1, w45_nodup, w45_grid.2⟩

end Green72Data
