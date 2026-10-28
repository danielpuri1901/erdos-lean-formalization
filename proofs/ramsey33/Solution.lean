import FormalConjectures.Wikipedia.RamseyNumbers
import Solution.Lower
import Solution.Upper

/-! Solution for the ramsey33 target. See `TASK.md` and `NOTES.md`. -/

theorem ramsey_3_3 : type_of% @RamseyNumbers.ramsey_number_three_three := by
  rw [RamseyNumbers.classicalRamsey_eq_sInf]
  apply le_antisymm
  · exact Nat.sInf_le R33.isGraphRamsey_6
  · apply le_csInf ⟨6, R33.isGraphRamsey_6⟩
    intro n hn
    by_contra hlt
    have lift : ∀ j, RamseyNumbers.IsGraphRamsey (n + j) 3 3 := by
      intro j
      induction j with
      | zero => exact hn
      | succ j ih => exact RamseyNumbers.IsGraphRamsey.succ _ _ _ ih
    have h5 := lift (5 - n)
    rw [show n + (5 - n) = 5 by omega] at h5
    exact R33.not_isGraphRamsey_5 h5
