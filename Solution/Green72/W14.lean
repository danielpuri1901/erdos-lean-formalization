import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w14_c0 : prefixOk 63 (w14.drop (0 * 63)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w14_nodup : w14.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w14_grid : inGrid 14 w14 = true ∧ w14.length = 2 * 14 := by decide +kernel

theorem w14_ok : noThree w14 = true ∧ inGrid 14 w14 = true ∧ w14.Nodup ∧ w14.length = 2 * 14 :=
  ⟨noThree_of_chunks 63 1 w14 (Nat.le_trans (Nat.le_of_eq w14_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w14_c0
      | _ + 1, h => absurd h (by omega)),
    w14_grid.1, w14_nodup, w14_grid.2⟩

end Green72Data
