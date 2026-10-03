import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w50_c0 : prefixOk 5 (w50.drop (0 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c1 : prefixOk 5 (w50.drop (1 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c2 : prefixOk 5 (w50.drop (2 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c3 : prefixOk 5 (w50.drop (3 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c4 : prefixOk 5 (w50.drop (4 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c5 : prefixOk 5 (w50.drop (5 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c6 : prefixOk 5 (w50.drop (6 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c7 : prefixOk 5 (w50.drop (7 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c8 : prefixOk 5 (w50.drop (8 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c9 : prefixOk 5 (w50.drop (9 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c10 : prefixOk 5 (w50.drop (10 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c11 : prefixOk 5 (w50.drop (11 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c12 : prefixOk 5 (w50.drop (12 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c13 : prefixOk 5 (w50.drop (13 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c14 : prefixOk 5 (w50.drop (14 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c15 : prefixOk 5 (w50.drop (15 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c16 : prefixOk 5 (w50.drop (16 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c17 : prefixOk 5 (w50.drop (17 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c18 : prefixOk 5 (w50.drop (18 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_c19 : prefixOk 5 (w50.drop (19 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_nodup : w50.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w50_grid : inGrid 50 w50 = true ∧ w50.length = 2 * 50 := by decide +kernel

theorem w50_ok : noThree w50 = true ∧ inGrid 50 w50 = true ∧ w50.Nodup ∧ w50.length = 2 * 50 :=
  ⟨noThree_of_chunks 5 20 w50 (Nat.le_trans (Nat.le_of_eq w50_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w50_c0
      | 1, _ => w50_c1
      | 2, _ => w50_c2
      | 3, _ => w50_c3
      | 4, _ => w50_c4
      | 5, _ => w50_c5
      | 6, _ => w50_c6
      | 7, _ => w50_c7
      | 8, _ => w50_c8
      | 9, _ => w50_c9
      | 10, _ => w50_c10
      | 11, _ => w50_c11
      | 12, _ => w50_c12
      | 13, _ => w50_c13
      | 14, _ => w50_c14
      | 15, _ => w50_c15
      | 16, _ => w50_c16
      | 17, _ => w50_c17
      | 18, _ => w50_c18
      | 19, _ => w50_c19
      | _ + 20, h => absurd h (by omega)),
    w50_grid.1, w50_nodup, w50_grid.2⟩

end Green72Data
