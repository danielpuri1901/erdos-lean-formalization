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

omit [Fintype α] [DecidableEq α] [Nontrivial α] in
/-- A nonempty `G.Adj`-chain list is the support of a walk. -/
theorem exists_walk_support_eq (G : SimpleGraph α) :
    ∀ (l : List α), l ≠ [] → l.IsChain G.Adj → ∃ a c : α, ∃ p : G.Walk a c, p.support = l
  | [], h, _ => absurd rfl h
  | [a], _, _ => ⟨a, a, Walk.nil, rfl⟩
  | a :: b :: t, _, hc => by
    rw [List.isChain_cons_cons] at hc
    obtain ⟨b', c, p, hp⟩ := exists_walk_support_eq G (b :: t) (List.cons_ne_nil _ _) hc.2
    have hb : b' = b := by
      have := p.cons_tail_support
      rw [hp] at this
      exact (List.cons.inj this).1
    subst hb
    exact ⟨a, c, Walk.cons hc.1 p, by rw [Walk.support_cons, hp]⟩

omit [Fintype α] [DecidableEq α] [Nontrivial α] in
/-- Every vertex at distance `k+1` from `u` has a neighbour at distance `k`. -/
theorem exists_parent (G : SimpleGraph α) (h : G.Connected) (u s : α) (k : ℕ)
    (hs : G.dist u s = k + 1) : ∃ w, G.Adj w s ∧ G.dist u w = k := by
  obtain ⟨q, hq⟩ := h.exists_walk_length_eq_dist u s
  have hadj : G.Adj (q.getVert k) s := by
    have := q.adj_getVert_succ (i := k) (by omega)
    rwa [show k + 1 = q.length by omega, Walk.getVert_length] at this
  refine ⟨q.getVert k, hadj, ?_⟩
  have h1 := dist_le (q.take k)
  rw [Walk.take_length] at h1
  have h2 : G.dist u s ≤ G.dist u (q.getVert k) + G.dist (q.getVert k) s := h.dist_triangle
  have h3 : G.dist (q.getVert k) s = 1 := dist_eq_one_iff_adj.mpr hadj
  have h4 : k ⊓ q.length = k := min_eq_left (by omega)
  omega

/-- Lemma 3. If every distance layer around `u` is a clique, `G` has a Hamiltonian path. -/
theorem lemma3_hamPath (G : SimpleGraph α) (h : G.Connected) (u : α)
    (hcl : ∀ x y : α, G.dist u x = G.dist u y → x ≠ y → G.Adj x y) :
    ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian := by
  classical
  obtain ⟨v, hv⟩ := G.exists_edist_eq_eccent_of_finite u
  have hecc : G.eccent u ≠ ⊤ :=
    ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
  set D := (G.eccent u).toNat with hDdef
  have hdv : G.dist u v = D := by rw [SimpleGraph.dist, hv]
  have hle : ∀ x, G.dist u x ≤ D := fun x => by
    rw [SimpleGraph.dist]; exact ENat.toNat_le_toNat edist_le_eccent hecc
  let Lk : ℕ → Finset α := fun k => Finset.univ.filter (fun x => G.dist u x = k)
  have hLk : ∀ k x, x ∈ Lk k ↔ G.dist u x = k := fun k x => by simp [Lk]
  have hpw : ∀ (k : ℕ) (A : List α), A.Nodup → (∀ x ∈ A, G.dist u x = k) → A.Pairwise G.Adj :=
    fun k A hA hk => hA.pairwise_of_forall_ne fun a ha c hc hac =>
      hcl a c ((hk a ha).trans (hk c hc).symm) hac
  have hhead : ∀ (A B : List α) (y : α), y ∈ (A ++ B).head? → y ∈ A ∨ y ∈ B.head? := by
    intro A B y hy
    cases A with
    | nil => exact Or.inr (by simpa using hy)
    | cons a A' =>
      left
      simp at hy
      simp [hy]
  have key : ∀ m ≤ D, ∃ l : List α, l.IsChain G.Adj ∧ l.Nodup ∧
      (∀ x, x ∈ l ↔ D - m ≤ G.dist u x) ∧ ∀ s ∈ l.head?, G.dist u s = D - m := by
    intro m
    induction m with
    | zero =>
      intro _
      refine ⟨(Lk D).toList, ?_, Finset.nodup_toList _, ?_, ?_⟩
      · exact (hpw D _ (Finset.nodup_toList _) fun x hx =>
          (hLk D x).1 (Finset.mem_toList.1 hx)).isChain
      · intro x
        rw [Finset.mem_toList, hLk]
        have := hle x
        omega
      · intro s hs
        have := (hLk D s).1 (Finset.mem_toList.1 (List.mem_of_mem_head? hs))
        omega
    | succ m ih =>
      intro hm
      obtain ⟨l, hc, hnd, hmem, hhd⟩ := ih (by omega)
      cases l with
      | nil => exact absurd ((hmem v).2 (by omega)) List.not_mem_nil
      | cons s t =>
        have hs : G.dist u s = (D - (m + 1)) + 1 := by
          have := hhd s rfl
          omega
        obtain ⟨w, hws, hw⟩ := exists_parent G h u s _ hs
        have hAmem : ∀ x, x ∈ ((Lk (D - (m + 1))).erase w).toList ↔
            x ≠ w ∧ G.dist u x = D - (m + 1) := fun x => by
          rw [Finset.mem_toList, Finset.mem_erase, hLk]
        refine ⟨((Lk (D - (m + 1))).erase w).toList ++ w :: s :: t, ?_, ?_, ?_, ?_⟩
        · rw [List.isChain_append]
          refine ⟨(hpw _ _ (Finset.nodup_toList _) fun x hx => ((hAmem x).1 hx).2).isChain,
            hc.cons ?_, ?_⟩
          · intro y hy
            simp at hy
            subst hy
            exact hws
          · intro x hx y hy
            simp at hy
            subst hy
            have hxA := (hAmem x).1 (List.mem_of_mem_getLast? hx)
            exact hcl x w (hxA.2.trans hw.symm) hxA.1
        · rw [List.nodup_append]
          refine ⟨Finset.nodup_toList _, List.nodup_cons.2 ⟨?_, hnd⟩, ?_⟩
          · intro hwl
            have := (hmem w).1 hwl
            omega
          · intro a ha c hc' hac
            subst hac
            have h1 := (hAmem a).1 ha
            rcases List.mem_cons.1 hc' with h' | h'
            · exact h1.1 h'
            · have := (hmem a).1 h'
              omega
        · intro x
          rw [List.mem_append, List.mem_cons, hAmem, hmem]
          constructor
          · rintro (⟨_, h'⟩ | h' | h')
            · omega
            · subst h'
              omega
            · omega
          · intro hx
            by_cases hxk : G.dist u x = D - (m + 1)
            · by_cases hxw : x = w
              · exact Or.inr (Or.inl hxw)
              · exact Or.inl ⟨hxw, hxk⟩
            · exact Or.inr (Or.inr (by omega))
        · intro y hy
          rcases hhead _ _ y hy with h' | h'
          · exact ((hAmem y).1 h').2
          · simp at h'
            subst h'
            exact hw
  obtain ⟨l, hc, hnd, hmem, -⟩ := key D le_rfl
  have hne : l ≠ [] := fun h0 => by
    have := (hmem v).2 (by omega)
    rw [h0] at this
    exact List.not_mem_nil this
  obtain ⟨a, c, p, hp⟩ := exists_walk_support_eq G l hne hc
  refine ⟨a, c, p, fun x => ?_⟩
  rw [hp]
  exact List.count_eq_one_of_mem hnd ((hmem x).2 (by omega))

/-- **Theorem A (formalized).** Conjecture 198a holds for every connected graph that is not
self-centered, i.e. whose vertices do not all have the same eccentricity. -/
theorem conjecture198a_of_not_selfCentered (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G)
    (hnsc : ∃ v w : α, G.eccent v ≠ G.eccent w) :
    ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian :=
  caseA_of_lemma3 G h hb hnsc fun u hcl => lemma3_hamPath G h u hcl

end Sweep198a
