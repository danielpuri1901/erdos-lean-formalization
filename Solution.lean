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

/-- Lemma 1 (general form, for the self-centered case): if no two vertices of `S` at the same distance
from `u` are adjacent, then `G[S]` is bipartite (colour by parity of the distance), so `|S| ≤ b G`. -/
theorem card_le_b_of_layer_indep (G : SimpleGraph α) (u : α) (S : Finset α)
    (hS : ∀ x ∈ S, ∀ y ∈ S, G.dist u x = G.dist u y → ¬ G.Adj x y) :
    (S.card : ℝ) ≤ b G := by
  classical
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
    exact hS a ha c hc hd hac
  have hle : S.card ≤ G.largestInducedBipartiteSubgraphSize := by
    unfold largestInducedBipartiteSubgraphSize
    apply le_csSup
    · exact ⟨Fintype.card α, fun n ⟨t, _, ht⟩ => ht ▸ t.card_le_univ⟩
    · exact ⟨S, hbip, rfl⟩
  unfold b
  exact_mod_cast hle

omit [Fintype α] [DecidableEq α] [Nontrivial α] in
/-- Every vertex at distance `i ≥ j` from `u` has an ancestor at distance `j`, within `i - j` steps. -/
theorem ancestor (G : SimpleGraph α) (h : G.Connected) (u z : α) (j : ℕ) (hj : j ≤ G.dist u z) :
    ∃ z', G.dist u z' = j ∧ G.dist z' z ≤ G.dist u z - j := by
  obtain ⟨q, hq⟩ := h.exists_walk_length_eq_dist u z
  have h2 := dist_le (q.drop j)
  rw [Walk.drop_length] at h2
  refine ⟨q.getVert j, ?_, by omega⟩
  have h1 := dist_le (q.take j)
  rw [Walk.take_length] at h1
  have h3 : G.dist u z ≤ G.dist u (q.getVert j) + G.dist (q.getVert j) z := h.dist_triangle
  have h4 : j ⊓ q.length = j := min_eq_left (by omega)
  omega

/-- Two non-clique layers give `b ≥ ecc u + 3`. -/
theorem two_layers_bip (G : SimpleGraph α) (h : G.Connected) (u x y x' y' : α)
    (hne : x ≠ y) (hadj : ¬ G.Adj x y) (hxy : G.dist u x = G.dist u y)
    (hne' : x' ≠ y') (hadj' : ¬ G.Adj x' y') (hxy' : G.dist u x' = G.dist u y')
    (hjj : G.dist u x ≠ G.dist u x') :
    ((G.eccent u).toNat : ℝ) + 3 ≤ b G := by
  classical
  obtain ⟨v, hv⟩ := G.exists_edist_eq_eccent_of_finite u
  have hecc : G.eccent u ≠ ⊤ :=
    ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
  set D := (G.eccent u).toNat with hDdef
  have hdv : G.dist u v = D := by rw [SimpleGraph.dist, hv]
  have hle : ∀ x, G.dist u x ≤ D := fun x => by
    rw [SimpleGraph.dist]; exact ENat.toNat_le_toNat edist_le_eccent hecc
  obtain ⟨p, hp⟩ := h.exists_walk_length_eq_dist u v
  have hgv : ∀ i ≤ D, G.dist u (p.getVert i) = i := by
    intro i hi
    have h1 := dist_le (p.take i)
    rw [Walk.take_length] at h1
    have h2 := dist_le (p.drop i)
    rw [Walk.drop_length] at h2
    have h3 : G.dist u v ≤ G.dist u (p.getVert i) + G.dist (p.getVert i) v := h.dist_triangle
    have h4 : i ⊓ p.length = i := by rw [hp, hdv]; exact min_eq_left hi
    omega
  set j := G.dist u x with hj
  set j' := G.dist u x' with hj'
  have hjD := hle x
  have hjD' := hle x'
  set T : Finset α :=
    ((Finset.range (D + 1)).filter (fun i => i ≠ j ∧ i ≠ j')).image p.getVert with hTdef
  have hmemT : ∀ w ∈ T, ∃ i, i ≤ D ∧ i ≠ j ∧ i ≠ j' ∧ p.getVert i = w := by
    intro w hw
    simp only [hTdef, Finset.mem_image, Finset.mem_filter, Finset.mem_range] at hw
    obtain ⟨i, ⟨hi, hij, hij'⟩, rfl⟩ := hw
    exact ⟨i, by omega, hij, hij', rfl⟩
  have hT : T.card = D - 1 := by
    rw [hTdef, Finset.card_image_of_injOn]
    · have : (Finset.range (D + 1)).filter (fun i => i ≠ j ∧ i ≠ j') =
          ((Finset.range (D + 1)).erase j).erase j' := by
        ext i; simp [Finset.mem_erase, Finset.mem_filter]; tauto
      rw [this, Finset.card_erase_of_mem, Finset.card_erase_of_mem, Finset.card_range]
      · omega
      · exact Finset.mem_range.mpr (by omega)
      · exact Finset.mem_erase.mpr ⟨Ne.symm hjj, Finset.mem_range.mpr (by omega)⟩
    · intro i hi i' hi' heq
      simp only [Finset.coe_filter, Finset.mem_range, Set.mem_ofPred_eq] at hi hi'
      have e1 := hgv i (by omega)
      have e2 := hgv i' (by omega)
      have : G.dist u (p.getVert i) = G.dist u (p.getVert i') := by rw [heq]
      omega
  have hnT : ∀ w, G.dist u w = j ∨ G.dist u w = j' → w ∉ T := by
    intro w hw hwT
    obtain ⟨i, hi, hij, hij', rfl⟩ := hmemT w hwT
    rw [hgv i hi] at hw
    omega
  have hyd : G.dist u y = j := hxy.symm
  have hyd' : G.dist u y' = j' := hxy'.symm
  set S : Finset α := insert x (insert y (insert x' (insert y' T))) with hSdef
  have hS : S.card = D + 3 := by
    rw [hSdef, Finset.card_insert_of_notMem, Finset.card_insert_of_notMem,
      Finset.card_insert_of_notMem, Finset.card_insert_of_notMem (hnT y' (Or.inr hyd')), hT]
    · omega
    · simp only [Finset.mem_insert, not_or]
      exact ⟨hne', hnT x' (Or.inr rfl)⟩
    · simp only [Finset.mem_insert, not_or]
      refine ⟨fun e => hjj (by rw [← hyd, e]), fun e => hjj (by rw [← hyd, e, hyd']), hnT y (Or.inl hyd)⟩
    · simp only [Finset.mem_insert, not_or]
      refine ⟨hne, fun e => hjj (by rw [hj, e]), fun e => hjj (by rw [hj, e, hyd']), hnT x (Or.inl rfl)⟩
  have hD3 : ((S.card : ℕ) : ℝ) ≤ b G := by
    apply card_le_b_of_layer_indep G u S
    intro a ha c hc hd hac
    simp only [hSdef, Finset.mem_insert] at ha hc
    -- classify by distance
    have cls : ∀ w, (w = x ∨ w = y ∨ w = x' ∨ w = y' ∨ w ∈ T) →
        (G.dist u w = j → w = x ∨ w = y) ∧ (G.dist u w = j' → w = x' ∨ w = y') ∧
        (G.dist u w ≠ j → G.dist u w ≠ j' → w = p.getVert (G.dist u w)) := by
      intro w hw
      rcases hw with rfl | rfl | rfl | rfl | hw
      · exact ⟨fun _ => Or.inl rfl, fun e => absurd e hjj, fun e => absurd rfl e⟩
      · exact ⟨fun _ => Or.inr rfl, fun e => absurd (hyd.symm.trans e) hjj, fun e => absurd hyd e⟩
      · exact ⟨fun e => absurd e.symm hjj, fun _ => Or.inl rfl, fun _ e => absurd rfl e⟩
      · exact ⟨fun e => absurd (e.symm.trans hyd') hjj, fun _ => Or.inr rfl, fun _ e => absurd hyd' e⟩
      · obtain ⟨i, hi, hij, hij', rfl⟩ := hmemT w hw
        rw [hgv i hi]
        exact ⟨fun e => absurd e hij, fun e => absurd e hij', fun _ _ => rfl⟩
    obtain ⟨a1, a2, a3⟩ := cls a ha
    obtain ⟨c1, c2, c3⟩ := cls c hc
    by_cases e1 : G.dist u a = j
    · rcases a1 e1 with rfl | rfl <;> rcases c1 (hd ▸ e1) with rfl | rfl
      · exact hac.ne rfl
      · exact hadj hac
      · exact hadj hac.symm
      · exact hac.ne rfl
    · by_cases e2 : G.dist u a = j'
      · rcases a2 e2 with rfl | rfl <;> rcases c2 (hd ▸ e2) with rfl | rfl
        · exact hac.ne rfl
        · exact hadj' hac
        · exact hadj' hac.symm
        · exact hac.ne rfl
      · have ea := a3 e1 e2
        have ec := c3 (hd ▸ e1) (hd ▸ e2)
        rw [← hd] at ec
        exact hac.ne (ea.trans ec.symm)
  rw [hS] at hD3
  push_cast at hD3
  linarith

/-- If every distance from `w` is at most `m < ecc u`, then `G` is not self-centered. -/
theorem ecc_contra (G : SimpleGraph α) (h : G.Connected) (hsc : ∀ v w : α, G.eccent v = G.eccent w)
    (u w : α) (m : ℕ) (hm : m < (G.eccent u).toNat) (hw : ∀ z, G.dist w z ≤ m) : False := by
  have hecc : G.eccent u ≠ ⊤ :=
    ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
  have h1 : G.eccent w ≤ m := (eccent_le_iff w m).2 fun z => by
    rw [← (h.preconnected w z).coe_dist_eq_edist]
    exact_mod_cast hw z
  rw [hsc w u, ← ENat.natCast_toNat hecc] at h1
  have := ENat.natCast_le_natCast.mp h1
  omega

/-- **B3 (formalized).** No self-centered connected graph of diameter at least `5` satisfies the
hypothesis `b G ≤ 2 + averageEccentricity G`. -/
theorem no_selfCentered_of_diam_ge_five (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G) (hsc : ∀ v w : α, G.eccent v = G.eccent w)
    (u : α) (hD : 5 ≤ (G.eccent u).toNat) : False := by
  classical
  set D := (G.eccent u).toNat with hDdef
  -- the average eccentricity is `D`
  have havg : averageEccentricity G = D := by
    unfold averageEccentricity
    have : ∀ v ∈ (Finset.univ : Finset α), (G.eccent v).toNat = D := fun v _ => by rw [hsc v u]
    rw [Finset.sum_congr rfl this, Finset.sum_const, Finset.card_univ, smul_eq_mul]
    have hcard : (Fintype.card α : ℝ) ≠ 0 := by
      have := Fintype.card_pos (α := α); positivity
    push_cast
    field_simp
  rw [havg] at hb
  obtain ⟨v, hv⟩ := G.exists_edist_eq_eccent_of_finite u
  have hecc : G.eccent u ≠ ⊤ :=
    ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
  have hdv : G.dist u v = D := by rw [SimpleGraph.dist, hv]
  have hle : ∀ x, G.dist u x ≤ D := fun x => by
    rw [SimpleGraph.dist]; exact ENat.toNat_le_toNat edist_le_eccent hecc
  -- clique layers
  let Cl : ℕ → Prop := fun j => ∀ x y, G.dist u x = j → G.dist u y = j → x ≠ y → G.Adj x y
  have two : ∀ i j, i ≠ j → ¬ Cl i → ¬ Cl j → False := by
    intro i j hij hi hj
    simp only [Cl, not_forall] at hi hj
    obtain ⟨x, y, hx, hy, hxy, hadj⟩ := hi
    obtain ⟨x', y', hx', hy', hxy', hadj'⟩ := hj
    have := two_layers_bip G h u x y x' y' hxy hadj (hx.trans hy.symm) hxy' hadj'
      (hx'.trans hy'.symm) (by omega)
    linarith
  have cl_le : ∀ j, Cl j → ∀ x y, G.dist u x = j → G.dist u y = j → G.dist x y ≤ 1 := by
    intro j hj x y hx hy
    by_cases hxy : x = y
    · subst hxy; simp
    · rw [dist_eq_one_iff_adj.mpr (hj x y hx hy hxy)]
  have tri : ∀ a c d : α, G.dist a d ≤ G.dist a c + G.dist c d := fun a c d => h.dist_triangle
  obtain ⟨w2, hw2, -⟩ := ancestor G h u v 2 (by omega)
  by_cases c2 : Cl 2
  · -- case k ≠ 2: the vertex `w2` has eccentricity at most `D - 1`
    refine ecc_contra G h hsc u w2 (D - 1) (by omega) fun z => ?_
    by_cases hz : 2 ≤ G.dist u z
    · obtain ⟨z', hz', hz'z⟩ := ancestor G h u z 2 hz
      have := cl_le 2 c2 w2 z' hw2 hz'
      have := tri w2 z' z
      have := hle z
      omega
    · have h1 := tri w2 u z
      have e : G.dist w2 u = 2 := by rw [SimpleGraph.dist_comm]; exact hw2
      omega
  · have c1 : Cl 1 := by by_contra c1; exact two 1 2 (by omega) c1 c2
    have c3 : Cl 3 := by by_contra c3; exact two 2 3 (by omega) c2 c3
    obtain ⟨w3, hw3, -⟩ := ancestor G h u v 3 (by omega)
    obtain ⟨w1, hw1, hw1w⟩ := ancestor G h u w3 1 (by omega)
    rw [hw3] at hw1w
    refine ecc_contra G h hsc u w3 (D - 1) (by omega) fun z => ?_
    by_cases hz : 3 ≤ G.dist u z
    · obtain ⟨z', hz', hz'z⟩ := ancestor G h u z 3 hz
      have := cl_le 3 c3 w3 z' hw3 hz'
      have := tri w3 z' z
      have := hle z
      omega
    · by_cases hz1 : 1 ≤ G.dist u z
      · obtain ⟨z1, hz1', hz1z⟩ := ancestor G h u z 1 hz1
        have := cl_le 1 c1 w1 z1 hw1 hz1'
        have h1 := tri w3 w1 z
        have h2 := tri w1 z1 z
        have e : G.dist w3 w1 = G.dist w1 w3 := SimpleGraph.dist_comm
        omega
      · have h1 := tri w3 u z
        have e : G.dist w3 u = 3 := by rw [SimpleGraph.dist_comm]; exact hw3
        omega

/-- **Combined (formalized).** Conjecture 198a holds for every connected graph except possibly
self-centered graphs whose common eccentricity is `2`, `3` or `4`. -/
theorem conjecture198a_unless_selfCentered_ecc_two_to_four (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G)
    (hnot : ¬ ((∀ v w : α, G.eccent v = G.eccent w) ∧
      ∃ u : α, 2 ≤ (G.eccent u).toNat ∧ (G.eccent u).toNat ≤ 4)) :
    ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian := by
  by_cases hsc : ∀ v w : α, G.eccent v = G.eccent w
  · obtain ⟨u⟩ := (inferInstance : Nonempty α)
    have hecc : G.eccent u ≠ ⊤ :=
      ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
    by_cases h5 : 5 ≤ (G.eccent u).toNat
    · exact (no_selfCentered_of_diam_ge_five G h hb hsc u h5).elim
    by_cases h2 : 2 ≤ (G.eccent u).toNat
    · exact (hnot ⟨hsc, u, h2, by omega⟩).elim
    -- common eccentricity at most 1: `G` is complete, so every layer is a clique
    refine lemma3_hamPath G h u fun x y _ hne => ?_
    have hx : G.eccent x ≤ 1 := by
      rw [hsc x u, ← ENat.natCast_toNat hecc]
      exact_mod_cast (by omega : (G.eccent u).toNat ≤ 1)
    exact (eccent_le_one_iff x).1 hx y hne
  · push Not at hsc
    obtain ⟨v, w, hvw⟩ := hsc
    exact conjecture198a_of_not_selfCentered G h hb ⟨v, w, hvw⟩

theorem b_le_of_selfCentered (G : SimpleGraph α) (hb : b G ≤ 2 + averageEccentricity G)
    (hsc : ∀ v w : α, G.eccent v = G.eccent w) (r : α) :
    b G ≤ (G.eccent r).toNat + 2 := by
  have havg : averageEccentricity G = (G.eccent r).toNat := by
    unfold averageEccentricity
    have : ∀ v ∈ (Finset.univ : Finset α), (G.eccent v).toNat = (G.eccent r).toNat :=
      fun v _ => by rw [hsc v r]
    rw [Finset.sum_congr rfl this, Finset.sum_const, Finset.card_univ, smul_eq_mul]
    have hcard : (Fintype.card α : ℝ) ≠ 0 := by
      have := Fintype.card_pos (α := α); positivity
    push_cast
    field_simp
  linarith

/-- For a self-centered graph with diameter `≥ 4` satisfying the hypothesis, around every root `r`
the layers `j ≠ 2` are cliques. -/
theorem cl_of_selfCentered (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G) (hsc : ∀ v w : α, G.eccent v = G.eccent w)
    (r : α) (hD : 4 ≤ (G.eccent r).toNat) (j : ℕ) (hj : j ≠ 2) :
    ∀ x y, G.dist r x = j → G.dist r y = j → x ≠ y → G.Adj x y := by
  classical
  have hb' := b_le_of_selfCentered G hb hsc r
  set D := (G.eccent r).toNat with hDdef
  obtain ⟨v, hv⟩ := G.exists_edist_eq_eccent_of_finite r
  have hecc : G.eccent r ≠ ⊤ :=
    ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
  have hdv : G.dist r v = D := by rw [SimpleGraph.dist, hv]
  have hle : ∀ x, G.dist r x ≤ D := fun x => by
    rw [SimpleGraph.dist]; exact ENat.toNat_le_toNat edist_le_eccent hecc
  have tri : ∀ a c d : α, G.dist a d ≤ G.dist a c + G.dist c d := fun a c d => h.dist_triangle
  -- layer 2 is not a clique
  have nc2 : ¬ ∀ x y, G.dist r x = 2 → G.dist r y = 2 → x ≠ y → G.Adj x y := by
    intro c2
    obtain ⟨w2, hw2, -⟩ := ancestor G h r v 2 (by omega)
    refine ecc_contra G h hsc r w2 (D - 1) (by omega) fun z => ?_
    by_cases hz : 2 ≤ G.dist r z
    · obtain ⟨z', hz', hz'z⟩ := ancestor G h r z 2 hz
      have : G.dist w2 z' ≤ 1 := by
        by_cases e : w2 = z'
        · subst e; simp
        · rw [dist_eq_one_iff_adj.mpr (c2 w2 z' hw2 hz' e)]
      have := tri w2 z' z
      have := hle z
      omega
    · have h1 := tri w2 r z
      have e : G.dist w2 r = 2 := by rw [SimpleGraph.dist_comm]; exact hw2
      omega
  intro x y hx hy hxy
  by_contra hadj
  apply nc2
  intro x' y' hx' hy' hxy'
  by_contra hadj'
  have := two_layers_bip G h r x y x' y' hxy hadj (hx.trans hy.symm) hxy' hadj'
    (hx'.trans hy'.symm) (by omega)
  linarith

/-- **B5 (formalized).** No self-centered connected graph of diameter `4` satisfies the hypothesis. -/
theorem no_selfCentered_of_diam_four (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G) (hsc : ∀ v w : α, G.eccent v = G.eccent w)
    (u : α) (hD : (G.eccent u).toNat = 4) : False := by
  classical
  have hD' : ∀ r, (G.eccent r).toNat = 4 := fun r => by rw [hsc r u]; exact hD
  have hecc : ∀ r, G.eccent r ≠ ⊤ := fun r =>
    ne_top_of_le_ne_top (connected_iff_ediam_ne_top.mp h) eccent_le_ediam
  have hle : ∀ r x, G.dist r x ≤ 4 := fun r x => by
    rw [SimpleGraph.dist, ← hD' r]; exact ENat.toNat_le_toNat edist_le_eccent (hecc r)
  have cl : ∀ r j, j ≠ 2 → ∀ x y, G.dist r x = j → G.dist r y = j → x ≠ y → G.Adj x y :=
    fun r j hj => cl_of_selfCentered G h hb hsc r (by rw [hD' r]) j hj
  have tri : ∀ a c d : α, G.dist a d ≤ G.dist a c + G.dist c d := fun a c d => h.dist_triangle
  have d1 : ∀ r j, j ≠ 2 → ∀ x y, G.dist r x = j → G.dist r y = j → G.dist x y ≤ 1 := by
    intro r j hj x y hx hy
    by_cases e : x = y
    · subst e; simp
    · rw [dist_eq_one_iff_adj.mpr (cl r j hj x y hx hy e)]
  obtain ⟨v, hv⟩ := G.exists_edist_eq_eccent_of_finite u
  have hdv : G.dist u v = 4 := by rw [SimpleGraph.dist, hv]; exact hD
  obtain ⟨w3, hw3, -⟩ := ancestor G h u v 3 (by omega)
  obtain ⟨w1, hw1, hw1w⟩ := ancestor G h u w3 1 (by omega)
  rw [hw3] at hw1w
  -- (1) some `z` in layer 2 has no neighbour in layer 3
  have hz : ∃ z, G.dist u z = 2 ∧ ∀ c, G.dist u c = 3 → ¬ G.Adj z c := by
    by_contra hcon
    push Not at hcon
    refine ecc_contra G h hsc u w3 3 (by omega) fun z => ?_
    have hz4 := hle u z
    by_cases hz3 : 3 ≤ G.dist u z
    · obtain ⟨z', hz', hz'z⟩ := ancestor G h u z 3 hz3
      have := d1 u 3 (by omega) w3 z' hw3 hz'
      have := tri w3 z' z
      omega
    · by_cases hz2 : G.dist u z = 2
      · obtain ⟨c, hc, hzc⟩ := hcon z hz2
        have := d1 u 3 (by omega) w3 c hw3 hc
        have := tri w3 c z
        have : G.dist c z = 1 := dist_eq_one_iff_adj.mpr hzc.symm
        omega
      · by_cases hz1 : G.dist u z = 1
        · have := d1 u 1 (by omega) w1 z hw1 hz1
          have := tri w3 w1 z
          have e : G.dist w3 w1 = G.dist w1 w3 := SimpleGraph.dist_comm
          omega
        · have := tri w3 u z
          have e : G.dist w3 u = 3 := by rw [SimpleGraph.dist_comm]; exact hw3
          have : G.dist u z = 0 := by omega
          omega
  obtain ⟨z, hz2, hz3⟩ := hz
  obtain ⟨z1, hz1, hz1z⟩ := ancestor G h u z 1 (by omega)
  rw [hz2] at hz1z
  have hz1z' : G.Adj z1 z := by
    have hne : z1 ≠ z := by intro e; rw [e] at hz1; omega
    have : G.dist z1 z ≠ 0 := by
      intro e0
      exact hne ((SimpleGraph.Reachable.dist_eq_zero_iff (h.preconnected z1 z)).1 e0)
    exact dist_eq_one_iff_adj.mp (by omega)
  -- (2), (3): every `d` in layer 4 is within 3 of `z1`
  have hd : ∀ d, G.dist u d = 4 → G.dist z1 d ≤ 3 := by
    intro d hd4
    -- dist z d = 3
    have hzd_le : G.dist z d ≤ 3 := by
      by_contra hgt
      have h4 : G.dist d z = 4 := by
        have := hle z d
        rw [SimpleGraph.dist_comm]; omega
      have hdu : G.dist d u = 4 := by rw [SimpleGraph.dist_comm]; exact hd4
      have := d1 d 4 (by omega) u z hdu h4
      have := tri u z u
      have hzu : G.dist z u = 2 := by rw [SimpleGraph.dist_comm]; exact hz2
      have := tri u u z
      omega
    have hzd_ge : 3 ≤ G.dist z d := by
      have := tri u z d
      by_contra hlt
      have h2 : G.dist z d = 2 := by omega
      obtain ⟨q, hq⟩ := h.exists_walk_length_eq_dist z d
      have hadj1 : G.Adj z (q.getVert 1) := by
        have := q.adj_getVert_succ (i := 0) (by omega)
        simpa using this
      have hm1 : G.dist (q.getVert 1) d ≤ 1 := by
        have := dist_le (q.drop 1); rw [Walk.drop_length] at this; omega
      have hm2 : G.dist u (q.getVert 1) ≤ 3 := by
        have := tri u z (q.getVert 1)
        rw [dist_eq_one_iff_adj.mpr hadj1] at this; omega
      have hm3 := tri u (q.getVert 1) d
      exact hz3 (q.getVert 1) (by omega) hadj1
    obtain ⟨q, hq⟩ := h.exists_walk_length_eq_dist z d
    set m := q.getVert 1 with hmdef
    have hadjm : G.Adj z m := by
      have := q.adj_getVert_succ (i := 0) (by omega)
      simpa using this
    have hmd : G.dist m d ≤ 2 := by
      have := dist_le (q.drop 1); rw [Walk.drop_length, ← hmdef] at this; omega
    have hum3 : G.dist u m ≤ 3 := by
      have := tri u z m
      rw [dist_eq_one_iff_adj.mpr hadjm] at this; omega
    have hum2 : 2 ≤ G.dist u m := by have := tri u m d; omega
    have hum : G.dist u m = 2 := by
      by_contra hne
      exact hz3 m (by omega) hadjm
    -- `z1` and `m` are both neighbours of `z`, so adjacent (layer 1 around `z` is a clique)
    have hz1m : G.dist z1 m ≤ 1 := by
      have e1 : G.dist z z1 = 1 := dist_eq_one_iff_adj.mpr hz1z'.symm
      have e2 : G.dist z m = 1 := dist_eq_one_iff_adj.mpr hadjm
      exact d1 z 1 (by omega) z1 m e1 e2
    have := tri z1 m d
    omega
  refine ecc_contra G h hsc u z1 3 (by omega) fun y => ?_
  have hy4 := hle u y
  by_cases hy0 : G.dist u y = 0
  · have : G.dist z1 u = 1 := by rw [SimpleGraph.dist_comm]; exact hz1
    have := tri z1 u y
    omega
  · by_cases hy4' : G.dist u y = 4
    · exact hd y hy4'
    · obtain ⟨y1, hy1, hy1y⟩ := ancestor G h u y 1 (by omega)
      have := d1 u 1 (by omega) z1 y1 hz1 hy1
      have := tri z1 y1 y
      omega

/-- **Combined (formalized).** Conjecture 198a holds for every connected graph except possibly
self-centered graphs whose common eccentricity is `2` or `3`. -/
theorem conjecture198a_unless_selfCentered_ecc_two_or_three (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G)
    (hnot : ¬ ((∀ v w : α, G.eccent v = G.eccent w) ∧
      ∃ u : α, 2 ≤ (G.eccent u).toNat ∧ (G.eccent u).toNat ≤ 3)) :
    ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian := by
  refine conjecture198a_unless_selfCentered_ecc_two_to_four G h hb ?_
  rintro ⟨hsc, u, h2, h4⟩
  by_cases h3 : (G.eccent u).toNat ≤ 3
  · exact hnot ⟨hsc, u, h2, h3⟩
  · exact no_selfCentered_of_diam_four G h hb hsc u (by omega)

end Sweep198a
