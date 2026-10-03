import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w10_c0 : prefixOk 125 (w10.drop (0 * 125)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w10_nodup : w10.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w10_grid : inGrid 10 w10 = true ∧ w10.length = 2 * 10 := by decide +kernel

theorem w10_ok : noThree w10 = true ∧ inGrid 10 w10 = true ∧ w10.Nodup ∧ w10.length = 2 * 10 :=
  ⟨noThree_of_chunks 125 1 w10 (Nat.le_trans (Nat.le_of_eq w10_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w10_c0
      | _ + 1, h => absurd h (by omega)),
    w10_grid.1, w10_nodup, w10_grid.2⟩

end Green72Data
