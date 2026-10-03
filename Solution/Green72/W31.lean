import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w31_c0 : prefixOk 13 (w31.drop (0 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c1 : prefixOk 13 (w31.drop (1 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c2 : prefixOk 13 (w31.drop (2 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c3 : prefixOk 13 (w31.drop (3 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w31_c4 : prefixOk 13 (w31.drop (4 * 13)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w31_nodup : w31.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w31_grid : inGrid 31 w31 = true ∧ w31.length = 2 * 31 := by decide +kernel

theorem w31_ok : noThree w31 = true ∧ inGrid 31 w31 = true ∧ w31.Nodup ∧ w31.length = 2 * 31 :=
  ⟨noThree_of_chunks 13 5 w31 (Nat.le_trans (Nat.le_of_eq w31_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w31_c0
      | 1, _ => w31_c1
      | 2, _ => w31_c2
      | 3, _ => w31_c3
      | 4, _ => w31_c4
      | _ + 5, h => absurd h (by omega)),
    w31_grid.1, w31_nodup, w31_grid.2⟩

end Green72Data
