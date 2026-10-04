import Solution.Reduction

/-!
# Partner-reply argument for the pairs conjecture

The "at most a draw" halves of the pairs conjecture follow from the "at least a draw" half at
odd `k`, gap 1, together with the hard-case claim `hHard`.
-/

namespace CatchUpDeep

open CatchUp

theorem mem_pairUnion {A : Finset ℕ} {x : ℕ} : x ∈ pairUnion A ↔ x ∈ A ∨ ∃ a ∈ A, x = a + 1 := by
  simp only [pairUnion, Finset.mem_union, Finset.mem_image]
  constructor
  · rintro (h | ⟨a, ha, rfl⟩)
    · exact Or.inl h
    · exact Or.inr ⟨a, ha, rfl⟩
  · rintro (h | ⟨a, ha, rfl⟩)
    · exact Or.inl h
    · exact Or.inr ⟨a, ha, rfl⟩

theorem pairUnion_empty : pairUnion (∅ : Finset ℕ) = ∅ := by simp [pairUnion]

theorem zero_notMem_pairUnion {A : Finset ℕ} (hA : PairStarts A) : 0 ∉ pairUnion A := by
  rw [mem_pairUnion]
  rintro (h | ⟨a, _, h⟩)
  · exact hA.1 h
  · omega

theorem pairStarts_erase {A : Finset ℕ} (hA : PairStarts A) (a : ℕ) : PairStarts (A.erase a) :=
  ⟨fun h => hA.1 (Finset.mem_of_mem_erase h),
   fun b hb h => hA.2 b (Finset.mem_of_mem_erase hb) (Finset.mem_of_mem_erase h)⟩

/-- Removing a whole pair from a pair union. -/
theorem pairUnion_erase_erase {A : Finset ℕ} (hA : PairStarts A) {a : ℕ} (ha : a ∈ A) :
    ((pairUnion A).erase a).erase (a + 1) = pairUnion (A.erase a) := by
  ext x
  simp only [Finset.mem_erase, mem_pairUnion]
  constructor
  · rintro ⟨hx1, hx2, hx | ⟨b, hb, rfl⟩⟩
    · exact Or.inl ⟨hx2, hx⟩
    · refine Or.inr ⟨b, ⟨?_, hb⟩, rfl⟩
      omega
  · rintro (⟨hx1, hx⟩ | ⟨b, ⟨hb1, hb⟩, rfl⟩)
    · refine ⟨?_, hx1, Or.inl hx⟩
      rintro rfl
      exact hA.2 a ha hx
    · refine ⟨?_, ?_, Or.inr ⟨b, hb, rfl⟩⟩
      · omega
      · intro h
        exact hA.2 b hb (by rw [h]; exact ha)

theorem neg_eq_win_iff (o : Outcome) : o.neg = .win ↔ o = .loss := by
  cases o <;> simp [Outcome.neg]

theorem neg_ne_loss_iff (o : Outcome) : o.neg ≠ .loss ↔ o ≠ .win := by
  cases o <;> simp [Outcome.neg]

theorem eq_loss_of_ne {o : Outcome} (h1 : o ≠ .win) (h2 : o ≠ .draw) : o = .loss := by
  cases o <;> simp_all

theorem eq_draw_of_ne {o : Outcome} (h1 : o ≠ .win) (h2 : o ≠ .loss) : o = .draw := by
  cases o <;> simp_all

/-- A move whose outcome is not a loss shows the position is not lost. -/
theorem gv_ne_loss_of_move {R : Finset ℕ} {g : ℕ} (hR : R ≠ ∅) (h : ¬ R.sum (fun x => x) < g)
    {x : ℕ} (hx : x ∈ R)
    (ho : (if g ≤ x then (gv (R.erase x) (x - g)).neg else gv (R.erase x) (g - x)) ≠ .loss) :
    gv R g ≠ .loss := by
  rw [gv_eq, if_neg hR, if_neg h]
  intro hl
  rw [best_eq_loss_iff] at hl
  simp only [List.mem_map, Finset.mem_toList, Finset.mem_attach, true_and, Subtype.exists,
    not_exists] at hl
  obtain ⟨h1, h2⟩ := hl
  exact ho (eq_loss_of_ne (h1 x hx) (h2 x hx))

/-- L3 (partner reply at gap 0): if every `k−1` pair position at gap 1 is a draw, the `k` pair
position at gap 0 is at most a draw for the mover. -/
theorem pairs_le_draw_of_gap_one {A : Finset ℕ} (hA : PairStarts A)
    (hLE : ∀ a ∈ A, gv (pairUnion (A.erase a)) 1 ≠ .win)
    (hGE : ∀ a ∈ A, gv (pairUnion (A.erase a)) 1 ≠ .loss) :
    gv (pairUnion A) 0 ≠ .win := by
  intro hw
  have hdraw : ∀ a ∈ A, gv (pairUnion (A.erase a)) 1 = .draw :=
    fun a ha => eq_draw_of_ne (hLE a ha) (hGE a ha)
  rcases A.eq_empty_or_nonempty with hAe | ⟨a₀, ha₀⟩
  · subst hAe
    rw [pairUnion_empty, gv_empty] at hw
    simp at hw
  have hR : pairUnion A ≠ ∅ := Finset.ne_empty_of_mem (mem_pairUnion.mpr (Or.inl ha₀))
  have h0 : ¬ (pairUnion A).sum (fun x => x) < 0 := Nat.not_lt_zero _
  rw [gv_eq_win_iff hR h0] at hw
  obtain ⟨x, hx, hxw⟩ := hw
  rw [if_pos (Nat.zero_le x), Nat.sub_zero, neg_eq_win_iff] at hxw
  rcases mem_pairUnion.mp hx with hxA | ⟨a, ha, rfl⟩
  · -- the mover took a pair start `x`; the opponent answers `x + 1`
    have hmem : x + 1 ∈ (pairUnion A).erase x :=
      Finset.mem_erase.mpr ⟨by omega, mem_pairUnion.mpr (Or.inr ⟨x, hxA, rfl⟩)⟩
    refine gv_ne_loss_of_move (g := x) (Finset.ne_empty_of_mem hmem) ?_ hmem ?_ hxw
    · have : x + 1 ≤ ((pairUnion A).erase x).sum (fun y => y) :=
        Finset.single_le_sum (f := fun y => y) (fun _ _ => Nat.zero_le _) hmem
      omega
    · rw [if_pos (show x ≤ x + 1 by omega), pairUnion_erase_erase hA hxA,
        show x + 1 - x = 1 by omega, hdraw x hxA]
      simp [Outcome.neg]
  · -- the mover took `a + 1`; the opponent answers `a`
    have hmem : a ∈ (pairUnion A).erase (a + 1) :=
      Finset.mem_erase.mpr ⟨by omega, mem_pairUnion.mpr (Or.inl ha)⟩
    refine gv_ne_loss_of_move (g := a + 1) (Finset.ne_empty_of_mem hmem) ?_ hmem ?_ hxw
    · rcases (A.erase a).eq_empty_or_nonempty with hE | ⟨b, hb⟩
      · exfalso
        have := hdraw a ha
        rw [hE, pairUnion_empty, gv_empty] at this
        simp at this
      · have hbA : b ∈ A := Finset.mem_of_mem_erase hb
        have hba : b ≠ a := Finset.ne_of_mem_erase hb
        have hb0 : b ≠ 0 := fun h => hA.1 (by rw [h] at hbA; exact hbA)
        have hb1 : b ≠ a + 1 := fun h => hA.2 a ha (by rw [h] at hbA; exact hbA)
        have hsub : ({a, b} : Finset ℕ) ⊆ (pairUnion A).erase (a + 1) := by
          intro y hy
          simp only [Finset.mem_insert, Finset.mem_singleton] at hy
          rcases hy with rfl | rfl
          · exact hmem
          · exact Finset.mem_erase.mpr ⟨hb1, mem_pairUnion.mpr (Or.inl hbA)⟩
        have hle : ({a, b} : Finset ℕ).sum (fun i => i) ≤
            ((pairUnion A).erase (a + 1)).sum (fun i => i) :=
          Finset.sum_le_sum_of_subset (f := fun i : ℕ => i) hsub
        rw [Finset.sum_pair (Ne.symm hba)] at hle
        omega
    · rw [if_neg (show ¬ (a + 1 ≤ a) by omega), Finset.erase_right_comm,
        pairUnion_erase_erase hA ha, show a + 1 - a = 1 by omega, hdraw a ha]
      simp

/-- Easy half of L4 (gap 1): the mover's pick `a+1` is answered by `a` (tie); the pick `a` is
covered by the hard-case hypothesis `hHard`. -/
theorem pairs_le_draw_of_gap_zero {A : Finset ℕ} (hA : PairStarts A)
    (hLE0 : ∀ a ∈ A, gv (pairUnion (A.erase a)) 0 ≠ .win)
    (hHard : ∀ a ∈ A, gv ((pairUnion A).erase a) (a - 1) ≠ .loss) :
    gv (pairUnion A) 1 ≠ .win := by
  intro hw
  rcases A.eq_empty_or_nonempty with hAe | ⟨a₀, ha₀⟩
  · subst hAe
    rw [pairUnion_empty, gv_empty] at hw
    simp at hw
  have ha₀R : a₀ ∈ pairUnion A := mem_pairUnion.mpr (Or.inl ha₀)
  have hR : pairUnion A ≠ ∅ := Finset.ne_empty_of_mem ha₀R
  have h1 : ¬ (pairUnion A).sum (fun x => x) < 1 := by
    have : a₀ ≤ (pairUnion A).sum (fun x => x) :=
      Finset.single_le_sum (f := fun x => x) (fun _ _ => Nat.zero_le _) ha₀R
    have : a₀ ≠ 0 := fun h => hA.1 (by rw [h] at ha₀; exact ha₀)
    omega
  rw [gv_eq_win_iff hR h1] at hw
  obtain ⟨x, hx, hxw⟩ := hw
  have hx0 : x ≠ 0 := fun h => zero_notMem_pairUnion hA (by rw [h] at hx; exact hx)
  rw [if_pos (show 1 ≤ x by omega), neg_eq_win_iff] at hxw
  rcases mem_pairUnion.mp hx with hxA | ⟨a, ha, rfl⟩
  · exact hHard x hxA hxw
  · rw [show a + 1 - 1 = a by omega] at hxw
    have hmem : a ∈ (pairUnion A).erase (a + 1) :=
      Finset.mem_erase.mpr ⟨by omega, mem_pairUnion.mpr (Or.inl ha)⟩
    refine gv_ne_loss_of_move (g := a) (Finset.ne_empty_of_mem hmem) ?_ hmem ?_ hxw
    · have : a ≤ ((pairUnion A).erase (a + 1)).sum (fun x => x) :=
        Finset.single_le_sum (f := fun x => x) (fun _ _ => Nat.zero_le _) hmem
      omega
    · rw [if_pos (le_refl a), Finset.erase_right_comm, pairUnion_erase_erase hA ha, Nat.sub_self,
        neg_ne_loss_iff]
      exact hLE0 a ha

/-- The "at most a draw" halves of the pairs conjecture follow from the "at least a draw" half at
odd `k`, gap 1, together with the hard-case claim. -/
theorem pairsConj_le_halves
    (hGE1 : ∀ A : Finset ℕ, PairStarts A → Odd A.card → gv (pairUnion A) 1 ≠ .loss)
    (hHard : ∀ A : Finset ℕ, PairStarts A → Odd A.card →
      ∀ a ∈ A, gv ((pairUnion A).erase a) (a - 1) ≠ .loss) :
    ∀ A : Finset ℕ, PairStarts A →
      (Even A.card → gv (pairUnion A) 0 ≠ .win) ∧ (Odd A.card → gv (pairUnion A) 1 ≠ .win) := by
  intro A
  induction A using Finset.strongInduction with
  | H A IH =>
  intro hA
  have hcard : ∀ a ∈ A, (A.erase a).card + 1 = A.card := by
    intro a ha
    have := Finset.card_pos.mpr ⟨a, ha⟩
    rw [Finset.card_erase_of_mem ha]
    omega
  refine ⟨fun hev => ?_, fun hodd => ?_⟩
  · rcases A.eq_empty_or_nonempty with hAe | ⟨a₀, ha₀⟩
    · subst hAe
      rw [pairUnion_empty, gv_empty]
      simp
    · have hodd' : ∀ a ∈ A, Odd (A.erase a).card := by
        intro a ha
        have := hcard a ha
        rw [Nat.even_iff] at hev
        rw [Nat.odd_iff]
        omega
      apply pairs_le_draw_of_gap_one hA
      · intro a ha
        exact (IH (A.erase a) (Finset.erase_ssubset ha) (pairStarts_erase hA a)).2 (hodd' a ha)
      · intro a ha
        exact hGE1 (A.erase a) (pairStarts_erase hA a) (hodd' a ha)
  · have hev' : ∀ a ∈ A, Even (A.erase a).card := by
      intro a ha
      have := hcard a ha
      rw [Nat.odd_iff] at hodd
      rw [Nat.even_iff]
      omega
    apply pairs_le_draw_of_gap_zero hA
    · intro a ha
      exact (IH (A.erase a) (Finset.erase_ssubset ha) (pairStarts_erase hA a)).1 (hev' a ha)
    · exact hHard A hA hodd

end CatchUpDeep

#print axioms CatchUpDeep.pairsConj_le_halves
