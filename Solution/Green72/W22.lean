import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w22_c0 : prefixOk 25 (w22.drop (0 * 25)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w22_c1 : prefixOk 25 (w22.drop (1 * 25)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w22_nodup : w22.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w22_grid : inGrid 22 w22 = true ∧ w22.length = 2 * 22 := by decide +kernel

theorem w22_ok : noThree w22 = true ∧ inGrid 22 w22 = true ∧ w22.Nodup ∧ w22.length = 2 * 22 :=
  ⟨noThree_of_chunks 25 2 w22 (Nat.le_trans (Nat.le_of_eq w22_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w22_c0
      | 1, _ => w22_c1
      | _ + 2, h => absurd h (by omega)),
    w22_grid.1, w22_nodup, w22_grid.2⟩

end Green72Data
