import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w20_c0 : prefixOk 31 (w20.drop (0 * 31)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w20_c1 : prefixOk 31 (w20.drop (1 * 31)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w20_nodup : w20.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w20_grid : inGrid 20 w20 = true ∧ w20.length = 2 * 20 := by decide +kernel

theorem w20_ok : noThree w20 = true ∧ inGrid 20 w20 = true ∧ w20.Nodup ∧ w20.length = 2 * 20 :=
  ⟨noThree_of_chunks 31 2 w20 (Nat.le_trans (Nat.le_of_eq w20_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w20_c0
      | 1, _ => w20_c1
      | _ + 2, h => absurd h (by omega)),
    w20_grid.1, w20_nodup, w20_grid.2⟩

end Green72Data
