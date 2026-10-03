import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w40_c0 : prefixOk 7 (w40.drop (0 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c1 : prefixOk 7 (w40.drop (1 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c2 : prefixOk 7 (w40.drop (2 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c3 : prefixOk 7 (w40.drop (3 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c4 : prefixOk 7 (w40.drop (4 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c5 : prefixOk 7 (w40.drop (5 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c6 : prefixOk 7 (w40.drop (6 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c7 : prefixOk 7 (w40.drop (7 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c8 : prefixOk 7 (w40.drop (8 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c9 : prefixOk 7 (w40.drop (9 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c10 : prefixOk 7 (w40.drop (10 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_c11 : prefixOk 7 (w40.drop (11 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_nodup : w40.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w40_grid : inGrid 40 w40 = true ∧ w40.length = 2 * 40 := by decide +kernel

theorem w40_ok : noThree w40 = true ∧ inGrid 40 w40 = true ∧ w40.Nodup ∧ w40.length = 2 * 40 :=
  ⟨noThree_of_chunks 7 12 w40 (Nat.le_trans (Nat.le_of_eq w40_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w40_c0
      | 1, _ => w40_c1
      | 2, _ => w40_c2
      | 3, _ => w40_c3
      | 4, _ => w40_c4
      | 5, _ => w40_c5
      | 6, _ => w40_c6
      | 7, _ => w40_c7
      | 8, _ => w40_c8
      | 9, _ => w40_c9
      | 10, _ => w40_c10
      | 11, _ => w40_c11
      | _ + 12, h => absurd h (by omega)),
    w40_grid.1, w40_nodup, w40_grid.2⟩

end Green72Data
