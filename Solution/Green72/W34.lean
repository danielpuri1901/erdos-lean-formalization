import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w34_c0 : prefixOk 10 (w34.drop (0 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c1 : prefixOk 10 (w34.drop (1 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c2 : prefixOk 10 (w34.drop (2 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c3 : prefixOk 10 (w34.drop (3 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c4 : prefixOk 10 (w34.drop (4 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c5 : prefixOk 10 (w34.drop (5 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_c6 : prefixOk 10 (w34.drop (6 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_nodup : w34.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w34_grid : inGrid 34 w34 = true ∧ w34.length = 2 * 34 := by decide +kernel

theorem w34_ok : noThree w34 = true ∧ inGrid 34 w34 = true ∧ w34.Nodup ∧ w34.length = 2 * 34 :=
  ⟨noThree_of_chunks 10 7 w34 (Nat.le_trans (Nat.le_of_eq w34_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w34_c0
      | 1, _ => w34_c1
      | 2, _ => w34_c2
      | 3, _ => w34_c3
      | 4, _ => w34_c4
      | 5, _ => w34_c5
      | 6, _ => w34_c6
      | _ + 7, h => absurd h (by omega)),
    w34_grid.1, w34_nodup, w34_grid.2⟩

end Green72Data
