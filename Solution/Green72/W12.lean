import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w12_c0 : prefixOk 86 (w12.drop (0 * 86)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w12_nodup : w12.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w12_grid : inGrid 12 w12 = true ∧ w12.length = 2 * 12 := by decide +kernel

theorem w12_ok : noThree w12 = true ∧ inGrid 12 w12 = true ∧ w12.Nodup ∧ w12.length = 2 * 12 :=
  ⟨noThree_of_chunks 86 1 w12 (Nat.le_trans (Nat.le_of_eq w12_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w12_c0
      | _ + 1, h => absurd h (by omega)),
    w12_grid.1, w12_nodup, w12_grid.2⟩

end Green72Data
