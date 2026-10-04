import FormalConjectures.Arxiv.«2507.17780».«3»

/-!
# Sweep work for txgraffiti3

Special case `r = 1` of TxGraffiti Conjecture 3 (`i(G) ≤ μ*(G)` for `r`-regular `G`).
Written proof (see `sweep/txgraffiti3/NOTES.md`):

1. In a 1-regular graph every vertex `v` has exactly one neighbour, so the only edge
   containing `v` is `s(v, w)` for that neighbour `w`; two edges sharing a vertex are equal.
2. Hence every edge lies in every maximal matching `M` (inserting a missing edge would keep
   the matching property), and the edge set itself is a maximal matching.
3. Fix a linear order on `V`. Let `D` be the vertices that are smaller than their neighbour.
   `D` is independent (two adjacent members would each be smaller than the other) and
   dominating (a vertex not in `D` is larger than its neighbour, whose only neighbour is that
   vertex, so the neighbour is in `D`).
4. `v ↦ s(v, w)` maps `D` into `M` injectively (if two members of `D` gave the same edge they
   would be adjacent members of `D`), so `|D| ≤ |M|`, hence `i(G) ≤ |M|` for every maximal
   matching, hence `i(G) ≤ μ*(G)`.
-/

open SimpleGraph

namespace Txgraffiti3Sweep

variable {V : Type} [Fintype V] [DecidableEq V] (G : SimpleGraph V) [DecidableRel G.Adj]

/-- Step 1a: in a 1-regular graph every vertex has a neighbour. -/
lemma exists_adj_of_one (h1 : ∀ v, G.degree v = 1) (v : V) : ∃ w, G.Adj v w := by
  have h := h1 v
  rw [← card_neighborFinset_eq_degree, Finset.card_eq_one] at h
  obtain ⟨c, hc⟩ := h
  have hc' : c ∈ G.neighborFinset v := by rw [hc]; exact Finset.mem_singleton_self c
  exact ⟨c, (mem_neighborFinset G v c).1 hc'⟩

/-- Step 1b: in a 1-regular graph the neighbour is unique. -/
lemma adj_unique_of_one (h1 : ∀ v, G.degree v = 1) {v a b : V}
    (ha : G.Adj v a) (hb : G.Adj v b) : a = b := by
  have h := h1 v
  rw [← card_neighborFinset_eq_degree, Finset.card_eq_one] at h
  obtain ⟨c, hc⟩ := h
  have ha' : a ∈ G.neighborFinset v := (mem_neighborFinset G v a).2 ha
  have hb' : b ∈ G.neighborFinset v := (mem_neighborFinset G v b).2 hb
  rw [hc, Finset.mem_singleton] at ha' hb'
  rw [ha', hb']

/-- Step 1c: in a 1-regular graph, an edge containing `v` is `s(v, w)` for the neighbour `w`. -/
lemma edge_eq_of_one (h1 : ∀ v, G.degree v = 1) {v w : V} (hvw : G.Adj v w)
    {e : Sym2 V} (he : e ∈ G.edgeSet) (hv : v ∈ e) : e = s(v, w) := by
  obtain ⟨x, rfl⟩ := Sym2.mem_iff_exists.mp hv
  rw [mem_edgeSet] at he
  rw [adj_unique_of_one G h1 he hvw]

/-- Step 1d: in a 1-regular graph any set of edges is a matching. -/
lemma isEdgeMatching_of_one (h1 : ∀ v, G.degree v = 1) (M : Finset (Sym2 V))
    (hM : ∀ e ∈ M, e ∈ G.edgeSet) : G.IsEdgeMatching M := by
  refine ⟨hM, fun e₁ he₁ e₂ he₂ => ?_⟩
  by_cases h : ∀ u : V, ¬ (u ∈ e₁ ∧ u ∈ e₂)
  · exact Or.inr h
  · left
    push Not at h
    obtain ⟨u, hu1, hu2⟩ := h
    obtain ⟨x, hux⟩ := exists_adj_of_one G h1 u
    rw [edge_eq_of_one G h1 hux (hM e₁ he₁) hu1, edge_eq_of_one G h1 hux (hM e₂ he₂) hu2]

/-- Step 2a: every edge of a 1-regular graph lies in every maximal matching. -/
lemma mem_of_isMaximalEdgeMatching_of_one (h1 : ∀ v, G.degree v = 1)
    {M : Finset (Sym2 V)} (hM : G.IsMaximalEdgeMatching M) {v w : V} (hvw : G.Adj v w) :
    s(v, w) ∈ M := by
  by_contra hne
  apply hM.2 s(v, w) hvw hne
  apply isEdgeMatching_of_one G h1
  intro e he
  rcases Finset.mem_insert.1 he with rfl | he
  · exact hvw
  · exact hM.1.1 e he

/-- Step 2b: the edge set of a 1-regular graph is a maximal matching. -/
lemma isMaximalEdgeMatching_edgeFinset_of_one (h1 : ∀ v, G.degree v = 1) :
    G.IsMaximalEdgeMatching G.edgeFinset := by
  refine ⟨isEdgeMatching_of_one G h1 _ (fun e he => mem_edgeFinset.1 he), ?_⟩
  intro e he hne
  exact absurd (mem_edgeFinset.2 he) hne

/-- **Special case `r = 1` of TxGraffiti Conjecture 3**: in a 1-regular graph,
`i(G) ≤ μ*(G)`. -/
theorem tx3_regular_one (h1 : ∀ v, G.degree v = 1) :
    G.indepDominationNumber ≤ G.saturationNumber := by
  -- the set of maximal-matching sizes is nonempty (step 2b)
  have hne : {n | ∃ M : Finset (Sym2 V), G.IsMaximalEdgeMatching M ∧ M.card = n}.Nonempty :=
    ⟨_, G.edgeFinset, isMaximalEdgeMatching_edgeFinset_of_one G h1, rfl⟩
  unfold saturationNumber
  apply le_csInf hne
  rintro k ⟨M, hM, rfl⟩
  -- step 3: a linear order on `V` and the set `D`
  let f := Fintype.equivFin V
  let D : Finset V := Finset.univ.filter (fun v => ∀ w, G.Adj v w → f v < f w)
  have hmemD : ∀ v, v ∈ D ↔ ∀ w, G.Adj v w → f v < f w := by
    intro v; simp [D]
  have hind : G.IsIndepSet (D : Set V) := by
    intro v hv w hw hvw hadj
    have h1' := (hmemD v).1 hv w hadj
    have h2' := (hmemD w).1 hw v hadj.symm
    exact absurd (h1'.trans h2') (lt_irrefl _)
  have hdom : G.IsDominating (D : Set V) := by
    intro v
    by_cases hv : v ∈ D
    · exact Or.inl hv
    · right
      obtain ⟨w, hvw⟩ := exists_adj_of_one G h1 v
      refine ⟨w, ?_, hvw⟩
      have hwv : f w < f v := by
        rw [hmemD] at hv
        push Not at hv
        obtain ⟨x, hvx, hx⟩ := hv
        rw [adj_unique_of_one G h1 hvx hvw] at hx
        exact lt_of_le_of_ne hx (fun h => hvw.ne (f.injective h).symm)
      show w ∈ D
      rw [hmemD]
      intro x hwx
      rw [adj_unique_of_one G h1 hwx hvw.symm]
      exact hwv
  -- step 4: `v ↦ s(v, w)` maps `D` injectively into `M`
  let g : V → V := fun v => Classical.choose (exists_adj_of_one G h1 v)
  have hg : ∀ v, G.Adj v (g v) := fun v => Classical.choose_spec (exists_adj_of_one G h1 v)
  have hcard : D.card ≤ M.card := by
    refine Finset.card_le_card_of_injOn (fun v => s(v, g v)) ?_ ?_
    · intro v _
      exact mem_of_isMaximalEdgeMatching_of_one G h1 hM (hg v)
    · intro v hv v' hv' heq
      rcases Sym2.eq_iff.1 heq with ⟨h, _⟩ | ⟨h, h'⟩
      · exact h
      · exfalso
        have hadj : G.Adj v v' := by rw [h]; exact (hg v').symm
        exact hind hv hv' hadj.ne hadj
  have hi : G.indepDominationNumber ≤ D.card := by
    unfold indepDominationNumber
    exact Nat.sInf_le ⟨D, ⟨hind, hdom, rfl⟩⟩
  exact hi.trans hcard

end Txgraffiti3Sweep
