import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w30_c0 : prefixOk 13 (w30.drop (0 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c1 : prefixOk 13 (w30.drop (1 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c2 : prefixOk 13 (w30.drop (2 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c3 : prefixOk 13 (w30.drop (3 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w30_c4 : prefixOk 13 (w30.drop (4 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w30_nodup : w30.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w30_grid : inGrid 30 w30 = true ∧ w30.length = 2 * 30 := by decide +kernel

theorem w30_ok : noThree w30 = true ∧ inGrid 30 w30 = true ∧ w30.Nodup ∧ w30.length = 2 * 30 :=
  ⟨noThree_of_chunks 13 5 w30 (Nat.le_trans (Nat.le_of_eq w30_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w30_c0
      | 1, _ => w30_c1
      | 2, _ => w30_c2
      | 3, _ => w30_c3
      | 4, _ => w30_c4
      | _ + 5, h => absurd h (by omega)),
    w30_grid.1, w30_nodup, w30_grid.2⟩

end Green72Data
