import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w24_c0 : prefixOk 21 (w24.drop (0 * 21)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w24_c1 : prefixOk 21 (w24.drop (1 * 21)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w24_c2 : prefixOk 21 (w24.drop (2 * 21)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w24_nodup : w24.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w24_grid : inGrid 24 w24 = true ∧ w24.length = 2 * 24 := by decide +kernel

theorem w24_ok : noThree w24 = true ∧ inGrid 24 w24 = true ∧ w24.Nodup ∧ w24.length = 2 * 24 :=
  ⟨noThree_of_chunks 21 3 w24 (Nat.le_trans (Nat.le_of_eq w24_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w24_c0
      | 1, _ => w24_c1
      | 2, _ => w24_c2
      | _ + 3, h => absurd h (by omega)),
    w24_grid.1, w24_nodup, w24_grid.2⟩

end Green72Data
