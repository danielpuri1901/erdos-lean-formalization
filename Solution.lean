import FormalConjectures.WrittenOnTheWallII.GraphConjecture198a

/-! Sweep work for wowii198a: the Case A reduction (non-self-centered graphs). -/

open SimpleGraph

namespace Sweep198a

variable {α : Type*} [Fintype α] [DecidableEq α] [Nontrivial α]

/-- Lemma 1 (weak form). Two distinct non-adjacent vertices at the same distance from `u`, together
with a geodesic from `u` of length `ecc u`, form an induced bipartite set of size `ecc u + 2`
(2-colouring by the parity of the distance from `u`). -/
theorem lemma1_bip (G : SimpleGraph α) (h : G.Connected) (u x y : α) (hne : x ≠ y)
    (hadj : ¬ G.Adj x y) (hxy : G.dist u x = G.dist u y) :
    ((G.eccent u).toNat : ℝ) + 2 ≤ b G := by
  classical
  obtain ⟨v, hv⟩ := G.exists_edist_eq_eccent_of_finite u
  have hecc : G.eccent u ≠ ⊤ :=
    ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
  set D := (G.eccent u).toNat with hDdef
  have hdv : G.dist u v = D := by
    rw [SimpleGraph.dist, hv]
  obtain ⟨p, hp⟩ := h.exists_walk_length_eq_dist u v
  -- distances along the geodesic `p`
  have hgv : ∀ i ≤ D, G.dist u (p.getVert i) = i := by
    intro i hi
    have h1 := dist_le (p.take i)
    rw [Walk.take_length] at h1
    have h2 := dist_le (p.drop i)
    rw [Walk.drop_length] at h2
    have h3 : G.dist u v ≤ G.dist u (p.getVert i) + G.dist (p.getVert i) v := h.dist_triangle
    have h4 : i ⊓ p.length = i := by rw [hp, hdv]; exact min_eq_left hi
    omega
  have hjD : G.dist u x ≤ D := by
    rw [SimpleGraph.dist]
    exact ENat.toNat_le_toNat edist_le_eccent hecc
  set j := G.dist u x with hj
  set T : Finset α := ((Finset.range (D + 1)).filter (· ≠ j)).image p.getVert with hTdef
  have hmemT : ∀ w ∈ T, ∃ i, i ≤ D ∧ i ≠ j ∧ p.getVert i = w := by
    intro w hw
    simp only [hTdef, Finset.mem_image, Finset.mem_filter, Finset.mem_range] at hw
    obtain ⟨i, ⟨hi, hij⟩, rfl⟩ := hw
    exact ⟨i, by omega, hij, rfl⟩
  have hT : T.card = D := by
    rw [hTdef, Finset.card_image_of_injOn]
    · rw [Finset.filter_ne' (Finset.range (D + 1)) j, Finset.card_erase_of_mem
        (Finset.mem_range.mpr (by omega)), Finset.card_range]
      omega
    · intro i hi i' hi' heq
      simp only [Finset.coe_filter, Finset.mem_range, Set.mem_ofPred_eq] at hi hi'
      have e1 := hgv i (by omega)
      have e2 := hgv i' (by omega)
      have : G.dist u (p.getVert i) = G.dist u (p.getVert i') := by rw [heq]
      omega
  have hxT : x ∉ T := by
    intro hx
    obtain ⟨i, hi, hij, hix⟩ := hmemT x hx
    have := hgv i hi
    rw [hix] at this
    exact hij (this.symm.trans rfl ▸ hj ▸ rfl)
  have hyT : y ∉ T := by
    intro hy
    obtain ⟨i, hi, hij, hiy⟩ := hmemT y hy
    have := hgv i hi
    rw [hiy, ← hxy] at this
    exact hij this.symm
  set S : Finset α := insert x (insert y T) with hSdef
  have hS : S.card = D + 2 := by
    rw [hSdef, Finset.card_insert_of_notMem, Finset.card_insert_of_notMem hyT, hT]
    simp [hne, hxT]
  -- every vertex of `S` other than `x, y` sits at a distance `≠ j`, one per distance
  have hbip : (G.induce (S : Set α)).IsBipartite := by
    rw [induce_isBipartite_iff_exists_coloring]
    refine ⟨fun w => if G.dist u w % 2 = 0 then 0 else 1, ?_⟩
    intro a ha c hc hac heq
    have hd : G.dist u a = G.dist u c := by
      dsimp only at heq
      rcases hac.diff_dist_adj (u := u) with h' | h' | h'
      · omega
      · split_ifs at heq <;> first | omega | exact absurd heq (by decide)
      · split_ifs at heq <;> first | omega | exact absurd heq (by decide)
    simp only [hSdef, Finset.mem_insert] at ha hc
    rcases ha with rfl | rfl | ha <;> rcases hc with rfl | rfl | hc
    · exact hac.ne rfl
    · exact hadj hac
    · obtain ⟨i, hi, hij, rfl⟩ := hmemT c hc
      rw [hgv i hi] at hd; exact hij hd.symm
    · exact hadj hac.symm
    · exact hac.ne rfl
    · obtain ⟨i, hi, hij, rfl⟩ := hmemT c hc
      rw [hgv i hi, ← hxy] at hd; exact hij hd.symm
    · obtain ⟨i, hi, hij, rfl⟩ := hmemT a ha
      rw [hgv i hi] at hd; exact hij hd
    · obtain ⟨i, hi, hij, rfl⟩ := hmemT a ha
      rw [hgv i hi, ← hxy] at hd; exact hij hd
    · obtain ⟨i, hi, hij, rfl⟩ := hmemT a ha
      obtain ⟨i', hi', hij', rfl⟩ := hmemT c hc
      rw [hgv i hi, hgv i' hi'] at hd
      subst hd
      exact hac.ne rfl
  have hle : D + 2 ≤ G.largestInducedBipartiteSubgraphSize := by
    unfold largestInducedBipartiteSubgraphSize
    apply le_csSup
    · exact ⟨Fintype.card α, fun n ⟨t, _, ht⟩ => ht ▸ t.card_le_univ⟩
    · exact ⟨S, hbip, hS⟩
  unfold b
  exact_mod_cast hle

/-- Case A reduction. If `G` is not self-centered, the conclusion of conjecture 198a follows from
Lemma 1 (two non-adjacent vertices at equal distance from `u` give `b G ≥ ecc u + 2`) and
Lemma 3 (if every distance layer around `u` is a clique, `G` has a Hamiltonian path). -/
theorem caseA_of_lemmas (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G)
    (hnsc : ∃ v w : α, G.eccent v ≠ G.eccent w)
    (L1 : ∀ u x y : α, x ≠ y → ¬ G.Adj x y → G.dist u x = G.dist u y →
      ((G.eccent u).toNat : ℝ) + 2 ≤ b G)
    (L3 : ∀ u : α, (∀ x y : α, G.dist u x = G.dist u y → x ≠ y → G.Adj x y) →
      ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian) :
    ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian := by
  -- a peripheral vertex `u`, and `D` = diameter
  obtain ⟨u, hu⟩ := G.exists_eccent_eq_ediam_of_finite
  have hD : G.ediam ≠ ⊤ := connected_iff_ediam_ne_top.mp h
  -- every eccentricity is at most `D`
  have hle : ∀ v, (G.eccent v).toNat ≤ G.ediam.toNat := fun v =>
    ENat.toNat_le_toNat eccent_le_ediam hD
  -- some eccentricity is below `D`
  have hlt : ∃ v, (G.eccent v).toNat < G.ediam.toNat := by
    obtain ⟨v, w, hvw⟩ := hnsc
    have hne : G.eccent v ≠ G.ediam ∨ G.eccent w ≠ G.ediam := by
      by_contra hc
      push Not at hc
      exact hvw (hc.1.trans hc.2.symm)
    rcases hne with hne | hne
    · refine ⟨v, lt_of_le_of_ne (hle v) fun heq => hne ?_⟩
      have h1 : G.eccent v ≠ ⊤ := ne_top_of_le_ne_top hD eccent_le_ediam
      rw [← ENat.natCast_toNat h1, ← ENat.natCast_toNat hD, heq]
    · refine ⟨w, lt_of_le_of_ne (hle w) fun heq => hne ?_⟩
      have h1 : G.eccent w ≠ ⊤ := ne_top_of_le_ne_top hD eccent_le_ediam
      rw [← ENat.natCast_toNat h1, ← ENat.natCast_toNat hD, heq]
  -- so the average eccentricity is below `D`
  have hsum : (∑ v, (G.eccent v).toNat) < ∑ _v : α, G.ediam.toNat := by
    obtain ⟨v, hv⟩ := hlt
    exact Finset.sum_lt_sum (fun i _ => hle i) ⟨v, Finset.mem_univ v, hv⟩
  have hcard : (0 : ℝ) < Fintype.card α := by exact_mod_cast Fintype.card_pos
  have havg : averageEccentricity G < G.ediam.toNat := by
    unfold averageEccentricity
    rw [div_lt_iff₀ hcard]
    have : ((∑ v, (G.eccent v).toNat : ℕ) : ℝ) < ((∑ _v : α, G.ediam.toNat : ℕ) : ℝ) := by
      exact_mod_cast hsum
    simpa [Finset.sum_const, Finset.card_univ, mul_comm] using this
  -- every layer around `u` is a clique, else Lemma 1 contradicts the hypothesis
  refine L3 u fun x y hxy hne => ?_
  by_contra hadj
  have h1 := L1 u x y hne hadj hxy
  rw [hu] at h1
  linarith

end Sweep198a

namespace Sweep198a

variable {α : Type*} [Fintype α] [DecidableEq α] [Nontrivial α]

/-- Case A, with Lemma 1 proved: for a graph that is not self-centered, the conclusion of
conjecture 198a follows from Lemma 3 alone (all distance layers around `u` cliques ⇒ Ham path). -/
theorem caseA_of_lemma3 (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G)
    (hnsc : ∃ v w : α, G.eccent v ≠ G.eccent w)
    (L3 : ∀ u : α, (∀ x y : α, G.dist u x = G.dist u y → x ≠ y → G.Adj x y) →
      ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian) :
    ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian :=
  caseA_of_lemmas G h hb hnsc (fun u x y hne hadj hxy => lemma1_bip G h u x y hne hadj hxy) L3

end Sweep198a
