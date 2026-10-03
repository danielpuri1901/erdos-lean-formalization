import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w16_c0 : prefixOk 48 (w16.drop (0 * 48)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w16_nodup : w16.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w16_grid : inGrid 16 w16 = true ∧ w16.length = 2 * 16 := by decide +kernel

theorem w16_ok : noThree w16 = true ∧ inGrid 16 w16 = true ∧ w16.Nodup ∧ w16.length = 2 * 16 :=
  ⟨noThree_of_chunks 48 1 w16 (Nat.le_trans (Nat.le_of_eq w16_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w16_c0
      | _ + 1, h => absurd h (by omega)),
    w16_grid.1, w16_nodup, w16_grid.2⟩

end Green72Data
