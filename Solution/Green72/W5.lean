import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w5_c0 : prefixOk 500 (w5.drop (0 * 500)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w5_nodup : w5.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w5_grid : inGrid 5 w5 = true ∧ w5.length = 2 * 5 := by decide +kernel

theorem w5_ok : noThree w5 = true ∧ inGrid 5 w5 = true ∧ w5.Nodup ∧ w5.length = 2 * 5 :=
  ⟨noThree_of_chunks 500 1 w5 (Nat.le_trans (Nat.le_of_eq w5_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w5_c0
      | _ + 1, h => absurd h (by omega)),
    w5_grid.1, w5_nodup, w5_grid.2⟩

end Green72Data
