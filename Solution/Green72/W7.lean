import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w7_c0 : prefixOk 255 (w7.drop (0 * 255)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w7_nodup : w7.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w7_grid : inGrid 7 w7 = true ∧ w7.length = 2 * 7 := by decide +kernel

theorem w7_ok : noThree w7 = true ∧ inGrid 7 w7 = true ∧ w7.Nodup ∧ w7.length = 2 * 7 :=
  ⟨noThree_of_chunks 255 1 w7 (Nat.le_trans (Nat.le_of_eq w7_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w7_c0
      | _ + 1, h => absurd h (by omega)),
    w7_grid.1, w7_nodup, w7_grid.2⟩

end Green72Data
