import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w55_c0 : prefixOk 4 (w55.drop (0 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c1 : prefixOk 4 (w55.drop (1 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c2 : prefixOk 4 (w55.drop (2 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c3 : prefixOk 4 (w55.drop (3 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c4 : prefixOk 4 (w55.drop (4 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c5 : prefixOk 4 (w55.drop (5 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c6 : prefixOk 4 (w55.drop (6 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c7 : prefixOk 4 (w55.drop (7 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c8 : prefixOk 4 (w55.drop (8 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c9 : prefixOk 4 (w55.drop (9 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c10 : prefixOk 4 (w55.drop (10 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c11 : prefixOk 4 (w55.drop (11 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c12 : prefixOk 4 (w55.drop (12 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c13 : prefixOk 4 (w55.drop (13 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c14 : prefixOk 4 (w55.drop (14 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c15 : prefixOk 4 (w55.drop (15 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c16 : prefixOk 4 (w55.drop (16 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c17 : prefixOk 4 (w55.drop (17 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c18 : prefixOk 4 (w55.drop (18 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c19 : prefixOk 4 (w55.drop (19 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c20 : prefixOk 4 (w55.drop (20 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c21 : prefixOk 4 (w55.drop (21 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c22 : prefixOk 4 (w55.drop (22 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c23 : prefixOk 4 (w55.drop (23 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c24 : prefixOk 4 (w55.drop (24 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c25 : prefixOk 4 (w55.drop (25 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c26 : prefixOk 4 (w55.drop (26 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_c27 : prefixOk 4 (w55.drop (27 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_nodup : w55.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w55_grid : inGrid 55 w55 = true ∧ w55.length = 2 * 55 := by decide +kernel

theorem w55_ok : noThree w55 = true ∧ inGrid 55 w55 = true ∧ w55.Nodup ∧ w55.length = 2 * 55 :=
  ⟨noThree_of_chunks 4 28 w55 (Nat.le_trans (Nat.le_of_eq w55_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w55_c0
      | 1, _ => w55_c1
      | 2, _ => w55_c2
      | 3, _ => w55_c3
      | 4, _ => w55_c4
      | 5, _ => w55_c5
      | 6, _ => w55_c6
      | 7, _ => w55_c7
      | 8, _ => w55_c8
      | 9, _ => w55_c9
      | 10, _ => w55_c10
      | 11, _ => w55_c11
      | 12, _ => w55_c12
      | 13, _ => w55_c13
      | 14, _ => w55_c14
      | 15, _ => w55_c15
      | 16, _ => w55_c16
      | 17, _ => w55_c17
      | 18, _ => w55_c18
      | 19, _ => w55_c19
      | 20, _ => w55_c20
      | 21, _ => w55_c21
      | 22, _ => w55_c22
      | 23, _ => w55_c23
      | 24, _ => w55_c24
      | 25, _ => w55_c25
      | 26, _ => w55_c26
      | 27, _ => w55_c27
      | _ + 28, h => absurd h (by omega)),
    w55_grid.1, w55_nodup, w55_grid.2⟩

end Green72Data
