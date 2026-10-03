import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w29_c0 : prefixOk 14 (w29.drop (0 * 14)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c1 : prefixOk 14 (w29.drop (1 * 14)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c2 : prefixOk 14 (w29.drop (2 * 14)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c3 : prefixOk 14 (w29.drop (3 * 14)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w29_c4 : prefixOk 14 (w29.drop (4 * 14)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w29_nodup : w29.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w29_grid : inGrid 29 w29 = true ∧ w29.length = 2 * 29 := by decide +kernel

theorem w29_ok : noThree w29 = true ∧ inGrid 29 w29 = true ∧ w29.Nodup ∧ w29.length = 2 * 29 :=
  ⟨noThree_of_chunks 14 5 w29 (Nat.le_trans (Nat.le_of_eq w29_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w29_c0
      | 1, _ => w29_c1
      | 2, _ => w29_c2
      | 3, _ => w29_c3
      | 4, _ => w29_c4
      | _ + 5, h => absurd h (by omega)),
    w29_grid.1, w29_nodup, w29_grid.2⟩

end Green72Data
