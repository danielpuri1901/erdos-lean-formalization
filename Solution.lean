import FormalConjectures.Wikipedia.RamseyNumbers
import Solution.Lower
import Solution.Upper

/-! Solution for the ramsey34 target. See `TASK.md` and `NOTES.md`. -/

theorem ramsey_3_4 : type_of% @RamseyNumbers.ramsey_number_three_four := by
  rw [RamseyNumbers.classicalRamsey_eq_sInf]
  apply le_antisymm
  · exact Nat.sInf_le R34.isGraphRamsey_9
  · apply le_csInf ⟨9, R34.isGraphRamsey_9⟩
    intro n hn
    by_contra hlt
    have lift : ∀ j, RamseyNumbers.IsGraphRamsey (n + j) 3 4 := by
      intro j
      induction j with
      | zero => exact hn
      | succ j ih => exact RamseyNumbers.IsGraphRamsey.succ _ _ _ ih
    have h8 := lift (8 - n)
    rw [show n + (8 - n) = 8 by omega] at h8
    exact R34.not_isGraphRamsey_8 h8
