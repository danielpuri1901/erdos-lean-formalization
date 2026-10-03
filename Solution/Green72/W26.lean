import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w26_c0 : prefixOk 18 (w26.drop (0 * 18)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c1 : prefixOk 18 (w26.drop (1 * 18)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w26_c2 : prefixOk 18 (w26.drop (2 * 18)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w26_nodup : w26.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w26_grid : inGrid 26 w26 = true ∧ w26.length = 2 * 26 := by decide +kernel

theorem w26_ok : noThree w26 = true ∧ inGrid 26 w26 = true ∧ w26.Nodup ∧ w26.length = 2 * 26 :=
  ⟨noThree_of_chunks 18 3 w26 (Nat.le_trans (Nat.le_of_eq w26_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w26_c0
      | 1, _ => w26_c1
      | 2, _ => w26_c2
      | _ + 3, h => absurd h (by omega)),
    w26_grid.1, w26_nodup, w26_grid.2⟩

end Green72Data
