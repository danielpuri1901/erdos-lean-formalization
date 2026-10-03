import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w38_c0 : prefixOk 8 (w38.drop (0 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c1 : prefixOk 8 (w38.drop (1 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c2 : prefixOk 8 (w38.drop (2 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c3 : prefixOk 8 (w38.drop (3 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c4 : prefixOk 8 (w38.drop (4 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c5 : prefixOk 8 (w38.drop (5 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c6 : prefixOk 8 (w38.drop (6 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c7 : prefixOk 8 (w38.drop (7 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c8 : prefixOk 8 (w38.drop (8 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_c9 : prefixOk 8 (w38.drop (9 * 8)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_nodup : w38.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w38_grid : inGrid 38 w38 = true ∧ w38.length = 2 * 38 := by decide +kernel

theorem w38_ok : noThree w38 = true ∧ inGrid 38 w38 = true ∧ w38.Nodup ∧ w38.length = 2 * 38 :=
  ⟨noThree_of_chunks 8 10 w38 (Nat.le_trans (Nat.le_of_eq w38_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w38_c0
      | 1, _ => w38_c1
      | 2, _ => w38_c2
      | 3, _ => w38_c3
      | 4, _ => w38_c4
      | 5, _ => w38_c5
      | 6, _ => w38_c6
      | 7, _ => w38_c7
      | 8, _ => w38_c8
      | 9, _ => w38_c9
      | _ + 10, h => absurd h (by omega)),
    w38_grid.1, w38_nodup, w38_grid.2⟩

end Green72Data
