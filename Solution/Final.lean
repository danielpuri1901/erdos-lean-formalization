import Solution.Hard
import Solution.CertSmall
import Solution.Cert11
import Solution.Cert12
import Solution.Cert15
import Solution.Cert16

/-!
# Final assembly for the Catch-Up conjecture

* `pairsConj_of_GE_T2_T4`: the pairs conjecture follows from the computed statements
  `GE`, `T2`, `T4`.
* `catchup_of_GE_T2_T4_P3`: the Catch-Up conjecture follows from `GE`, `T2`, `T4`, `PairsConj3`.
* `catchup_draw_le_16`: the Catch-Up conjecture for every `N ≤ 16` (unconditional).
-/

namespace CatchUpDeep

open CatchUp

/-- The "at least a draw" halves of the pairs conjecture (computed inside {1..24}, open). -/
def GE : Prop :=
  ∀ A : Finset ℕ, PairStarts A →
    (Even A.card → gv (pairUnion A) 0 ≠ .loss) ∧ (Odd A.card → gv (pairUnion A) 1 ≠ .loss)

/-- The pairs conjecture follows from GE, T2 and T4. -/
theorem pairsConj_of_GE_T2_T4 (hGE : GE) (hT2 : T2) (hT4 : T4) : PairsConj := by
  intro A hA
  have hle := pairsConj_le_halves_of_T2_T4 (fun A hA hodd => (hGE A hA).2 hodd) hT2 hT4 A hA
  exact ⟨fun he => eq_draw_of_ne (hle.1 he) ((hGE A hA).1 he),
         fun ho => eq_draw_of_ne (hle.2 ho) ((hGE A hA).2 ho)⟩

/-- The Catch-Up conjecture follows from the four computed statements GE, T2, T4 and PairsConj3. -/
theorem catchup_of_GE_T2_T4_P3 (hGE : GE) (hT2 : T2) (hT4 : T4) (hP3 : PairsConj3)
    (N : ℕ) (h_even : Even (N * (N + 1) / 2)) : value (Finset.Icc 1 N) = .draw :=
  catchup_of_pairsConj (pairsConj_of_GE_T2_T4 hGE hT2 hT4) hP3 N h_even

/-- The Catch-Up conjecture for every `N ≤ 16`. -/
theorem catchup_draw_le_16 (N : ℕ) (hN : N ≤ 16) (h_even : Even (N * (N + 1) / 2)) :
    value (Finset.Icc 1 N) = .draw := by
  interval_cases N
  all_goals first
    | exact catchup_draw_0 | exact catchup_draw_3 | exact catchup_draw_4 | exact catchup_draw_7
    | exact catchup_draw_8 | exact catchup_draw_11 | exact catchup_draw_12 | exact catchup_draw_15
    | exact catchup_draw_16
    | (exfalso; revert h_even; decide)

end CatchUpDeep
