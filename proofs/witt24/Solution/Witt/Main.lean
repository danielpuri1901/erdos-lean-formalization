import FormalConjectures.Wikipedia.SteinerSystem
import Solution.Witt.PairsA
import Solution.Witt.PairsB
import Solution.Witt.PairsC
import Solution.Witt.PairsD

/-! The witt24 proof: bridge from the mask checks to Finsets, and the counting argument. -/

namespace Witt

open Finset

/-- The subset of `Fin 24` encoded by a mask. -/
def toFS (m : Nat) : Finset (Fin 24) := Finset.univ.filter fun i => m.testBit i.val

theorem mem_toFS (m : Nat) (i : Fin 24) : i ∈ toFS m ↔ m.testBit i.val = true := by
  simp [toFS]

theorem toFS_land (a b : Nat) : toFS (a &&& b) = toFS a ∩ toFS b := by
  ext i
  simp [toFS]

theorem clr_odd {y : Nat} (h : y % 2 = 1) : clr y = y - 1 := by
  unfold clr
  apply Nat.eq_of_testBit_eq
  intro i
  rw [Nat.testBit_land]
  cases i with
  | zero =>
    have e : (y - 1) % 2 = 0 := by omega
    simp [Nat.testBit_zero, e]
  | succ k =>
    have e : (y - 1) / 2 = y / 2 := by omega
    rw [Nat.testBit_succ, Nat.testBit_succ, e, Bool.and_self]

theorem clr_even {y : Nat} (h : y % 2 = 0) :
    clr y % 2 = 0 ∧ clr y / 2 = clr (y / 2) := by
  unfold clr
  constructor
  · have hb : (y &&& (y - 1)).testBit 0 = false := by
      rw [Nat.testBit_land]
      simp [Nat.testBit_zero, h]
    rw [Nat.testBit_zero] at hb
    simp only [decide_eq_false_iff_not] at hb
    omega
  · apply Nat.eq_of_testBit_eq
    intro i
    have e : (y - 1) / 2 = y / 2 - 1 := by omega
    rw [← Nat.testBit_succ, Nat.testBit_land, Nat.testBit_land, Nat.testBit_succ,
      Nat.testBit_succ, e]

theorem pc_clr (n y : Nat) : pc n y ≤ pc n (clr y) + 1 := by
  induction n generalizing y with
  | zero => simp [pc]
  | succ n ih =>
    rw [pc, pc]
    rcases Nat.mod_two_eq_zero_or_one y with h | h
    · obtain ⟨h1, h2⟩ := clr_even h
      rw [h1, h2]
      have := ih (y / 2)
      omega
    · rw [clr_odd h]
      have e1 : (y - 1) % 2 = 0 := by omega
      have e2 : (y - 1) / 2 = y / 2 := by omega
      rw [e1, e2, h]
      omega

theorem pc_eq_sum (n x : Nat) : pc n x = ∑ i : Fin n, if x.testBit i.val then 1 else 0 := by
  induction n generalizing x with
  | zero => simp [pc]
  | succ n ih =>
    rw [Fin.sum_univ_succ, pc, ih (x / 2)]
    congr 1
    · rcases Nat.mod_two_eq_zero_or_one x with h | h <;> simp [Nat.testBit_zero, h]
    · apply Finset.sum_congr rfl
      intro i _
      simp [Nat.testBit_succ]

theorem card_toFS (x : Nat) : (toFS x).card = pc 24 x := by
  rw [pc_eq_sum, toFS, Finset.card_filter]

theorem card_le_four {x : Nat} (h : clr (clr (clr (clr x))) = 0) : (toFS x).card ≤ 4 := by
  rw [card_toFS]
  have h1 := pc_clr 24 x
  have h2 := pc_clr 24 (clr x)
  have h3 := pc_clr 24 (clr (clr x))
  have h4 := pc_clr 24 (clr (clr (clr x)))
  have h5 : pc 24 0 = 0 := by decide
  rw [h, h5] at h4
  omega

theorem cardsOK_true : cardsOK = true := by decide +kernel

theorem octads_length : octads.length = 759 := by decide +kernel

theorem octad_facts {m : Nat} (hm : m ∈ octads) : (toFS m).card = 8 ∧ m < 2 ^ 24 := by
  have := List.all_eq_true.mp cardsOK_true m hm
  simp only [Bool.and_eq_true, beq_iff_eq, decide_eq_true_eq] at this
  exact ⟨(card_toFS m).trans this.1, this.2⟩

theorem rowsOK_sound {lo n : Nat} (h : rowsOK lo n = true) (i : Nat) (h1 : lo ≤ i)
    (h2 : i < lo + n) : rowOK i = true := by
  unfold rowsOK at h
  exact List.all_eq_true.mp h i (List.mem_range'_1.mpr ⟨h1, h2⟩)

theorem all_rows (i : Nat) (hi : i < 759) : rowOK i = true := by
  if h0 : i < 16 then exact rowsOK_sound rows_0_16 i (by omega) (by omega) else
  if h16 : i < 33 then exact rowsOK_sound rows_16_33 i (by omega) (by omega) else
  if h33 : i < 50 then exact rowsOK_sound rows_33_50 i (by omega) (by omega) else
  if h50 : i < 68 then exact rowsOK_sound rows_50_68 i (by omega) (by omega) else
  if h68 : i < 86 then exact rowsOK_sound rows_68_86 i (by omega) (by omega) else
  if h86 : i < 105 then exact rowsOK_sound rows_86_105 i (by omega) (by omega) else
  if h105 : i < 124 then exact rowsOK_sound rows_105_124 i (by omega) (by omega) else
  if h124 : i < 144 then exact rowsOK_sound rows_124_144 i (by omega) (by omega) else
  if h144 : i < 164 then exact rowsOK_sound rows_144_164 i (by omega) (by omega) else
  if h164 : i < 185 then exact rowsOK_sound rows_164_185 i (by omega) (by omega) else
  if h185 : i < 207 then exact rowsOK_sound rows_185_207 i (by omega) (by omega) else
  if h207 : i < 230 then exact rowsOK_sound rows_207_230 i (by omega) (by omega) else
  if h230 : i < 254 then exact rowsOK_sound rows_230_254 i (by omega) (by omega) else
  if h254 : i < 279 then exact rowsOK_sound rows_254_279 i (by omega) (by omega) else
  if h279 : i < 305 then exact rowsOK_sound rows_279_305 i (by omega) (by omega) else
  if h305 : i < 333 then exact rowsOK_sound rows_305_333 i (by omega) (by omega) else
  if h333 : i < 363 then exact rowsOK_sound rows_333_363 i (by omega) (by omega) else
  if h363 : i < 395 then exact rowsOK_sound rows_363_395 i (by omega) (by omega) else
  if h395 : i < 430 then exact rowsOK_sound rows_395_430 i (by omega) (by omega) else
  if h430 : i < 469 then exact rowsOK_sound rows_430_469 i (by omega) (by omega) else
  if h469 : i < 514 then exact rowsOK_sound rows_469_514 i (by omega) (by omega) else
  if h514 : i < 570 then exact rowsOK_sound rows_514_570 i (by omega) (by omega) else
  if h570 : i < 652 then exact rowsOK_sound rows_570_652 i (by omega) (by omega) else
  if h652 : i < 759 then exact rowsOK_sound rows_652_759 i (by omega) (by omega) else
  omega

theorem octads_pairwise : octads.Pairwise fun a b => pairOK a b = true := by
  rw [List.pairwise_iff_getElem]
  intro i j hi hj hij
  have hrow := all_rows i (by rw [octads_length] at hi; exact hi)
  unfold rowOK at hrow
  rw [List.getD_eq_getElem _ _ hi] at hrow
  apply List.all_eq_true.mp hrow
  have hk : j - (i + 1) < (octads.drop (i + 1)).length := by
    rw [List.length_drop]; omega
  have := List.getElem_mem hk
  rw [List.getElem_drop] at this
  have e : i + 1 + (j - (i + 1)) = j := by omega
  simpa [e] using this

/-- The 759 blocks. -/
def blocksL : List (Finset (Fin 24)) := octads.map toFS

def blocks : Finset (Finset (Fin 24)) := blocksL.toFinset

theorem blocksL_pairwise : blocksL.Pairwise fun B C => (B ∩ C).card ≤ 4 := by
  unfold blocksL
  rw [List.pairwise_map]
  refine octads_pairwise.imp_of_mem ?_
  intro a b ha hb hab
  rw [← toFS_land]
  exact card_le_four (by simpa [pairOK] using hab)

theorem block_card' : ∀ B ∈ blocks, B.card = 8 := by
  intro B hB
  simp only [blocks, blocksL, List.mem_toFinset, List.mem_map] at hB
  obtain ⟨m, hm, rfl⟩ := hB
  exact (octad_facts hm).1

theorem blocksL_nodup : blocksL.Nodup := by
  refine blocksL_pairwise.imp_of_mem ?_
  intro B C hB hC h heq
  subst heq
  have := block_card' B (List.mem_toFinset.mpr hB)
  rw [Finset.inter_self] at h
  omega

theorem blocks_card : blocks.card = 759 := by
  rw [blocks, List.toFinset_card_of_nodup blocksL_nodup, blocksL, List.length_map, octads_length]

theorem blocks_inter : ∀ B ∈ blocks, ∀ C ∈ blocks, B ≠ C → (B ∩ C).card ≤ 4 := by
  intro B hB C hC hne
  simp only [blocks, List.mem_toFinset] at hB hC
  have : Std.Symm fun B C : Finset (Fin 24) => (B ∩ C).card ≤ 4 :=
    ⟨fun _ _ h => by rwa [Finset.inter_comm]⟩
  exact blocksL_pairwise.forall hB hC hne

/-- The counting argument: 759 blocks of size 8 that pairwise meet in at most 4 points form
an S(5, 8, 24). -/
theorem cover_of_counts (bs : Finset (Finset (Fin 24))) (hcard : ∀ B ∈ bs, B.card = 8)
    (hinter : ∀ B ∈ bs, ∀ C ∈ bs, B ≠ C → (B ∩ C).card ≤ 4) (hnum : bs.card = 759) :
    ∀ R : Finset (Fin 24), R.card = 5 → (bs.filter (R ⊆ ·)).card = 1 := by
  intro R hR
  -- at most one block contains a 5-set
  have hle : (bs.filter (R ⊆ ·)).card ≤ 1 := by
    rw [Finset.card_le_one]
    intro B hB C hC
    rw [Finset.mem_filter] at hB hC
    by_contra hne
    have h1 := hinter B hB.1 C hC.1 hne
    have h2 : R ⊆ B ∩ C := Finset.subset_inter hB.2 hC.2
    have := Finset.card_le_card h2
    omega
  -- every 5-set lies in some block
  have hdisj : ∀ B ∈ bs, ∀ C ∈ bs, B ≠ C →
      Disjoint (B.powersetCard 5) (C.powersetCard 5) := by
    intro B hB C hC hne
    rw [Finset.disjoint_left]
    intro S hSB hSC
    rw [Finset.mem_powersetCard] at hSB hSC
    have h1 := hinter B hB C hC hne
    have := Finset.card_le_card (Finset.subset_inter hSB.1 hSC.1)
    omega
  have hU : bs.biUnion (fun B => B.powersetCard 5) = (Finset.univ : Finset (Fin 24)).powersetCard 5 := by
    apply Finset.eq_of_subset_of_card_le
    · intro S hS
      rw [Finset.mem_biUnion] at hS
      obtain ⟨B, _, hSB⟩ := hS
      rw [Finset.mem_powersetCard] at hSB ⊢
      exact ⟨Finset.subset_univ _, hSB.2⟩
    · rw [Finset.card_biUnion hdisj, Finset.card_powersetCard, Finset.card_univ, Fintype.card_fin]
      rw [Finset.sum_congr rfl (fun B hB => by rw [Finset.card_powersetCard, hcard B hB])]
      rw [Finset.sum_const, hnum]
      decide
  have hR' : R ∈ bs.biUnion (fun B => B.powersetCard 5) := by
    rw [hU, Finset.mem_powersetCard]
    exact ⟨Finset.subset_univ _, hR⟩
  rw [Finset.mem_biUnion] at hR'
  obtain ⟨B, hB, hRB⟩ := hR'
  rw [Finset.mem_powersetCard] at hRB
  have hpos : 0 < (bs.filter (R ⊆ ·)).card :=
    Finset.card_pos.mpr ⟨B, Finset.mem_filter.mpr ⟨hB, hRB.1⟩⟩
  omega

/-- The large Witt design. -/
def witt : SteinerSystems.SteinerSystem 5 8 24 where
  blocks := blocks
  block_card := block_card'
  cover_unique := cover_of_counts blocks block_card' blocks_inter blocks_card

end Witt
