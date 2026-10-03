import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w47_c0 : prefixOk 5 (w47.drop (0 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c1 : prefixOk 5 (w47.drop (1 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c2 : prefixOk 5 (w47.drop (2 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c3 : prefixOk 5 (w47.drop (3 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c4 : prefixOk 5 (w47.drop (4 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c5 : prefixOk 5 (w47.drop (5 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c6 : prefixOk 5 (w47.drop (6 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c7 : prefixOk 5 (w47.drop (7 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c8 : prefixOk 5 (w47.drop (8 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c9 : prefixOk 5 (w47.drop (9 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c10 : prefixOk 5 (w47.drop (10 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c11 : prefixOk 5 (w47.drop (11 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c12 : prefixOk 5 (w47.drop (12 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c13 : prefixOk 5 (w47.drop (13 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c14 : prefixOk 5 (w47.drop (14 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c15 : prefixOk 5 (w47.drop (15 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c16 : prefixOk 5 (w47.drop (16 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c17 : prefixOk 5 (w47.drop (17 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_c18 : prefixOk 5 (w47.drop (18 * 5)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_nodup : w47.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w47_grid : inGrid 47 w47 = true ∧ w47.length = 2 * 47 := by decide +kernel

theorem w47_ok : noThree w47 = true ∧ inGrid 47 w47 = true ∧ w47.Nodup ∧ w47.length = 2 * 47 :=
  ⟨noThree_of_chunks 5 19 w47 (Nat.le_trans (Nat.le_of_eq w47_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w47_c0
      | 1, _ => w47_c1
      | 2, _ => w47_c2
      | 3, _ => w47_c3
      | 4, _ => w47_c4
      | 5, _ => w47_c5
      | 6, _ => w47_c6
      | 7, _ => w47_c7
      | 8, _ => w47_c8
      | 9, _ => w47_c9
      | 10, _ => w47_c10
      | 11, _ => w47_c11
      | 12, _ => w47_c12
      | 13, _ => w47_c13
      | 14, _ => w47_c14
      | 15, _ => w47_c15
      | 16, _ => w47_c16
      | 17, _ => w47_c17
      | 18, _ => w47_c18
      | _ + 19, h => absurd h (by omega)),
    w47_grid.1, w47_nodup, w47_grid.2⟩

end Green72Data
