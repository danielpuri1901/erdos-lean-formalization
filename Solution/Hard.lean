import Solution.Pairs

/-!
# The hard case of the pairs conjecture from the computed statements T2 and T4

The reply rule r6: facing `((pairUnion A).erase a, a - 1)`, take `2` then `a + 1` when `2 ∈ A`
and `4 ≤ a` (leaving a T4 position), and otherwise take `a + 1` (leaving a T2 position).
-/

namespace CatchUpDeep

open CatchUp

/-- Computed statement T2 (checked inside `{1..20}` only). -/
def T2 : Prop :=
  ∀ B : Finset ℕ, PairStarts B → Even B.card → 2 ∉ B → gv (pairUnion B) 2 ≠ .win

/-- Computed statement T4 (checked inside `{1..20}` only). -/
def T4 : Prop :=
  ∀ B : Finset ℕ, PairStarts B → Odd B.card → (∀ b ∈ B, 4 ≤ b) →
    gv (insert 3 (pairUnion B)) 4 ≠ .win

/-- The set left after the r6 replies `2`, `a + 1`. -/
theorem r6_set_eq {A : Finset ℕ} (hA : PairStarts A) {a : ℕ} (ha : a ∈ A) (h2 : 2 ∈ A)
    (h4 : 4 ≤ a) :
    (((pairUnion A).erase a).erase 2).erase (a + 1) =
      insert 3 (pairUnion ((A.erase a).erase 2)) := by
  rw [Finset.erase_right_comm, pairUnion_erase_erase hA ha]
  have h1 : 1 ∉ A := fun h => hA.2 1 h h2
  ext x
  simp only [Finset.mem_erase, Finset.mem_insert, mem_pairUnion]
  constructor
  · rintro ⟨hx2, (⟨hxa, hxA⟩ | ⟨b, ⟨hba, hbA⟩, rfl⟩)⟩
    · exact Or.inr (Or.inl ⟨hx2, hxa, hxA⟩)
    · by_cases hb2 : b = 2
      · left; omega
      · exact Or.inr (Or.inr ⟨b, ⟨hb2, hba, hbA⟩, rfl⟩)
  · rintro (rfl | ⟨hx2, hxa, hxA⟩ | ⟨b, ⟨hb2, hba, hbA⟩, rfl⟩)
    · exact ⟨by omega, Or.inr ⟨2, ⟨by omega, h2⟩, rfl⟩⟩
    · exact ⟨hx2, Or.inl ⟨hxa, hxA⟩⟩
    · refine ⟨?_, Or.inr ⟨b, ⟨hba, hbA⟩, rfl⟩⟩
      intro h
      have hb1 : b = 1 := by omega
      rw [hb1] at hbA
      exact h1 hbA

theorem hard_of_T2_T4 (hT2 : T2) (hT4 : T4) :
    ∀ A : Finset ℕ, PairStarts A → Odd A.card →
      ∀ a ∈ A, gv ((pairUnion A).erase a) (a - 1) ≠ .loss := by
  intro A hA hodd a ha
  have ha0 : a ≠ 0 := fun h => hA.1 (by rw [h] at ha; exact ha)
  have hcard : (A.erase a).card + 1 = A.card := by
    have := Finset.card_pos.mpr ⟨a, ha⟩
    rw [Finset.card_erase_of_mem ha]; omega
  have hmem1 : a + 1 ∈ (pairUnion A).erase a :=
    Finset.mem_erase.mpr ⟨by omega, mem_pairUnion.mpr (Or.inr ⟨a, ha, rfl⟩)⟩
  have hR1 : (pairUnion A).erase a ≠ ∅ := Finset.ne_empty_of_mem hmem1
  have hsum1 : ¬ ((pairUnion A).erase a).sum (fun x => x) < a - 1 := by
    have : a + 1 ≤ ((pairUnion A).erase a).sum (fun x => x) :=
      Finset.single_le_sum (f := fun x => x) (fun _ _ => Nat.zero_le _) hmem1
    omega
  by_cases h2 : 2 ∈ A ∧ 4 ≤ a
  · -- r6: take `2`, then `a + 1`
    obtain ⟨h2A, h4⟩ := h2
    have h1A : 1 ∉ A := fun h => hA.2 1 h h2A
    have h3A : 3 ∉ A := hA.2 2 h2A
    have hmem2 : 2 ∈ (pairUnion A).erase a :=
      Finset.mem_erase.mpr ⟨by omega, mem_pairUnion.mpr (Or.inl h2A)⟩
    refine gv_ne_loss_of_move hR1 hsum1 hmem2 ?_
    have e1 : a - 1 - 2 = a - 3 := by omega
    rw [if_neg (show ¬ (a - 1 ≤ 2) by omega), e1]
    have hmem3 : a + 1 ∈ ((pairUnion A).erase a).erase 2 :=
      Finset.mem_erase.mpr ⟨by omega, hmem1⟩
    have hR2 : ((pairUnion A).erase a).erase 2 ≠ ∅ := Finset.ne_empty_of_mem hmem3
    have hsum2 : ¬ (((pairUnion A).erase a).erase 2).sum (fun x => x) < a - 3 := by
      have : a + 1 ≤ (((pairUnion A).erase a).erase 2).sum (fun x => x) :=
        Finset.single_le_sum (f := fun x => x) (fun _ _ => Nat.zero_le _) hmem3
      omega
    refine gv_ne_loss_of_move hR2 hsum2 hmem3 ?_
    have e2 : a + 1 - (a - 3) = 4 := by omega
    rw [if_pos (show a - 3 ≤ a + 1 by omega), e2, neg_ne_loss_iff, r6_set_eq hA ha h2A h4]
    have h2e : 2 ∈ A.erase a := Finset.mem_erase.mpr ⟨by omega, h2A⟩
    apply hT4
    · exact pairStarts_erase (pairStarts_erase hA a) 2
    · have hc2 : ((A.erase a).erase 2).card + 1 = (A.erase a).card := by
        have := Finset.card_pos.mpr ⟨2, h2e⟩
        rw [Finset.card_erase_of_mem h2e]; omega
      rw [Nat.odd_iff] at hodd ⊢
      omega
    · intro b hb
      have hb2 : b ≠ 2 := Finset.ne_of_mem_erase hb
      have hbA : b ∈ A := Finset.mem_of_mem_erase (Finset.mem_of_mem_erase hb)
      have hb0 : b ≠ 0 := fun h => hA.1 (by rw [h] at hbA; exact hbA)
      have hb1 : b ≠ 1 := fun h => h1A (by rw [h] at hbA; exact hbA)
      have hb3 : b ≠ 3 := fun h => h3A (by rw [h] at hbA; exact hbA)
      omega
  · -- otherwise: take `a + 1`
    refine gv_ne_loss_of_move hR1 hsum1 hmem1 ?_
    have e3 : a + 1 - (a - 1) = 2 := by omega
    rw [if_pos (show a - 1 ≤ a + 1 by omega), pairUnion_erase_erase hA ha, e3, neg_ne_loss_iff]
    apply hT2 (A.erase a) (pairStarts_erase hA a)
    · rw [Nat.odd_iff] at hodd
      rw [Nat.even_iff]
      omega
    · intro h2e
      have h2A : 2 ∈ A := Finset.mem_of_mem_erase h2e
      have h2a : 2 ≠ a := Finset.ne_of_mem_erase h2e
      have hlt : a < 4 := by
        by_contra h
        exact h2 ⟨h2A, by omega⟩
      have ha1 : a ≠ 1 := fun h => hA.2 1 (by rw [h] at ha; exact ha) h2A
      have ha3 : a ≠ 3 := fun h => hA.2 2 h2A (by rw [h] at ha; exact ha)
      omega

/-- Formal reduction: the "at most a draw" halves of the pairs conjecture follow from its
"at least a draw" half at odd `k` and gap 1, together with T2 and T4. -/
theorem pairsConj_le_halves_of_T2_T4
    (hGE1 : ∀ A : Finset ℕ, PairStarts A → Odd A.card → gv (pairUnion A) 1 ≠ .loss)
    (hT2 : T2) (hT4 : T4) :
    ∀ A : Finset ℕ, PairStarts A →
      (Even A.card → gv (pairUnion A) 0 ≠ .win) ∧ (Odd A.card → gv (pairUnion A) 1 ≠ .win) :=
  pairsConj_le_halves hGE1 (hard_of_T2_T4 hT2 hT4)

end CatchUpDeep

#print axioms CatchUpDeep.hard_of_T2_T4
#print axioms CatchUpDeep.pairsConj_le_halves_of_T2_T4
