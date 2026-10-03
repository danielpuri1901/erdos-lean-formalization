import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w19_c0 : prefixOk 34 (w19.drop (0 * 34)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w19_c1 : prefixOk 34 (w19.drop (1 * 34)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w19_nodup : w19.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w19_grid : inGrid 19 w19 = true ∧ w19.length = 2 * 19 := by decide +kernel

theorem w19_ok : noThree w19 = true ∧ inGrid 19 w19 = true ∧ w19.Nodup ∧ w19.length = 2 * 19 :=
  ⟨noThree_of_chunks 34 2 w19 (Nat.le_trans (Nat.le_of_eq w19_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w19_c0
      | 1, _ => w19_c1
      | _ + 2, h => absurd h (by omega)),
    w19_grid.1, w19_nodup, w19_grid.2⟩

end Green72Data
