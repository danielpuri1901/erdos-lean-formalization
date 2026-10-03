import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w4_c0 : prefixOk 781 (w4.drop (0 * 781)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w4_nodup : w4.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w4_grid : inGrid 4 w4 = true ∧ w4.length = 2 * 4 := by decide +kernel

theorem w4_ok : noThree w4 = true ∧ inGrid 4 w4 = true ∧ w4.Nodup ∧ w4.length = 2 * 4 :=
  ⟨noThree_of_chunks 781 1 w4 (Nat.le_trans (Nat.le_of_eq w4_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w4_c0
      | _ + 1, h => absurd h (by omega)),
    w4_grid.1, w4_nodup, w4_grid.2⟩

end Green72Data
