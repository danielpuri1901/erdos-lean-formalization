import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w23_c0 : prefixOk 23 (w23.drop (0 * 23)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w23_c1 : prefixOk 23 (w23.drop (1 * 23)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w23_nodup : w23.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w23_grid : inGrid 23 w23 = true ∧ w23.length = 2 * 23 := by decide +kernel

theorem w23_ok : noThree w23 = true ∧ inGrid 23 w23 = true ∧ w23.Nodup ∧ w23.length = 2 * 23 :=
  ⟨noThree_of_chunks 23 2 w23 (Nat.le_trans (Nat.le_of_eq w23_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w23_c0
      | 1, _ => w23_c1
      | _ + 2, h => absurd h (by omega)),
    w23_grid.1, w23_nodup, w23_grid.2⟩

end Green72Data
