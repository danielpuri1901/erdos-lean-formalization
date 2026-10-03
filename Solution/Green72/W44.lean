import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w44_c0 : prefixOk 6 (w44.drop (0 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c1 : prefixOk 6 (w44.drop (1 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c2 : prefixOk 6 (w44.drop (2 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c3 : prefixOk 6 (w44.drop (3 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c4 : prefixOk 6 (w44.drop (4 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c5 : prefixOk 6 (w44.drop (5 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c6 : prefixOk 6 (w44.drop (6 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c7 : prefixOk 6 (w44.drop (7 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c8 : prefixOk 6 (w44.drop (8 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c9 : prefixOk 6 (w44.drop (9 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c10 : prefixOk 6 (w44.drop (10 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c11 : prefixOk 6 (w44.drop (11 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c12 : prefixOk 6 (w44.drop (12 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c13 : prefixOk 6 (w44.drop (13 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_c14 : prefixOk 6 (w44.drop (14 * 6)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_nodup : w44.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w44_grid : inGrid 44 w44 = true ∧ w44.length = 2 * 44 := by decide +kernel

theorem w44_ok : noThree w44 = true ∧ inGrid 44 w44 = true ∧ w44.Nodup ∧ w44.length = 2 * 44 :=
  ⟨noThree_of_chunks 6 15 w44 (Nat.le_trans (Nat.le_of_eq w44_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w44_c0
      | 1, _ => w44_c1
      | 2, _ => w44_c2
      | 3, _ => w44_c3
      | 4, _ => w44_c4
      | 5, _ => w44_c5
      | 6, _ => w44_c6
      | 7, _ => w44_c7
      | 8, _ => w44_c8
      | 9, _ => w44_c9
      | 10, _ => w44_c10
      | 11, _ => w44_c11
      | 12, _ => w44_c12
      | 13, _ => w44_c13
      | 14, _ => w44_c14
      | _ + 15, h => absurd h (by omega)),
    w44_grid.1, w44_nodup, w44_grid.2⟩

end Green72Data
