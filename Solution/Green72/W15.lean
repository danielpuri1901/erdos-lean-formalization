import Solution.Green72.Split

set_option Elab.async false

namespace Green72Data

set_option maxRecDepth 100000 in
theorem w15_c0 : prefixOk 55 (w15.drop (0 * 55)) = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem w15_nodup : w15.Nodup := by decide +kernel

set_option maxRecDepth 100000 in
theorem w15_grid : inGrid 15 w15 = true ∧ w15.length = 2 * 15 := by decide +kernel

theorem w15_ok : noThree w15 = true ∧ inGrid 15 w15 = true ∧ w15.Nodup ∧ w15.length = 2 * 15 :=
  ⟨noThree_of_chunks 55 1 w15 (Nat.le_trans (Nat.le_of_eq w15_grid.2) (by decide))
    (fun j hj => match j, hj with
      | 0, _ => w15_c0
      | _ + 1, h => absurd h (by omega)),
    w15_grid.1, w15_nodup, w15_grid.2⟩

end Green72Data
