import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w11_c0 : prefixOk 103 (w11.drop (0 * 103)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w11_nodup : w11.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w11_grid : inGrid 11 w11 = true ∧ w11.length = 2 * 11 := by decide +kernel

theorem w11_ok : noThree w11 = true ∧ inGrid 11 w11 = true ∧ w11.Nodup ∧ w11.length = 2 * 11 :=
  ⟨noThree_of_chunks 103 1 w11 (Nat.le_trans (Nat.le_of_eq w11_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w11_c0
      | _ + 1, h => absurd h (by omega)),
    w11_grid.1, w11_nodup, w11_grid.2⟩

end Green72Data
