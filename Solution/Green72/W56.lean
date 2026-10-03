import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w56_c0 : prefixOk 3 (w56.drop (0 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c1 : prefixOk 3 (w56.drop (1 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c2 : prefixOk 3 (w56.drop (2 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c3 : prefixOk 3 (w56.drop (3 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c4 : prefixOk 3 (w56.drop (4 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c5 : prefixOk 3 (w56.drop (5 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c6 : prefixOk 3 (w56.drop (6 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c7 : prefixOk 3 (w56.drop (7 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c8 : prefixOk 3 (w56.drop (8 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c9 : prefixOk 3 (w56.drop (9 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c10 : prefixOk 3 (w56.drop (10 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c11 : prefixOk 3 (w56.drop (11 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c12 : prefixOk 3 (w56.drop (12 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c13 : prefixOk 3 (w56.drop (13 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c14 : prefixOk 3 (w56.drop (14 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c15 : prefixOk 3 (w56.drop (15 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c16 : prefixOk 3 (w56.drop (16 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c17 : prefixOk 3 (w56.drop (17 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c18 : prefixOk 3 (w56.drop (18 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c19 : prefixOk 3 (w56.drop (19 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c20 : prefixOk 3 (w56.drop (20 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c21 : prefixOk 3 (w56.drop (21 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c22 : prefixOk 3 (w56.drop (22 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c23 : prefixOk 3 (w56.drop (23 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c24 : prefixOk 3 (w56.drop (24 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c25 : prefixOk 3 (w56.drop (25 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c26 : prefixOk 3 (w56.drop (26 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c27 : prefixOk 3 (w56.drop (27 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c28 : prefixOk 3 (w56.drop (28 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c29 : prefixOk 3 (w56.drop (29 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c30 : prefixOk 3 (w56.drop (30 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c31 : prefixOk 3 (w56.drop (31 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c32 : prefixOk 3 (w56.drop (32 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c33 : prefixOk 3 (w56.drop (33 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c34 : prefixOk 3 (w56.drop (34 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c35 : prefixOk 3 (w56.drop (35 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c36 : prefixOk 3 (w56.drop (36 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_c37 : prefixOk 3 (w56.drop (37 * 3)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_nodup : w56.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w56_grid : inGrid 56 w56 = true ∧ w56.length = 2 * 56 := by decide +kernel

theorem w56_ok : noThree w56 = true ∧ inGrid 56 w56 = true ∧ w56.Nodup ∧ w56.length = 2 * 56 :=
  ⟨noThree_of_chunks 3 38 w56 (Nat.le_trans (Nat.le_of_eq w56_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w56_c0
      | 1, _ => w56_c1
      | 2, _ => w56_c2
      | 3, _ => w56_c3
      | 4, _ => w56_c4
      | 5, _ => w56_c5
      | 6, _ => w56_c6
      | 7, _ => w56_c7
      | 8, _ => w56_c8
      | 9, _ => w56_c9
      | 10, _ => w56_c10
      | 11, _ => w56_c11
      | 12, _ => w56_c12
      | 13, _ => w56_c13
      | 14, _ => w56_c14
      | 15, _ => w56_c15
      | 16, _ => w56_c16
      | 17, _ => w56_c17
      | 18, _ => w56_c18
      | 19, _ => w56_c19
      | 20, _ => w56_c20
      | 21, _ => w56_c21
      | 22, _ => w56_c22
      | 23, _ => w56_c23
      | 24, _ => w56_c24
      | 25, _ => w56_c25
      | 26, _ => w56_c26
      | 27, _ => w56_c27
      | 28, _ => w56_c28
      | 29, _ => w56_c29
      | 30, _ => w56_c30
      | 31, _ => w56_c31
      | 32, _ => w56_c32
      | 33, _ => w56_c33
      | 34, _ => w56_c34
      | 35, _ => w56_c35
      | 36, _ => w56_c36
      | 37, _ => w56_c37
      | _ + 38, h => absurd h (by omega)),
    w56_grid.1, w56_nodup, w56_grid.2⟩

end Green72Data
