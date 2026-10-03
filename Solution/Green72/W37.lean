import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w37_c0 : prefixOk 9 (w37.drop (0 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c1 : prefixOk 9 (w37.drop (1 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c2 : prefixOk 9 (w37.drop (2 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c3 : prefixOk 9 (w37.drop (3 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c4 : prefixOk 9 (w37.drop (4 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c5 : prefixOk 9 (w37.drop (5 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c6 : prefixOk 9 (w37.drop (6 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c7 : prefixOk 9 (w37.drop (7 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_c8 : prefixOk 9 (w37.drop (8 * 9)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_nodup : w37.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w37_grid : inGrid 37 w37 = true ∧ w37.length = 2 * 37 := by decide +kernel

theorem w37_ok : noThree w37 = true ∧ inGrid 37 w37 = true ∧ w37.Nodup ∧ w37.length = 2 * 37 :=
  ⟨noThree_of_chunks 9 9 w37 (Nat.le_trans (Nat.le_of_eq w37_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w37_c0
      | 1, _ => w37_c1
      | 2, _ => w37_c2
      | 3, _ => w37_c3
      | 4, _ => w37_c4
      | 5, _ => w37_c5
      | 6, _ => w37_c6
      | 7, _ => w37_c7
      | 8, _ => w37_c8
      | _ + 9, h => absurd h (by omega)),
    w37_grid.1, w37_nodup, w37_grid.2⟩

end Green72Data
