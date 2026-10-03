import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w52_c0 : prefixOk 4 (w52.drop (0 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c1 : prefixOk 4 (w52.drop (1 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c2 : prefixOk 4 (w52.drop (2 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c3 : prefixOk 4 (w52.drop (3 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c4 : prefixOk 4 (w52.drop (4 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c5 : prefixOk 4 (w52.drop (5 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c6 : prefixOk 4 (w52.drop (6 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c7 : prefixOk 4 (w52.drop (7 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c8 : prefixOk 4 (w52.drop (8 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c9 : prefixOk 4 (w52.drop (9 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c10 : prefixOk 4 (w52.drop (10 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c11 : prefixOk 4 (w52.drop (11 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c12 : prefixOk 4 (w52.drop (12 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c13 : prefixOk 4 (w52.drop (13 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c14 : prefixOk 4 (w52.drop (14 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c15 : prefixOk 4 (w52.drop (15 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c16 : prefixOk 4 (w52.drop (16 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c17 : prefixOk 4 (w52.drop (17 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c18 : prefixOk 4 (w52.drop (18 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c19 : prefixOk 4 (w52.drop (19 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c20 : prefixOk 4 (w52.drop (20 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c21 : prefixOk 4 (w52.drop (21 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c22 : prefixOk 4 (w52.drop (22 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c23 : prefixOk 4 (w52.drop (23 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c24 : prefixOk 4 (w52.drop (24 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_c25 : prefixOk 4 (w52.drop (25 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_nodup : w52.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w52_grid : inGrid 52 w52 = true ∧ w52.length = 2 * 52 := by decide +kernel

theorem w52_ok : noThree w52 = true ∧ inGrid 52 w52 = true ∧ w52.Nodup ∧ w52.length = 2 * 52 :=
  ⟨noThree_of_chunks 4 26 w52 (Nat.le_trans (Nat.le_of_eq w52_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w52_c0
      | 1, _ => w52_c1
      | 2, _ => w52_c2
      | 3, _ => w52_c3
      | 4, _ => w52_c4
      | 5, _ => w52_c5
      | 6, _ => w52_c6
      | 7, _ => w52_c7
      | 8, _ => w52_c8
      | 9, _ => w52_c9
      | 10, _ => w52_c10
      | 11, _ => w52_c11
      | 12, _ => w52_c12
      | 13, _ => w52_c13
      | 14, _ => w52_c14
      | 15, _ => w52_c15
      | 16, _ => w52_c16
      | 17, _ => w52_c17
      | 18, _ => w52_c18
      | 19, _ => w52_c19
      | 20, _ => w52_c20
      | 21, _ => w52_c21
      | 22, _ => w52_c22
      | 23, _ => w52_c23
      | 24, _ => w52_c24
      | 25, _ => w52_c25
      | _ + 26, h => absurd h (by omega)),
    w52_grid.1, w52_nodup, w52_grid.2⟩

end Green72Data
