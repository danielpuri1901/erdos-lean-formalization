import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w28_c0 : prefixOk 15 (w28.drop (0 * 15)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c1 : prefixOk 15 (w28.drop (1 * 15)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c2 : prefixOk 15 (w28.drop (2 * 15)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w28_c3 : prefixOk 15 (w28.drop (3 * 15)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w28_nodup : w28.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w28_grid : inGrid 28 w28 = true ∧ w28.length = 2 * 28 := by decide +kernel

theorem w28_ok : noThree w28 = true ∧ inGrid 28 w28 = true ∧ w28.Nodup ∧ w28.length = 2 * 28 :=
  ⟨noThree_of_chunks 15 4 w28 (Nat.le_trans (Nat.le_of_eq w28_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w28_c0
      | 1, _ => w28_c1
      | 2, _ => w28_c2
      | 3, _ => w28_c3
      | _ + 4, h => absurd h (by omega)),
    w28_grid.1, w28_nodup, w28_grid.2⟩

end Green72Data
