import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w33_c0 : prefixOk 11 (w33.drop (0 * 11)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c1 : prefixOk 11 (w33.drop (1 * 11)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c2 : prefixOk 11 (w33.drop (2 * 11)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c3 : prefixOk 11 (w33.drop (3 * 11)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c4 : prefixOk 11 (w33.drop (4 * 11)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w33_c5 : prefixOk 11 (w33.drop (5 * 11)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w33_nodup : w33.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w33_grid : inGrid 33 w33 = true ∧ w33.length = 2 * 33 := by decide +kernel

theorem w33_ok : noThree w33 = true ∧ inGrid 33 w33 = true ∧ w33.Nodup ∧ w33.length = 2 * 33 :=
  ⟨noThree_of_chunks 11 6 w33 (Nat.le_trans (Nat.le_of_eq w33_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w33_c0
      | 1, _ => w33_c1
      | 2, _ => w33_c2
      | 3, _ => w33_c3
      | 4, _ => w33_c4
      | 5, _ => w33_c5
      | _ + 6, h => absurd h (by omega)),
    w33_grid.1, w33_nodup, w33_grid.2⟩

end Green72Data
