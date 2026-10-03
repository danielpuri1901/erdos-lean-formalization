import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w13_c0 : prefixOk 73 (w13.drop (0 * 73)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w13_nodup : w13.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w13_grid : inGrid 13 w13 = true ∧ w13.length = 2 * 13 := by decide +kernel

theorem w13_ok : noThree w13 = true ∧ inGrid 13 w13 = true ∧ w13.Nodup ∧ w13.length = 2 * 13 :=
  ⟨noThree_of_chunks 73 1 w13 (Nat.le_trans (Nat.le_of_eq w13_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w13_c0
      | _ + 1, h => absurd h (by omega)),
    w13_grid.1, w13_nodup, w13_grid.2⟩

end Green72Data
