import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w32_c0 : prefixOk 12 (w32.drop (0 * 12)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c1 : prefixOk 12 (w32.drop (1 * 12)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c2 : prefixOk 12 (w32.drop (2 * 12)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c3 : prefixOk 12 (w32.drop (3 * 12)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c4 : prefixOk 12 (w32.drop (4 * 12)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w32_c5 : prefixOk 12 (w32.drop (5 * 12)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w32_nodup : w32.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w32_grid : inGrid 32 w32 = true ∧ w32.length = 2 * 32 := by decide +kernel

theorem w32_ok : noThree w32 = true ∧ inGrid 32 w32 = true ∧ w32.Nodup ∧ w32.length = 2 * 32 :=
  ⟨noThree_of_chunks 12 6 w32 (Nat.le_trans (Nat.le_of_eq w32_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w32_c0
      | 1, _ => w32_c1
      | 2, _ => w32_c2
      | 3, _ => w32_c3
      | 4, _ => w32_c4
      | 5, _ => w32_c5
      | _ + 6, h => absurd h (by omega)),
    w32_grid.1, w32_nodup, w32_grid.2⟩

end Green72Data
