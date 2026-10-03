import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w6_c0 : prefixOk 347 (w6.drop (0 * 347)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w6_nodup : w6.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w6_grid : inGrid 6 w6 = true ∧ w6.length = 2 * 6 := by decide +kernel

theorem w6_ok : noThree w6 = true ∧ inGrid 6 w6 = true ∧ w6.Nodup ∧ w6.length = 2 * 6 :=
  ⟨noThree_of_chunks 347 1 w6 (Nat.le_trans (Nat.le_of_eq w6_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w6_c0
      | _ + 1, h => absurd h (by omega)),
    w6_grid.1, w6_nodup, w6_grid.2⟩

end Green72Data
