import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w41_c0 : prefixOk 7 (w41.drop (0 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c1 : prefixOk 7 (w41.drop (1 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c2 : prefixOk 7 (w41.drop (2 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c3 : prefixOk 7 (w41.drop (3 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c4 : prefixOk 7 (w41.drop (4 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c5 : prefixOk 7 (w41.drop (5 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c6 : prefixOk 7 (w41.drop (6 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c7 : prefixOk 7 (w41.drop (7 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c8 : prefixOk 7 (w41.drop (8 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c9 : prefixOk 7 (w41.drop (9 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c10 : prefixOk 7 (w41.drop (10 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_c11 : prefixOk 7 (w41.drop (11 * 7)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_nodup : w41.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w41_grid : inGrid 41 w41 = true ∧ w41.length = 2 * 41 := by decide +kernel

theorem w41_ok : noThree w41 = true ∧ inGrid 41 w41 = true ∧ w41.Nodup ∧ w41.length = 2 * 41 :=
  ⟨noThree_of_chunks 7 12 w41 (Nat.le_trans (Nat.le_of_eq w41_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w41_c0
      | 1, _ => w41_c1
      | 2, _ => w41_c2
      | 3, _ => w41_c3
      | 4, _ => w41_c4
      | 5, _ => w41_c5
      | 6, _ => w41_c6
      | 7, _ => w41_c7
      | 8, _ => w41_c8
      | 9, _ => w41_c9
      | 10, _ => w41_c10
      | 11, _ => w41_c11
      | _ + 12, h => absurd h (by omega)),
    w41_grid.1, w41_nodup, w41_grid.2⟩

end Green72Data
