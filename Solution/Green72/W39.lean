import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w39_c0 : prefixOk 8 (w39.drop (0 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c1 : prefixOk 8 (w39.drop (1 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c2 : prefixOk 8 (w39.drop (2 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c3 : prefixOk 8 (w39.drop (3 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c4 : prefixOk 8 (w39.drop (4 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c5 : prefixOk 8 (w39.drop (5 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c6 : prefixOk 8 (w39.drop (6 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c7 : prefixOk 8 (w39.drop (7 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c8 : prefixOk 8 (w39.drop (8 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_c9 : prefixOk 8 (w39.drop (9 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_nodup : w39.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w39_grid : inGrid 39 w39 = true ∧ w39.length = 2 * 39 := by decide +kernel

theorem w39_ok : noThree w39 = true ∧ inGrid 39 w39 = true ∧ w39.Nodup ∧ w39.length = 2 * 39 :=
  ⟨noThree_of_chunks 8 10 w39 (Nat.le_trans (Nat.le_of_eq w39_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w39_c0
      | 1, _ => w39_c1
      | 2, _ => w39_c2
      | 3, _ => w39_c3
      | 4, _ => w39_c4
      | 5, _ => w39_c5
      | 6, _ => w39_c6
      | 7, _ => w39_c7
      | 8, _ => w39_c8
      | 9, _ => w39_c9
      | _ + 10, h => absurd h (by omega)),
    w39_grid.1, w39_nodup, w39_grid.2⟩

end Green72Data
