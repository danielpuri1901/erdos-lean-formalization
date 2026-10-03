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
The lemma statements below follow the plan from `TASKS.md`; each step is proved here, and the
kernel checks of the witnesses live in `Solution/Green72/W<N>.lean`. -/

open Green72Data

/-- The real points of a Nat witness. -/
noncomputable def toReal (p : Nat × Nat) : ℝ × ℝ := ((p.1 : ℝ), (p.2 : ℝ))

/-- `collinear3` is symmetric in its first two arguments. -/
theorem collinear3_swap12 (a b c : Nat × Nat) : collinear3 a b c = collinear3 b a c := by
  unfold collinear3
  rw [Bool.eq_iff_iff]
  simp only [beq_iff_eq]
  constructor <;> intro h <;> linarith

/-- `collinear3` is symmetric in its last two arguments. -/
theorem collinear3_swap23 (a b c : Nat × Nat) : collinear3 a b c = collinear3 a c b := by
  unfold collinear3
  rw [Bool.eq_iff_iff]
  simp only [beq_iff_eq]
  constructor <;> intro h <;> linarith

/-- Soundness of the innermost checker `noThree.allOk`. -/
theorem allOk_spec {p q : Nat × Nat} {l : List (Nat × Nat)} (h : noThree.allOk p q l = true)
    {r : Nat × Nat} (hr : r ∈ l) : collinear3 p q r = false := by
  induction l with
  | nil => simp at hr
  | cons x rest ih =>
    simp only [noThree.allOk, Bool.and_eq_true, Bool.not_eq_true'] at h
    rcases List.mem_cons.mp hr with rfl | hr
    · exact h.1
    · exact ih h.2 hr

/-- Soundness of the middle checker `noThree.pairsOk`. -/
theorem pairsOk_spec {p : Nat × Nat} {l : List (Nat × Nat)} (h : noThree.pairsOk p l = true)
    {b c : Nat × Nat} (hb : b ∈ l) (hc : c ∈ l) (hbc : b ≠ c) : collinear3 p b c = false := by
  induction l with
  | nil => simp at hb
  | cons x rest ih =>
    simp only [noThree.pairsOk, Bool.and_eq_true] at h
    rcases List.mem_cons.mp hb with rfl | hb'
    · rcases List.mem_cons.mp hc with rfl | hc'
      · exact absurd rfl hbc
      · exact allOk_spec h.1 hc'
    · rcases List.mem_cons.mp hc with rfl | hc'
      · rw [collinear3_swap23]; exact allOk_spec h.1 hb'
      · exact ih h.2 hb' hc'

/-- Step 1: the Bool checker is sound for three distinct points of the list. -/
theorem cross_ne_of_noThree {l : List (Nat × Nat)} (h : noThree l = true) (hl : l.Nodup)
    {a b c : Nat × Nat} (ha : a ∈ l) (hb : b ∈ l) (hc : c ∈ l)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) : collinear3 a b c = false := by
  induction l with
  | nil => simp at ha
  | cons p rest ih =>
    simp only [noThree, Bool.and_eq_true] at h
    rcases List.mem_cons.mp ha with rfl | ha'
    · rcases List.mem_cons.mp hb with rfl | hb'
      · exact absurd rfl hab
      rcases List.mem_cons.mp hc with rfl | hc'
      · exact absurd rfl hac
      exact pairsOk_spec h.1 hb' hc' hbc
    · rcases List.mem_cons.mp hb with rfl | hb'
      · rcases List.mem_cons.mp hc with rfl | hc'
        · exact absurd rfl hbc
        rw [collinear3_swap12]
        exact pairsOk_spec h.1 ha' hc' hac
      · rcases List.mem_cons.mp hc with rfl | hc'
        · rw [collinear3_swap23, collinear3_swap12]
          exact pairsOk_spec h.1 ha' hb' hab
        · exact ih h.2 (List.nodup_cons.mp hl).2 ha' hb' hc'

/-- Step 2: unequal cross terms mean three non-collinear real points. -/
theorem not_collinear_of_cross {a b c : Nat × Nat} (h : collinear3 a b c = false) :
    ¬ Collinear ℝ ({toReal a, toReal b, toReal c} : Set (ℝ × ℝ)) := by
  intro hcol
  rw [collinear_iff_of_mem (p₀ := toReal a) (by simp)] at hcol
  obtain ⟨v, hv⟩ := hcol
  obtain ⟨r, hr⟩ := hv (toReal b) (by simp)
  obtain ⟨s, hs⟩ := hv (toReal c) (by simp)
  have hne : (a.1 * b.2 + b.1 * c.2 + c.1 * a.2 : ℕ) ≠ a.1 * c.2 + b.1 * a.2 + c.1 * b.2 := by
    intro heq
    simp [collinear3, heq] at h
  have hneR : ((a.1 : ℝ) * b.2 + b.1 * c.2 + c.1 * a.2) ≠ a.1 * c.2 + b.1 * a.2 + c.1 * b.2 := by
    exact_mod_cast hne
  simp only [toReal, Prod.ext_iff, vadd_eq_add, Prod.fst_add, Prod.snd_add, Prod.smul_fst,
    Prod.smul_snd, smul_eq_mul] at hr hs
  obtain ⟨hr1, hr2⟩ := hr
  obtain ⟨hs1, hs2⟩ := hs
  apply hneR
  rw [hr1, hr2, hs1, hs2]
  ring

/-- Step 3: a verified witness list is an allowed set. -/
theorem allowedSet_of_witness {N : ℕ} {l : List (Nat × Nat)} (hl : l.Nodup)
    (hg : inGrid N l = true) (h3 : noThree l = true) :
    Green72.AllowedSet 3 N l.toFinset := by
  constructor
  · intro i hi
    rw [List.mem_toFinset] at hi
    have := List.all_eq_true.mp hg i hi
    simpa using this
  · intro t ht htc
    obtain ⟨a, b, c, hab, hac, hbc, rfl⟩ := Finset.card_eq_three.mp htc
    have ha : a ∈ l := List.mem_toFinset.mp (ht (by simp))
    have hb : b ∈ l := List.mem_toFinset.mp (ht (by simp))
    have hc : c ∈ l := List.mem_toFinset.mp (ht (by simp))
    have hset : ({r | ∃ i ∈ ({a, b, c} : Finset (ℕ × ℕ)), r = ((i.1 : ℝ), (i.2 : ℝ))} :
        Set (ℝ × ℝ)) = {toReal a, toReal b, toReal c} := by
      ext r
      simp [toReal]
    rw [hset]
    exact not_collinear_of_cross (cross_ne_of_noThree h3 hl ha hb hc hab hac hbc)

/-- Step 4: an allowed set of size 2N gives the equality. -/
theorem noKInLineFor_of_allowed {N : ℕ} {s : Finset (Nat × Nat)}
    (hs : Green72.AllowedSet 3 N s) (hc : s.card = 2 * N) : Green72.NoKInLineFor 3 N := by
  have hle := @Green72.allowedSetSize_le 3 N
  unfold Green72.NoKInLineFor
  unfold Green72.AllowedSetSize at hle ⊢
  apply le_antisymm hle
  show 2 * N ≤ _
  rw [← hc]
  apply le_csSup
  · refine ⟨N * N, ?_⟩
    rintro r ⟨t, rfl, ht⟩
    calc t.card ≤ (Finset.range N ×ˢ Finset.range N).card := by
          apply Finset.card_le_card
          intro i hi
          have := ht.is_bounded i hi
          simp [Finset.mem_product, this.1, this.2]
      _ = N * N := by simp
  · exact ⟨s, rfl, hs⟩

/-- A checked witness list of 2N points gives the equality for N. -/
theorem of_witness {N : ℕ} {l : List (Nat × Nat)}
    (h : noThree l = true ∧ inGrid N l = true ∧ l.Nodup ∧ l.length = 2 * N) :
    Green72.NoKInLineFor 3 N :=
  noKInLineFor_of_allowed (allowedSet_of_witness h.2.2.1 h.2.1 h.1)
    (by rw [List.toFinset_card_of_nodup h.2.2.1]; exact h.2.2.2)

/-- Step 5: every grid size from 3 to 60 has its witness. -/
theorem green72_no_three_in_line_le {N : ℕ} (hN : 3 ≤ N) (hN' : N ≤ 60) :
    Green72.NoKInLineFor 3 N := by
  interval_cases N
  · exact of_witness w3_ok
  · exact of_witness w4_ok
  · exact of_witness w5_ok
  · exact of_witness w6_ok
  · exact of_witness w7_ok
  · exact of_witness w8_ok
  · exact of_witness w9_ok
  · exact of_witness w10_ok
  · exact of_witness w11_ok
  · exact of_witness w12_ok
  · exact of_witness w13_ok
  · exact of_witness w14_ok
  · exact of_witness w15_ok
  · exact of_witness w16_ok
  · exact of_witness w17_ok
  · exact of_witness w18_ok
  · exact of_witness w19_ok
  · exact of_witness w20_ok
  · exact of_witness w21_ok
  · exact of_witness w22_ok
  · exact of_witness w23_ok
  · exact of_witness w24_ok
  · exact of_witness w25_ok
  · exact of_witness w26_ok
  · exact of_witness w27_ok
  · exact of_witness w28_ok
  · exact of_witness w29_ok
  · exact of_witness w30_ok
  · exact of_witness w31_ok
  · exact of_witness w32_ok
  · exact of_witness w33_ok
  · exact of_witness w34_ok
  · exact of_witness w35_ok
  · exact of_witness w36_ok
  · exact of_witness w37_ok
  · exact of_witness w38_ok
  · exact of_witness w39_ok
  · exact of_witness w40_ok
  · exact of_witness w41_ok
  · exact of_witness w42_ok
  · exact of_witness w43_ok
  · exact of_witness w44_ok
  · exact of_witness w45_ok
  · exact of_witness w46_ok
  · exact of_witness w47_ok
  · exact of_witness w48_ok
  · exact of_witness w49_ok
  · exact of_witness w50_ok
  · exact of_witness w51_ok
  · exact of_witness w52_ok
  · exact of_witness w53_ok
  · exact of_witness w54_ok
  · exact of_witness w55_ok
  · exact of_witness w56_ok
  · exact of_witness w57_ok
  · exact of_witness w58_ok
  · exact of_witness w59_ok
  · exact of_witness w60_ok
