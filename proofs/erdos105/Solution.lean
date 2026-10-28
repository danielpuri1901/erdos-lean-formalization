import FormalConjectures.ErdosProblems.«105»

/-! Solution for the erdos105 target: Xichuan's 10 plus 6 point counterexample, stored in `data/erdos105.json`. -/

open EuclideanGeometry

namespace E105

/-- The ten points A0..A9 of Xichuan's counterexample. -/
noncomputable def A105 : Finset ℝ² :=
  {!₂[168, 0], !₂[280, 560], !₂[280, 140], !₂[420, 630], !₂[360, 240],
   !₂[504, 672], !₂[280, -280], !₂[420, 0], !₂[840, 840], !₂[0, -840]}

/-- The six points B0..B5 of Xichuan's counterexample. -/
noncomputable def B105 : Finset ℝ² :=
  {!₂[0, 420], !₂[840, 3360], !₂[336, 336], !₂[280, 0], !₂[420, 315], !₂[-840, -2520]}

lemma pt_eq_iff (a b c d : ℝ) : (!₂[a, b] : ℝ²) = !₂[c, d] ↔ a = c ∧ b = d := by
  constructor
  · intro h
    exact ⟨by simpa using congrArg (fun x : ℝ² => x 0) h,
      by simpa using congrArg (fun x : ℝ² => x 1) h⟩
  · rintro ⟨rfl, rfl⟩; rfl

lemma disjoint_A_B : Disjoint A105 B105 := by
  rw [Finset.disjoint_left]
  intro x hx hxB
  simp only [A105, B105, Finset.mem_insert, Finset.mem_singleton] at hx hxB
  rcases hx with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    norm_num [pt_eq_iff] at hxB

lemma card_A_B : A105.card = B105.card + 4 := by
  simp only [A105, B105]
  rw [Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff]),
    Finset.card_insert_of_notMem (by norm_num [pt_eq_iff])]
  simp

lemma not_collinear_A : ¬ Collinear ℝ (A105 : Set ℝ²) := by
  intro h
  have hsub : ({!₂[168, 0], !₂[280, 560], !₂[280, 140]} : Set ℝ²) ⊆ (A105 : Set ℝ²) := by
    intro x hx
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    simp only [A105, Finset.coe_insert, Finset.coe_singleton, Set.mem_insert_iff,
      Set.mem_singleton_iff]
    rcases hx with rfl | rfl | rfl <;> simp
  have h3 := h.subset hsub
  rw [collinear_iff_of_mem (p₀ := !₂[168, 0]) (by simp)] at h3
  obtain ⟨v, hv⟩ := h3
  obtain ⟨r1, h1⟩ := hv !₂[280, 560] (by simp)
  obtain ⟨r2, h2⟩ := hv !₂[280, 140] (by simp)
  have e1 := congrArg (fun x : ℝ² => x 0) h1
  have e2 := congrArg (fun x : ℝ² => x 1) h1
  have e3 := congrArg (fun x : ℝ² => x 0) h2
  have e4 := congrArg (fun x : ℝ² => x 1) h2
  simp at e1 e2 e3 e4
  have : (112 * 140 - 560 * 112 : ℝ) = 0 := by
    linear_combination 140 * e1 + r1 * v 0 * e4 - 112 * e2 - r1 * v 1 * e3
  norm_num at this

/-- A point given by an explicit affine parameter lies on the line. -/
lemma mem_line_of (p q b : ℝ²) (t : ℝ) (h : b = AffineMap.lineMap p q t) :
    b ∈ line[ℝ, p, q] := h ▸ AffineMap.lineMap_mem_affineSpan_pair t p q

end E105

open E105 in
theorem erdos_105_sub_four_false :
    ¬ ∀ A B : Finset ℝ², Disjoint A B → A.card = B.card + 4 →
      ¬ Collinear ℝ (A : Set ℝ²) →
      ∃ p ∈ A, ∃ q ∈ A, p ≠ q ∧ ∀ b ∈ B, b ∉ line[ℝ, p, q] := by
  intro h
  obtain ⟨p, hp, q, hq, hpq, hb⟩ := h A105 B105 disjoint_A_B card_A_B not_collinear_A
  simp only [A105, Finset.mem_insert, Finset.mem_singleton] at hp hq
  rcases hp with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact absurd rfl hpq
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (6:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((9:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-4:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((21:ℝ)/16) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((-3:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((4:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((3:ℝ)/8) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (-4:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (-5:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((4:ℝ)/3) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (-2:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((7:ℝ)/10) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((-5:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((2:ℝ)/3) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((2:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((-1:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (-2:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((-5:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((-1:ℝ)/3) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((2:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((7:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-5:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/3) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (-2:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((-1:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (5:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((3:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (-7:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (-5:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (-3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (-1:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((-5:ℝ)/16) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((3:ℝ)/10) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((-3:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (8:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((-5:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (-6:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((-2:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/8) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((2:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((9:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (6:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (6:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((14:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((3:ℝ)/8) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (-4:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((-3:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((4:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((5:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/3) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((2:ℝ)/3) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (4:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (7:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((5:ℝ)/8) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-8:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-2:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (4:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((5:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((3:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((1:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((7:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (5:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (9:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((5:ℝ)/8) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((3:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((3:ℝ)/4) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ (2:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[420, 315] (by simp [B105]) (mem_line_of _ _ _ ((7:ℝ)/8) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[0, 420] (by simp [B105]) (mem_line_of _ _ _ ((5:ℝ)/2) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (4:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (2:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
  · rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (5:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[840, 3360] (by simp [B105]) (mem_line_of _ _ _ (3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((6:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[336, 336] (by simp [B105]) (mem_line_of _ _ _ ((4:ℝ)/5) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((7:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[280, 0] (by simp [B105]) (mem_line_of _ _ _ ((5:ℝ)/9) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-3:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-2:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact hb !₂[-840, -2520] (by simp [B105]) (mem_line_of _ _ _ (-1:ℝ) (by ext c; fin_cases c <;> simp [AffineMap.lineMap_apply] <;> norm_num))
    · exact absurd rfl hpq
