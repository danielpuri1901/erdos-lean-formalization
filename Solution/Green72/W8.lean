import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w8_c0 : prefixOk 195 (w8.drop (0 * 195)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w8_nodup : w8.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w8_grid : inGrid 8 w8 = true ∧ w8.length = 2 * 8 := by decide +kernel

theorem w8_ok : noThree w8 = true ∧ inGrid 8 w8 = true ∧ w8.Nodup ∧ w8.length = 2 * 8 :=
  ⟨noThree_of_chunks 195 1 w8 (Nat.le_trans (Nat.le_of_eq w8_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w8_c0
      | _ + 1, h => absurd h (by omega)),
    w8_grid.1, w8_nodup, w8_grid.2⟩

end Green72Data
