import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w53_c0 : prefixOk 4 (w53.drop (0 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c1 : prefixOk 4 (w53.drop (1 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c2 : prefixOk 4 (w53.drop (2 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c3 : prefixOk 4 (w53.drop (3 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c4 : prefixOk 4 (w53.drop (4 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c5 : prefixOk 4 (w53.drop (5 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c6 : prefixOk 4 (w53.drop (6 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c7 : prefixOk 4 (w53.drop (7 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c8 : prefixOk 4 (w53.drop (8 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c9 : prefixOk 4 (w53.drop (9 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c10 : prefixOk 4 (w53.drop (10 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c11 : prefixOk 4 (w53.drop (11 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c12 : prefixOk 4 (w53.drop (12 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c13 : prefixOk 4 (w53.drop (13 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c14 : prefixOk 4 (w53.drop (14 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c15 : prefixOk 4 (w53.drop (15 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c16 : prefixOk 4 (w53.drop (16 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c17 : prefixOk 4 (w53.drop (17 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c18 : prefixOk 4 (w53.drop (18 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c19 : prefixOk 4 (w53.drop (19 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c20 : prefixOk 4 (w53.drop (20 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c21 : prefixOk 4 (w53.drop (21 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c22 : prefixOk 4 (w53.drop (22 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c23 : prefixOk 4 (w53.drop (23 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c24 : prefixOk 4 (w53.drop (24 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c25 : prefixOk 4 (w53.drop (25 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_c26 : prefixOk 4 (w53.drop (26 * 4)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_nodup : w53.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w53_grid : inGrid 53 w53 = true ∧ w53.length = 2 * 53 := by decide +kernel

theorem w53_ok : noThree w53 = true ∧ inGrid 53 w53 = true ∧ w53.Nodup ∧ w53.length = 2 * 53 :=
  ⟨noThree_of_chunks 4 27 w53 (Nat.le_trans (Nat.le_of_eq w53_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w53_c0
      | 1, _ => w53_c1
      | 2, _ => w53_c2
      | 3, _ => w53_c3
      | 4, _ => w53_c4
      | 5, _ => w53_c5
      | 6, _ => w53_c6
      | 7, _ => w53_c7
      | 8, _ => w53_c8
      | 9, _ => w53_c9
      | 10, _ => w53_c10
      | 11, _ => w53_c11
      | 12, _ => w53_c12
      | 13, _ => w53_c13
      | 14, _ => w53_c14
      | 15, _ => w53_c15
      | 16, _ => w53_c16
      | 17, _ => w53_c17
      | 18, _ => w53_c18
      | 19, _ => w53_c19
      | 20, _ => w53_c20
      | 21, _ => w53_c21
      | 22, _ => w53_c22
      | 23, _ => w53_c23
      | 24, _ => w53_c24
      | 25, _ => w53_c25
      | 26, _ => w53_c26
      | _ + 27, h => absurd h (by omega)),
    w53_grid.1, w53_nodup, w53_grid.2⟩

end Green72Data
