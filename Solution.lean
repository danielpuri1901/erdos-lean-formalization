import FormalConjectures.GreensOpenProblems.«72»
import Solution.Green72.Witnesses
import Solution.Green72.W3
import Solution.Green72.W4
import Solution.Green72.W5
import Solution.Green72.W6
import Solution.Green72.W7
import Solution.Green72.W8
import Solution.Green72.W9
import Solution.Green72.W10
import Solution.Green72.W11
import Solution.Green72.W12
import Solution.Green72.W13
import Solution.Green72.W14
import Solution.Green72.W15
import Solution.Green72.W16
import Solution.Green72.W17
import Solution.Green72.W18
import Solution.Green72.W19
import Solution.Green72.W20
import Solution.Green72.W21
import Solution.Green72.W22
import Solution.Green72.W23
import Solution.Green72.W24
import Solution.Green72.W25
import Solution.Green72.W26
import Solution.Green72.W27
import Solution.Green72.W28
import Solution.Green72.W29
import Solution.Green72.W30
import Solution.Green72.W31
import Solution.Green72.W32
import Solution.Green72.W33
import Solution.Green72.W34
import Solution.Green72.W35
import Solution.Green72.W36
import Solution.Green72.W37
import Solution.Green72.W38
import Solution.Green72.W39
import Solution.Green72.W40
import Solution.Green72.W41
import Solution.Green72.W42
import Solution.Green72.W43
import Solution.Green72.W44
import Solution.Green72.W45
import Solution.Green72.W46
import Solution.Green72.W47
import Solution.Green72.W48
import Solution.Green72.W49
import Solution.Green72.W50
import Solution.Green72.W51
import Solution.Green72.W52
import Solution.Green72.W53
import Solution.Green72.W54
import Solution.Green72.W55
import Solution.Green72.W56
import Solution.Green72.W57
import Solution.Green72.W58
import Solution.Green72.W59
import Solution.Green72.W60

/-! Solution for the green72 target: one verified witness of 2N points per grid size N from 3 to 60
(`Solution/Green72/Witnesses.lean`), lifted to `Green72.NoKInLineFor 3 N` with the upper bound
`Green72.allowedSetSize_le` from formal-conjectures.
The lemma statements below follow the plan from `TASKS.md`; the per-N kernel checks of the
witnesses live in `Solution/Green72/W<N>.lean`. -/

open Green72Data

/-- The real points of a Nat witness. -/
noncomputable def toReal (p : Nat × Nat) : ℝ × ℝ := ((p.1 : ℝ), (p.2 : ℝ))

/-- `collinear3` as a Nat equation of cross terms. -/
theorem collinear3_true_iff (p q r : Nat × Nat) :
    collinear3 p q r = true ↔
      p.1 * q.2 + q.1 * r.2 + r.1 * p.2 = p.1 * r.2 + q.1 * p.2 + r.1 * q.2 := by
  simp [collinear3]

/-- `collinear3` is invariant under swapping its first two arguments. -/
theorem collinear3_swap12 (p q r : Nat × Nat) : collinear3 p q r = collinear3 q p r := by
  rw [Bool.eq_iff_iff, collinear3_true_iff, collinear3_true_iff]
  constructor <;> intro h <;> linarith

/-- `collinear3` is invariant under swapping its last two arguments. -/
theorem collinear3_swap23 (p q r : Nat × Nat) : collinear3 p q r = collinear3 p r q := by
  rw [Bool.eq_iff_iff, collinear3_true_iff, collinear3_true_iff]
  constructor <;> intro h <;> linarith

theorem allOk_iff (p q : Nat × Nat) (l : List (Nat × Nat)) :
    noThree.allOk p q l = true ↔ ∀ r ∈ l, collinear3 p q r = false := by
  induction l with
  | nil => simp [noThree.allOk]
  | cons r rest ih => simp [noThree.allOk, ih]

theorem pairsOk_pairwise (p : Nat × Nat) (l : List (Nat × Nat))
    (h : noThree.pairsOk p l = true) :
    l.Pairwise (fun q r => collinear3 p q r = false) := by
  induction l with
  | nil => exact List.Pairwise.nil
  | cons q rest ih =>
    simp only [noThree.pairsOk, Bool.and_eq_true, allOk_iff] at h
    exact List.Pairwise.cons h.1 (ih h.2)

/-- Step 1: the Bool checker is sound for three distinct points of the list. -/
theorem cross_ne_of_noThree {l : List (Nat × Nat)} (h : noThree l = true) (hl : l.Nodup)
    {a b c : Nat × Nat} (ha : a ∈ l) (hb : b ∈ l) (hc : c ∈ l)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) : collinear3 a b c = false := by
  clear hl
  induction l with
  | nil => simp at ha
  | cons p rest ih =>
    simp only [noThree, Bool.and_eq_true] at h
    have hpw := pairsOk_pairwise p rest h.1
    have : Std.Symm (fun q r => collinear3 p q r = false) :=
      ⟨fun x y hxy => by rw [collinear3_swap23]; exact hxy⟩
    have key : ∀ x ∈ rest, ∀ y ∈ rest, x ≠ y → collinear3 p x y = false := hpw.forall
    simp only [List.mem_cons] at ha hb hc
    rcases ha with rfl | ha
    · exact key b (hb.resolve_left (Ne.symm hab)) c (hc.resolve_left (Ne.symm hac)) hbc
    rcases hb with rfl | hb
    · rw [collinear3_swap12]
      exact key a ha c (hc.resolve_left (Ne.symm hbc)) hac
    rcases hc with rfl | hc
    · rw [collinear3_swap23, collinear3_swap12]
      exact key a ha b hb hab
    exact ih h.2 ha hb hc

/-- Step 2: unequal cross terms mean three non-collinear real points. -/
theorem not_collinear_of_cross {a b c : Nat × Nat} (h : collinear3 a b c = false) :
    ¬ Collinear ℝ ({toReal a, toReal b, toReal c} : Set (ℝ × ℝ)) := by
  intro hcol
  rw [collinear_iff_of_mem (p₀ := toReal a) (by simp)] at hcol
  obtain ⟨v, hv⟩ := hcol
  obtain ⟨r1, hr1⟩ := hv (toReal b) (by simp)
  obtain ⟨r2, hr2⟩ := hv (toReal c) (by simp)
  simp only [toReal, Prod.ext_iff, vadd_eq_add, Prod.fst_add, Prod.snd_add, Prod.smul_fst,
    Prod.smul_snd, smul_eq_mul] at hr1 hr2
  obtain ⟨hB1, hB2⟩ := hr1
  obtain ⟨hC1, hC2⟩ := hr2
  have hne : ¬ (a.1 * b.2 + b.1 * c.2 + c.1 * a.2 = a.1 * c.2 + b.1 * a.2 + c.1 * b.2) := by
    rw [← collinear3_true_iff, h]; simp
  apply hne
  have : ((a.1 * b.2 + b.1 * c.2 + c.1 * a.2 : ℕ) : ℝ) =
      ((a.1 * c.2 + b.1 * a.2 + c.1 * b.2 : ℕ) : ℝ) := by
    push_cast
    linear_combination ((c.2 : ℝ) - a.2) * hB1 + r1 * v.1 * hC2 - ((c.1 : ℝ) - a.1) * hB2 -
      r1 * v.2 * hC1
  exact_mod_cast this

/-- Step 3: a verified witness list is an allowed set. -/
theorem allowedSet_of_witness {N : ℕ} {l : List (Nat × Nat)} (hl : l.Nodup)
    (hg : inGrid N l = true) (h3 : noThree l = true) :
    Green72.AllowedSet 3 N l.toFinset := by
  refine ⟨?_, ?_⟩
  · intro i hi
    simp only [inGrid, List.all_eq_true, Bool.and_eq_true, decide_eq_true_eq] at hg
    exact hg i (List.mem_toFinset.mp hi)
  · intro t ht htc
    obtain ⟨a, b, c, hab, hac, hbc, rfl⟩ := Finset.card_eq_three.mp htc
    have ha : a ∈ l := List.mem_toFinset.mp (ht (by simp))
    have hb : b ∈ l := List.mem_toFinset.mp (ht (by simp))
    have hc : c ∈ l := List.mem_toFinset.mp (ht (by simp))
    have hset : ({r | ∃ i ∈ ({a, b, c} : Finset (ℕ × ℕ)), r = ((↑i.1 : ℝ), (↑i.2 : ℝ))} :
        Set (ℝ × ℝ)) = {toReal a, toReal b, toReal c} := by
      ext r
      simp [toReal]
    rw [hset]
    exact not_collinear_of_cross (cross_ne_of_noThree h3 hl ha hb hc hab hac hbc)

/-- Step 4: an allowed set of size 2N gives the equality. -/
theorem noKInLineFor_of_allowed {N : ℕ} {s : Finset (Nat × Nat)}
    (hs : Green72.AllowedSet 3 N s) (hc : s.card = 2 * N) : Green72.NoKInLineFor 3 N := by
  unfold Green72.NoKInLineFor
  have hbdd : BddAbove {r | ∃ s, r = s.card ∧ Green72.AllowedSet 3 N s} := by
    refine ⟨N * N, ?_⟩
    rintro r ⟨s', rfl, hs'⟩
    have hsub : s' ⊆ Finset.range N ×ˢ Finset.range N := by
      intro i hi
      have := hs'.is_bounded i hi
      simp [Finset.mem_product, this.1, this.2]
    calc s'.card ≤ (Finset.range N ×ˢ Finset.range N).card := Finset.card_le_card hsub
      _ = N * N := by simp
  refine le_antisymm Green72.allowedSetSize_le ?_
  have hle : s.card ≤ Green72.AllowedSetSize 3 N := le_csSup hbdd ⟨s, rfl, hs⟩
  have h2 : (3 - 1) * N = 2 * N := by norm_num
  rw [h2, ← hc]
  exact hle

/-- A kernel-checked witness of size 2N gives `NoKInLineFor 3 N`. -/
theorem of_ok {N : ℕ} {l : List (Nat × Nat)}
    (h : noThree l = true ∧ inGrid N l = true ∧ l.Nodup ∧ l.length = 2 * N) :
    Green72.NoKInLineFor 3 N :=
  noKInLineFor_of_allowed (allowedSet_of_witness h.2.2.1 h.2.1 h.1)
    (by rw [List.toFinset_card_of_nodup h.2.2.1, h.2.2.2])

/-- Step 5: every grid size from 3 to 60 has its witness. -/
theorem green72_no_three_in_line_le {N : ℕ} (hN : 3 ≤ N) (hN' : N ≤ 60) :
    Green72.NoKInLineFor 3 N := by
  interval_cases N
  · exact of_ok w3_ok
  · exact of_ok w4_ok
  · exact of_ok w5_ok
  · exact of_ok w6_ok
  · exact of_ok w7_ok
  · exact of_ok w8_ok
  · exact of_ok w9_ok
  · exact of_ok w10_ok
  · exact of_ok w11_ok
  · exact of_ok w12_ok
  · exact of_ok w13_ok
  · exact of_ok w14_ok
  · exact of_ok w15_ok
  · exact of_ok w16_ok
  · exact of_ok w17_ok
  · exact of_ok w18_ok
  · exact of_ok w19_ok
  · exact of_ok w20_ok
  · exact of_ok w21_ok
  · exact of_ok w22_ok
  · exact of_ok w23_ok
  · exact of_ok w24_ok
  · exact of_ok w25_ok
  · exact of_ok w26_ok
  · exact of_ok w27_ok
  · exact of_ok w28_ok
  · exact of_ok w29_ok
  · exact of_ok w30_ok
  · exact of_ok w31_ok
  · exact of_ok w32_ok
  · exact of_ok w33_ok
  · exact of_ok w34_ok
  · exact of_ok w35_ok
  · exact of_ok w36_ok
  · exact of_ok w37_ok
  · exact of_ok w38_ok
  · exact of_ok w39_ok
  · exact of_ok w40_ok
  · exact of_ok w41_ok
  · exact of_ok w42_ok
  · exact of_ok w43_ok
  · exact of_ok w44_ok
  · exact of_ok w45_ok
  · exact of_ok w46_ok
  · exact of_ok w47_ok
  · exact of_ok w48_ok
  · exact of_ok w49_ok
  · exact of_ok w50_ok
  · exact of_ok w51_ok
  · exact of_ok w52_ok
  · exact of_ok w53_ok
  · exact of_ok w54_ok
  · exact of_ok w55_ok
  · exact of_ok w56_ok
  · exact of_ok w57_ok
  · exact of_ok w58_ok
  · exact of_ok w59_ok
  · exact of_ok w60_ok
