import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w46_c0 : prefixOk 5 (w46.drop (0 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c1 : prefixOk 5 (w46.drop (1 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c2 : prefixOk 5 (w46.drop (2 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c3 : prefixOk 5 (w46.drop (3 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c4 : prefixOk 5 (w46.drop (4 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c5 : prefixOk 5 (w46.drop (5 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c6 : prefixOk 5 (w46.drop (6 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c7 : prefixOk 5 (w46.drop (7 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c8 : prefixOk 5 (w46.drop (8 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c9 : prefixOk 5 (w46.drop (9 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c10 : prefixOk 5 (w46.drop (10 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c11 : prefixOk 5 (w46.drop (11 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c12 : prefixOk 5 (w46.drop (12 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c13 : prefixOk 5 (w46.drop (13 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c14 : prefixOk 5 (w46.drop (14 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c15 : prefixOk 5 (w46.drop (15 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c16 : prefixOk 5 (w46.drop (16 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c17 : prefixOk 5 (w46.drop (17 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_c18 : prefixOk 5 (w46.drop (18 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_nodup : w46.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w46_grid : inGrid 46 w46 = true ∧ w46.length = 2 * 46 := by decide +kernel

theorem w46_ok : noThree w46 = true ∧ inGrid 46 w46 = true ∧ w46.Nodup ∧ w46.length = 2 * 46 :=
  ⟨noThree_of_chunks 5 19 w46 (Nat.le_trans (Nat.le_of_eq w46_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w46_c0
      | 1, _ => w46_c1
      | 2, _ => w46_c2
      | 3, _ => w46_c3
      | 4, _ => w46_c4
      | 5, _ => w46_c5
      | 6, _ => w46_c6
      | 7, _ => w46_c7
      | 8, _ => w46_c8
      | 9, _ => w46_c9
      | 10, _ => w46_c10
      | 11, _ => w46_c11
      | 12, _ => w46_c12
      | 13, _ => w46_c13
      | 14, _ => w46_c14
      | 15, _ => w46_c15
      | 16, _ => w46_c16
      | 17, _ => w46_c17
      | 18, _ => w46_c18
      | _ + 19, h => absurd h (by omega)),
    w46_grid.1, w46_nodup, w46_grid.2⟩

end Green72Data
