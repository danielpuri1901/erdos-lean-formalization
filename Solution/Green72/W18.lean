import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w18_c0 : prefixOk 38 (w18.drop (0 * 38)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w18_nodup : w18.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w18_grid : inGrid 18 w18 = true ∧ w18.length = 2 * 18 := by decide +kernel

theorem w18_ok : noThree w18 = true ∧ inGrid 18 w18 = true ∧ w18.Nodup ∧ w18.length = 2 * 18 :=
  ⟨noThree_of_chunks 38 1 w18 (Nat.le_trans (Nat.le_of_eq w18_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w18_c0
      | _ + 1, h => absurd h (by omega)),
    w18_grid.1, w18_nodup, w18_grid.2⟩

end Green72Data
