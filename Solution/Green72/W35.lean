import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w35_c0 : prefixOk 10 (w35.drop (0 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c1 : prefixOk 10 (w35.drop (1 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c2 : prefixOk 10 (w35.drop (2 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c3 : prefixOk 10 (w35.drop (3 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c4 : prefixOk 10 (w35.drop (4 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c5 : prefixOk 10 (w35.drop (5 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_c6 : prefixOk 10 (w35.drop (6 * 10)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_nodup : w35.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w35_grid : inGrid 35 w35 = true ∧ w35.length = 2 * 35 := by decide +kernel

theorem w35_ok : noThree w35 = true ∧ inGrid 35 w35 = true ∧ w35.Nodup ∧ w35.length = 2 * 35 :=
  ⟨noThree_of_chunks 10 7 w35 (Nat.le_trans (Nat.le_of_eq w35_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w35_c0
      | 1, _ => w35_c1
      | 2, _ => w35_c2
      | 3, _ => w35_c3
      | 4, _ => w35_c4
      | 5, _ => w35_c5
      | 6, _ => w35_c6
      | _ + 7, h => absurd h (by omega)),
    w35_grid.1, w35_nodup, w35_grid.2⟩

end Green72Data
