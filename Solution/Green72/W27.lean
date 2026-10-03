import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w27_c0 : prefixOk 17 (w27.drop (0 * 17)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c1 : prefixOk 17 (w27.drop (1 * 17)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c2 : prefixOk 17 (w27.drop (2 * 17)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w27_c3 : prefixOk 17 (w27.drop (3 * 17)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w27_nodup : w27.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w27_grid : inGrid 27 w27 = true ∧ w27.length = 2 * 27 := by decide +kernel

theorem w27_ok : noThree w27 = true ∧ inGrid 27 w27 = true ∧ w27.Nodup ∧ w27.length = 2 * 27 :=
  ⟨noThree_of_chunks 17 4 w27 (Nat.le_trans (Nat.le_of_eq w27_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w27_c0
      | 1, _ => w27_c1
      | 2, _ => w27_c2
      | 3, _ => w27_c3
      | _ + 4, h => absurd h (by omega)),
    w27_grid.1, w27_nodup, w27_grid.2⟩

end Green72Data
