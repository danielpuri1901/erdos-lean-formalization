import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w43_c0 : prefixOk 6 (w43.drop (0 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c1 : prefixOk 6 (w43.drop (1 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c2 : prefixOk 6 (w43.drop (2 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c3 : prefixOk 6 (w43.drop (3 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c4 : prefixOk 6 (w43.drop (4 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c5 : prefixOk 6 (w43.drop (5 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c6 : prefixOk 6 (w43.drop (6 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c7 : prefixOk 6 (w43.drop (7 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c8 : prefixOk 6 (w43.drop (8 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c9 : prefixOk 6 (w43.drop (9 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c10 : prefixOk 6 (w43.drop (10 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c11 : prefixOk 6 (w43.drop (11 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c12 : prefixOk 6 (w43.drop (12 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c13 : prefixOk 6 (w43.drop (13 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_c14 : prefixOk 6 (w43.drop (14 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_nodup : w43.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w43_grid : inGrid 43 w43 = true ∧ w43.length = 2 * 43 := by decide +kernel

theorem w43_ok : noThree w43 = true ∧ inGrid 43 w43 = true ∧ w43.Nodup ∧ w43.length = 2 * 43 :=
  ⟨noThree_of_chunks 6 15 w43 (Nat.le_trans (Nat.le_of_eq w43_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w43_c0
      | 1, _ => w43_c1
      | 2, _ => w43_c2
      | 3, _ => w43_c3
      | 4, _ => w43_c4
      | 5, _ => w43_c5
      | 6, _ => w43_c6
      | 7, _ => w43_c7
      | 8, _ => w43_c8
      | 9, _ => w43_c9
      | 10, _ => w43_c10
      | 11, _ => w43_c11
      | 12, _ => w43_c12
      | 13, _ => w43_c13
      | 14, _ => w43_c14
      | _ + 15, h => absurd h (by omega)),
    w43_grid.1, w43_nodup, w43_grid.2⟩

end Green72Data
