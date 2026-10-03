import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w3_c0 : prefixOk 1388 (w3.drop (0 * 1388)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w3_nodup : w3.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w3_grid : inGrid 3 w3 = true ∧ w3.length = 2 * 3 := by decide +kernel

theorem w3_ok : noThree w3 = true ∧ inGrid 3 w3 = true ∧ w3.Nodup ∧ w3.length = 2 * 3 :=
  ⟨noThree_of_chunks 1388 1 w3 (Nat.le_trans (Nat.le_of_eq w3_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w3_c0
      | _ + 1, h => absurd h (by omega)),
    w3_grid.1, w3_nodup, w3_grid.2⟩

end Green72Data
