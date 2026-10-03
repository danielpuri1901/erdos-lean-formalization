import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w36_c0 : prefixOk 9 (w36.drop (0 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c1 : prefixOk 9 (w36.drop (1 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c2 : prefixOk 9 (w36.drop (2 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c3 : prefixOk 9 (w36.drop (3 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c4 : prefixOk 9 (w36.drop (4 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c5 : prefixOk 9 (w36.drop (5 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c6 : prefixOk 9 (w36.drop (6 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_c7 : prefixOk 9 (w36.drop (7 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_nodup : w36.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w36_grid : inGrid 36 w36 = true ∧ w36.length = 2 * 36 := by decide +kernel

theorem w36_ok : noThree w36 = true ∧ inGrid 36 w36 = true ∧ w36.Nodup ∧ w36.length = 2 * 36 :=
  ⟨noThree_of_chunks 9 8 w36 (Nat.le_trans (Nat.le_of_eq w36_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w36_c0
      | 1, _ => w36_c1
      | 2, _ => w36_c2
      | 3, _ => w36_c3
      | 4, _ => w36_c4
      | 5, _ => w36_c5
      | 6, _ => w36_c6
      | 7, _ => w36_c7
      | _ + 8, h => absurd h (by omega)),
    w36_grid.1, w36_nodup, w36_grid.2⟩

end Green72Data
