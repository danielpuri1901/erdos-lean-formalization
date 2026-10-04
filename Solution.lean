import FormalConjectures.WrittenOnTheWallII.GraphConjecture19

/-! Sweep work for wowii19: a proof of WOWII conjecture 19.
The argument is written out in `sweep/wowii19/NOTES.md` (Phase C). -/

open SimpleGraph Finset

namespace Wowii19Sweep

variable {α : Type*} [Fintype α] [DecidableEq α]

/-- Lemma 1 (geodesic interpolation). -/
lemma exists_mid (G : SimpleGraph α) (hc : G.Connected) (v y : α) (i : ℕ)
    (hi : i ≤ G.dist v y) : ∃ w, G.dist v w = i ∧ G.dist w y = G.dist v y - i := by
  obtain ⟨p, hp⟩ := hc.exists_walk_length_eq_dist v y
  have h1 : G.dist v (p.getVert i) ≤ i := by
    have := SimpleGraph.dist_le (p.take i)
    rw [Walk.take_length, min_eq_left (by omega)] at this
    exact this
  have h2 : G.dist (p.getVert i) y ≤ G.dist v y - i := by
    have := SimpleGraph.dist_le (p.drop i)
    rw [Walk.drop_length] at this
    omega
  have h3 : G.dist v y ≤ G.dist v (p.getVert i) + G.dist (p.getVert i) y := hc.dist_triangle
  exact ⟨p.getVert i, by omega, by omega⟩

/-- A two-coloured set gives a lower bound for the largest induced bipartite subgraph. -/
lemma card_le_bN (G : SimpleGraph α) (S : Finset α) (col : α → Fin 2)
    (hcol : ∀ u ∈ S, ∀ w ∈ S, G.Adj u w → col u ≠ col w) :
    S.card ≤ G.largestInducedBipartiteSubgraphSize := by
  unfold largestInducedBipartiteSubgraphSize
  apply le_csSup
  · exact ⟨Fintype.card α, fun n ⟨t, _, ht⟩ => ht ▸ t.card_le_univ⟩
  · exact ⟨S, (induce_isBipartite_iff_exists_coloring G S).mpr ⟨col, hcol⟩, rfl⟩

/-- Lemma 2 (layer colouring). -/
lemma layer_card_le_bN (G : SimpleGraph α) (v : α) (S : Finset α)
    (hS : ∀ u ∈ S, ∀ w ∈ S, G.Adj u w → G.dist v u ≠ G.dist v w) :
    S.card ≤ G.largestInducedBipartiteSubgraphSize := by
  apply card_le_bN G S (fun w => if G.dist v w % 2 = 0 then 0 else 1)
  intro u hu w hw huw
  have h1 := hS u hu w hw huw
  rcases (Adj.diff_dist_adj (u := v) huw) with h | h | h
  · exact absurd h.symm h1
  · split_ifs <;> first | decide | (exfalso; omega)
  · split_ifs <;> first | decide | (exfalso; omega)

/-- Lemma 3 (key). -/
lemma key (G : SimpleGraph α) (hc : G.Connected) (v x y : α) :
    indepNeighborsCard G v + G.dist v y +
      (G.dist v x - (G.dist v x + G.dist v y - G.dist x y) - 1)
      ≤ G.largestInducedBipartiteSubgraphSize := by
  classical
  obtain ⟨I0, hI0⟩ := (G.induce (G.neighborSet v)).exists_isNIndepSet_indepNum
  have htri : G.dist x y ≤ G.dist v x + G.dist v y := by
    have h1 : G.dist x y ≤ G.dist x v + G.dist v y := hc.dist_triangle
    have h2 : G.dist x v = G.dist v x := SimpleGraph.dist_comm
    omega
  set a := G.dist v x with ha
  set c := G.dist v y with hcdef
  set t := a + c - G.dist x y with ht
  have : Nonempty α := ⟨v⟩
  have hy' : ∀ i, i ≤ c → ∃ w, G.dist v w = i ∧ G.dist w y = c - i :=
    fun i hi => exists_mid G hc v y i hi
  have hx' : ∀ i, i ≤ a → ∃ w, G.dist v w = i ∧ G.dist w x = a - i :=
    fun i hi => exists_mid G hc v x i hi
  choose! yv hyv1 hyv2 using hy'
  choose! xv hxv1 hxv2 using hx'
  let I : Finset α := I0.map (Function.Embedding.subtype _)
  let Y : Finset α := (Icc 2 c).image yv
  let X : Finset α := (Icc (t + 2) a).image xv
  let S : Finset α := insert v (I ∪ (Y ∪ X))
  have hIdist : ∀ u ∈ I, G.dist v u = 1 := by
    intro u hu
    simp only [I, Finset.mem_map, Function.Embedding.coe_subtype] at hu
    obtain ⟨⟨u', hu'⟩, -, rfl⟩ := hu
    exact dist_eq_one_iff_adj.mpr hu'
  have hIind : ∀ u ∈ I, ∀ w ∈ I, ¬ G.Adj u w := by
    intro u hu w hw huw
    simp only [I, Finset.mem_map, Function.Embedding.coe_subtype] at hu hw
    obtain ⟨u', hu', rfl⟩ := hu
    obtain ⟨w', hw', rfl⟩ := hw
    have hne : u' ≠ w' := by
      rintro rfl
      exact G.irrefl huw
    exact hI0.isIndepSet hu' hw' hne huw
  have hYmem : ∀ u ∈ Y, ∃ i, 2 ≤ i ∧ i ≤ c ∧ u = yv i := by
    intro u hu
    simp only [Y, Finset.mem_image, Finset.mem_Icc] at hu
    obtain ⟨i, ⟨h1, h2⟩, rfl⟩ := hu
    exact ⟨i, h1, h2, rfl⟩
  have hXmem : ∀ u ∈ X, ∃ i, t + 2 ≤ i ∧ i ≤ a ∧ u = xv i := by
    intro u hu
    simp only [X, Finset.mem_image, Finset.mem_Icc] at hu
    obtain ⟨i, ⟨h1, h2⟩, rfl⟩ := hu
    exact ⟨i, h1, h2, rfl⟩
  have hcross : ∀ i, t + 2 ≤ i → i ≤ a → i ≤ c → xv i ≠ yv i ∧ ¬ G.Adj (xv i) (yv i) := by
    intro i h1 h2 h3
    have hxy : G.dist x y ≤ G.dist x (xv i) + G.dist (xv i) (yv i) + G.dist (yv i) y := by
      have e1 : G.dist x y ≤ G.dist x (xv i) + G.dist (xv i) y := hc.dist_triangle
      have e2 : G.dist (xv i) y ≤ G.dist (xv i) (yv i) + G.dist (yv i) y := hc.dist_triangle
      omega
    have hx1 : G.dist x (xv i) = a - i := by rw [SimpleGraph.dist_comm]; exact hxv2 i h2
    have hy2 := hyv2 i h3
    constructor
    · intro h
      have h0 : G.dist (xv i) (yv i) = 0 := by rw [h]; exact SimpleGraph.dist_self
      omega
    · intro h
      have h0 : G.dist (xv i) (yv i) = 1 := dist_eq_one_iff_adj.mpr h
      omega
  have hcases : ∀ z ∈ S, z = v ∨ z ∈ I ∨ (∃ i, 2 ≤ i ∧ i ≤ c ∧ z = yv i) ∨
      (∃ i, t + 2 ≤ i ∧ i ≤ a ∧ z = xv i) := by
    intro z hz
    simp only [S, Finset.mem_insert, Finset.mem_union] at hz
    rcases hz with h | h | h | h
    · exact Or.inl h
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inl (hYmem z h)))
    · exact Or.inr (Or.inr (Or.inr (hXmem z h)))
  have hS : ∀ u ∈ S, ∀ w ∈ S, G.Adj u w → G.dist v u ≠ G.dist v w := by
    intro u hu w hw huw hd
    rcases hcases u hu with hu0 | hu' | ⟨i, hi1, hi2, rfl⟩ | ⟨i, hi1, hi2, rfl⟩ <;>
    rcases hcases w hw with hw0 | hw' | ⟨k, hk1, hk2, rfl⟩ | ⟨k, hk1, hk2, rfl⟩
    -- v, v
    · rw [hu0, hw0] at huw
      exact G.irrefl huw
    -- v, I
    · rw [hu0, SimpleGraph.dist_self, hIdist w hw'] at hd
      omega
    -- v, Y
    · rw [hu0, SimpleGraph.dist_self, hyv1 k hk2] at hd
      omega
    -- v, X
    · rw [hu0, SimpleGraph.dist_self, hxv1 k hk2] at hd
      omega
    -- I, v
    · rw [hw0, SimpleGraph.dist_self, hIdist u hu'] at hd
      omega
    -- I, I
    · exact hIind u hu' w hw' huw
    -- I, Y
    · rw [hIdist u hu', hyv1 k hk2] at hd
      omega
    -- I, X
    · rw [hIdist u hu', hxv1 k hk2] at hd
      omega
    -- Y, v
    · rw [hw0, SimpleGraph.dist_self, hyv1 i hi2] at hd
      omega
    -- Y, I
    · rw [hIdist w hw', hyv1 i hi2] at hd
      omega
    -- Y, Y
    · rw [hyv1 i hi2, hyv1 k hk2] at hd
      subst hd
      exact G.irrefl huw
    -- Y, X
    · rw [hyv1 i hi2, hxv1 k hk2] at hd
      subst hd
      exact (hcross i hk1 hk2 hi2).2 huw.symm
    -- X, v
    · rw [hw0, SimpleGraph.dist_self, hxv1 i hi2] at hd
      omega
    -- X, I
    · rw [hIdist w hw', hxv1 i hi2] at hd
      omega
    -- X, Y
    · rw [hxv1 i hi2, hyv1 k hk2] at hd
      subst hd
      exact (hcross i hi1 hi2 hk2).2 huw
    -- X, X
    · rw [hxv1 i hi2, hxv1 k hk2] at hd
      subst hd
      exact G.irrefl huw
  have hSle := layer_card_le_bN G v S hS
  have hcardI : I.card = indepNeighborsCard G v := by
    simp only [I, Finset.card_map]
    exact hI0.card_eq
  have hcardY : Y.card = c + 1 - 2 := by
    rw [Finset.card_image_of_injOn, Nat.card_Icc]
    intro i hi k hk hik
    simp only [Finset.coe_Icc, Set.mem_Icc] at hi hk
    have e1 := hyv1 i hi.2
    have e2 := hyv1 k hk.2
    rw [hik] at e1
    omega
  have hcardX : X.card = a + 1 - (t + 2) := by
    rw [Finset.card_image_of_injOn, Nat.card_Icc]
    intro i hi k hk hik
    simp only [Finset.coe_Icc, Set.mem_Icc] at hi hk
    have e1 := hxv1 i hi.2
    have e2 := hxv1 k hk.2
    rw [hik] at e1
    omega
  have hYX : Disjoint Y X := by
    rw [Finset.disjoint_left]
    intro z hzY hzX
    obtain ⟨i, hi1, hi2, rfl⟩ := hYmem z hzY
    obtain ⟨k, hk1, hk2, hk⟩ := hXmem _ hzX
    have e1 := hyv1 i hi2
    have e2 := hxv1 k hk2
    rw [hk] at e1
    have hik : i = k := by omega
    subst hik
    exact (hcross i hk1 hk2 hi2).1 hk.symm
  have hIYX : Disjoint I (Y ∪ X) := by
    rw [Finset.disjoint_left]
    intro z hzI hz
    have e0 := hIdist z hzI
    rcases Finset.mem_union.mp hz with h | h
    · obtain ⟨i, hi1, hi2, rfl⟩ := hYmem z h
      rw [hyv1 i hi2] at e0
      omega
    · obtain ⟨i, hi1, hi2, rfl⟩ := hXmem z h
      rw [hxv1 i hi2] at e0
      omega
  have hvS : v ∉ I ∪ (Y ∪ X) := by
    intro h
    rcases hcases v (Finset.mem_insert_of_mem h) with _ | h' | ⟨i, hi1, hi2, hi⟩ |
      ⟨i, hi1, hi2, hi⟩
    · rcases Finset.mem_union.mp h with h1 | h1
      · have := hIdist v h1
        rw [SimpleGraph.dist_self] at this
        omega
      · rcases Finset.mem_union.mp h1 with h2 | h2
        · obtain ⟨i, hi1, hi2, hi⟩ := hYmem v h2
          have := hyv1 i hi2
          rw [← hi, SimpleGraph.dist_self] at this
          omega
        · obtain ⟨i, hi1, hi2, hi⟩ := hXmem v h2
          have := hxv1 i hi2
          rw [← hi, SimpleGraph.dist_self] at this
          omega
    · have := hIdist v h'
      rw [SimpleGraph.dist_self] at this
      omega
    · have := hyv1 i hi2
      rw [← hi, SimpleGraph.dist_self] at this
      omega
    · have := hxv1 i hi2
      rw [← hi, SimpleGraph.dist_self] at this
      omega
  have hcardS : S.card = I.card + (Y.card + X.card) + 1 := by
    simp only [S]
    rw [Finset.card_insert_of_notMem hvS, Finset.card_union_of_disjoint hIYX,
      Finset.card_union_of_disjoint hYX]
  omega

end Wowii19Sweep
