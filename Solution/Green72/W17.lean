import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w17_c0 : prefixOk 43 (w17.drop (0 * 43)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w17_nodup : w17.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w17_grid : inGrid 17 w17 = true ∧ w17.length = 2 * 17 := by decide +kernel

theorem w17_ok : noThree w17 = true ∧ inGrid 17 w17 = true ∧ w17.Nodup ∧ w17.length = 2 * 17 :=
  ⟨noThree_of_chunks 43 1 w17 (Nat.le_trans (Nat.le_of_eq w17_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w17_c0
      | _ + 1, h => absurd h (by omega)),
    w17_grid.1, w17_nodup, w17_grid.2⟩

end Green72Data
