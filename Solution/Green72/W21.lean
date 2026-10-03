import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w21_c0 : prefixOk 28 (w21.drop (0 * 28)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w21_c1 : prefixOk 28 (w21.drop (1 * 28)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w21_nodup : w21.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w21_grid : inGrid 21 w21 = true ∧ w21.length = 2 * 21 := by decide +kernel

theorem w21_ok : noThree w21 = true ∧ inGrid 21 w21 = true ∧ w21.Nodup ∧ w21.length = 2 * 21 :=
  ⟨noThree_of_chunks 28 2 w21 (Nat.le_trans (Nat.le_of_eq w21_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w21_c0
      | 1, _ => w21_c1
      | _ + 2, h => absurd h (by omega)),
    w21_grid.1, w21_nodup, w21_grid.2⟩

end Green72Data
