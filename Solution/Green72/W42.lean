import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w42_c0 : prefixOk 7 (w42.drop (0 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c1 : prefixOk 7 (w42.drop (1 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c2 : prefixOk 7 (w42.drop (2 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c3 : prefixOk 7 (w42.drop (3 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c4 : prefixOk 7 (w42.drop (4 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c5 : prefixOk 7 (w42.drop (5 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c6 : prefixOk 7 (w42.drop (6 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c7 : prefixOk 7 (w42.drop (7 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c8 : prefixOk 7 (w42.drop (8 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c9 : prefixOk 7 (w42.drop (9 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c10 : prefixOk 7 (w42.drop (10 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_c11 : prefixOk 7 (w42.drop (11 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_nodup : w42.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w42_grid : inGrid 42 w42 = true ∧ w42.length = 2 * 42 := by decide +kernel

theorem w42_ok : noThree w42 = true ∧ inGrid 42 w42 = true ∧ w42.Nodup ∧ w42.length = 2 * 42 :=
  ⟨noThree_of_chunks 7 12 w42 (Nat.le_trans (Nat.le_of_eq w42_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w42_c0
      | 1, _ => w42_c1
      | 2, _ => w42_c2
      | 3, _ => w42_c3
      | 4, _ => w42_c4
      | 5, _ => w42_c5
      | 6, _ => w42_c6
      | 7, _ => w42_c7
      | 8, _ => w42_c8
      | 9, _ => w42_c9
      | 10, _ => w42_c10
      | 11, _ => w42_c11
      | _ + 12, h => absurd h (by omega)),
    w42_grid.1, w42_nodup, w42_grid.2⟩

end Green72Data
