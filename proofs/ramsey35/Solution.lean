import FormalConjectures.Wikipedia.RamseyNumbers
import Solution.Lower
import Solution.Upper

/-! Solution for the ramsey35 target. See `TASK.md` and `NOTES.md`. -/

theorem ramsey_3_5 : type_of% @RamseyNumbers.ramsey_number_three_five := by
  rw [RamseyNumbers.classicalRamsey_eq_sInf]
  apply le_antisymm
  · exact Nat.sInf_le R35.isGraphRamsey_14
  · apply le_csInf ⟨14, R35.isGraphRamsey_14⟩
    intro n hn
    by_contra hlt
    have lift : ∀ j, RamseyNumbers.IsGraphRamsey (n + j) 3 5 := by
      intro j
      induction j with
      | zero => exact hn
      | succ j ih => exact RamseyNumbers.IsGraphRamsey.succ _ _ _ ih
    have h13 := lift (13 - n)
    rw [show n + (13 - n) = 13 by omega] at h13
    exact R35.not_isGraphRamsey_13 h13
