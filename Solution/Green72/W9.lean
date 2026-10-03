import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w9_c0 : prefixOk 154 (w9.drop (0 * 154)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w9_nodup : w9.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w9_grid : inGrid 9 w9 = true ∧ w9.length = 2 * 9 := by decide +kernel

theorem w9_ok : noThree w9 = true ∧ inGrid 9 w9 = true ∧ w9.Nodup ∧ w9.length = 2 * 9 :=
  ⟨noThree_of_chunks 154 1 w9 (Nat.le_trans (Nat.le_of_eq w9_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w9_c0
      | _ + 1, h => absurd h (by omega)),
    w9_grid.1, w9_nodup, w9_grid.2⟩

end Green72Data
