import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w25_c0 : prefixOk 20 (w25.drop (0 * 20)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c1 : prefixOk 20 (w25.drop (1 * 20)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w25_c2 : prefixOk 20 (w25.drop (2 * 20)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w25_nodup : w25.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w25_grid : inGrid 25 w25 = true ∧ w25.length = 2 * 25 := by decide +kernel

theorem w25_ok : noThree w25 = true ∧ inGrid 25 w25 = true ∧ w25.Nodup ∧ w25.length = 2 * 25 :=
  ⟨noThree_of_chunks 20 3 w25 (Nat.le_trans (Nat.le_of_eq w25_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w25_c0
      | 1, _ => w25_c1
      | 2, _ => w25_c2
      | _ + 3, h => absurd h (by omega)),
    w25_grid.1, w25_nodup, w25_grid.2⟩

end Green72Data
