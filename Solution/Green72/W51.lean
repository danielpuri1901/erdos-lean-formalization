import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w51_c0 : prefixOk 4 (w51.drop (0 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c1 : prefixOk 4 (w51.drop (1 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c2 : prefixOk 4 (w51.drop (2 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c3 : prefixOk 4 (w51.drop (3 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c4 : prefixOk 4 (w51.drop (4 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c5 : prefixOk 4 (w51.drop (5 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c6 : prefixOk 4 (w51.drop (6 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c7 : prefixOk 4 (w51.drop (7 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c8 : prefixOk 4 (w51.drop (8 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c9 : prefixOk 4 (w51.drop (9 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c10 : prefixOk 4 (w51.drop (10 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c11 : prefixOk 4 (w51.drop (11 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c12 : prefixOk 4 (w51.drop (12 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c13 : prefixOk 4 (w51.drop (13 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c14 : prefixOk 4 (w51.drop (14 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c15 : prefixOk 4 (w51.drop (15 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c16 : prefixOk 4 (w51.drop (16 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c17 : prefixOk 4 (w51.drop (17 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c18 : prefixOk 4 (w51.drop (18 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c19 : prefixOk 4 (w51.drop (19 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c20 : prefixOk 4 (w51.drop (20 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c21 : prefixOk 4 (w51.drop (21 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c22 : prefixOk 4 (w51.drop (22 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c23 : prefixOk 4 (w51.drop (23 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c24 : prefixOk 4 (w51.drop (24 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_c25 : prefixOk 4 (w51.drop (25 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_nodup : w51.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w51_grid : inGrid 51 w51 = true ∧ w51.length = 2 * 51 := by decide +kernel

theorem w51_ok : noThree w51 = true ∧ inGrid 51 w51 = true ∧ w51.Nodup ∧ w51.length = 2 * 51 :=
  ⟨noThree_of_chunks 4 26 w51 (Nat.le_trans (Nat.le_of_eq w51_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w51_c0
      | 1, _ => w51_c1
      | 2, _ => w51_c2
      | 3, _ => w51_c3
      | 4, _ => w51_c4
      | 5, _ => w51_c5
      | 6, _ => w51_c6
      | 7, _ => w51_c7
      | 8, _ => w51_c8
      | 9, _ => w51_c9
      | 10, _ => w51_c10
      | 11, _ => w51_c11
      | 12, _ => w51_c12
      | 13, _ => w51_c13
      | 14, _ => w51_c14
      | 15, _ => w51_c15
      | 16, _ => w51_c16
      | 17, _ => w51_c17
      | 18, _ => w51_c18
      | 19, _ => w51_c19
      | 20, _ => w51_c20
      | 21, _ => w51_c21
      | 22, _ => w51_c22
      | 23, _ => w51_c23
      | 24, _ => w51_c24
      | 25, _ => w51_c25
      | _ + 26, h => absurd h (by omega)),
    w51_grid.1, w51_nodup, w51_grid.2⟩

end Green72Data
