import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w58_c0 : prefixOk 3 (w58.drop (0 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c1 : prefixOk 3 (w58.drop (1 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c2 : prefixOk 3 (w58.drop (2 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c3 : prefixOk 3 (w58.drop (3 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c4 : prefixOk 3 (w58.drop (4 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c5 : prefixOk 3 (w58.drop (5 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c6 : prefixOk 3 (w58.drop (6 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c7 : prefixOk 3 (w58.drop (7 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c8 : prefixOk 3 (w58.drop (8 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c9 : prefixOk 3 (w58.drop (9 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c10 : prefixOk 3 (w58.drop (10 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c11 : prefixOk 3 (w58.drop (11 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c12 : prefixOk 3 (w58.drop (12 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c13 : prefixOk 3 (w58.drop (13 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c14 : prefixOk 3 (w58.drop (14 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c15 : prefixOk 3 (w58.drop (15 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c16 : prefixOk 3 (w58.drop (16 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c17 : prefixOk 3 (w58.drop (17 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c18 : prefixOk 3 (w58.drop (18 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c19 : prefixOk 3 (w58.drop (19 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c20 : prefixOk 3 (w58.drop (20 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c21 : prefixOk 3 (w58.drop (21 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c22 : prefixOk 3 (w58.drop (22 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c23 : prefixOk 3 (w58.drop (23 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c24 : prefixOk 3 (w58.drop (24 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c25 : prefixOk 3 (w58.drop (25 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c26 : prefixOk 3 (w58.drop (26 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c27 : prefixOk 3 (w58.drop (27 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c28 : prefixOk 3 (w58.drop (28 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c29 : prefixOk 3 (w58.drop (29 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c30 : prefixOk 3 (w58.drop (30 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c31 : prefixOk 3 (w58.drop (31 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c32 : prefixOk 3 (w58.drop (32 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c33 : prefixOk 3 (w58.drop (33 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c34 : prefixOk 3 (w58.drop (34 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c35 : prefixOk 3 (w58.drop (35 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c36 : prefixOk 3 (w58.drop (36 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c37 : prefixOk 3 (w58.drop (37 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_c38 : prefixOk 3 (w58.drop (38 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_nodup : w58.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w58_grid : inGrid 58 w58 = true ∧ w58.length = 2 * 58 := by decide +kernel

theorem w58_ok : noThree w58 = true ∧ inGrid 58 w58 = true ∧ w58.Nodup ∧ w58.length = 2 * 58 :=
  ⟨noThree_of_chunks 3 39 w58 (Nat.le_trans (Nat.le_of_eq w58_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w58_c0
      | 1, _ => w58_c1
      | 2, _ => w58_c2
      | 3, _ => w58_c3
      | 4, _ => w58_c4
      | 5, _ => w58_c5
      | 6, _ => w58_c6
      | 7, _ => w58_c7
      | 8, _ => w58_c8
      | 9, _ => w58_c9
      | 10, _ => w58_c10
      | 11, _ => w58_c11
      | 12, _ => w58_c12
      | 13, _ => w58_c13
      | 14, _ => w58_c14
      | 15, _ => w58_c15
      | 16, _ => w58_c16
      | 17, _ => w58_c17
      | 18, _ => w58_c18
      | 19, _ => w58_c19
      | 20, _ => w58_c20
      | 21, _ => w58_c21
      | 22, _ => w58_c22
      | 23, _ => w58_c23
      | 24, _ => w58_c24
      | 25, _ => w58_c25
      | 26, _ => w58_c26
      | 27, _ => w58_c27
      | 28, _ => w58_c28
      | 29, _ => w58_c29
      | 30, _ => w58_c30
      | 31, _ => w58_c31
      | 32, _ => w58_c32
      | 33, _ => w58_c33
      | 34, _ => w58_c34
      | 35, _ => w58_c35
      | 36, _ => w58_c36
      | 37, _ => w58_c37
      | 38, _ => w58_c38
      | _ + 39, h => absurd h (by omega)),
    w58_grid.1, w58_nodup, w58_grid.2⟩

end Green72Data
