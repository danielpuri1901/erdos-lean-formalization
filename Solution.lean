import FormalConjectures.Arxiv.«2507.17780».«3»

/-!
# Sweep work for txgraffiti3

Two special cases of TxGraffiti Conjecture 3 (`i(G) ≤ μ*(G)` for `r`-regular `G`, `r ≥ 1`):
* `tx3_regular_one`: the case `r = 1`;
* `tx3_dense` / `tx3_three_quarters`: the case `2(2r-1)(n-r) ≤ nr`, in particular `4r ≥ 3n`
  (proof outline before `exists_isMaximalEdgeMatching` below).

Written proof of the case `r = 1` (see `sweep/txgraffiti3/NOTES.md`):

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

/-
## Dense case: `2(2r-1)(n-r) ≤ nr`, which holds whenever `4r ≥ 3n`

Written proof:

A. For any vertex `v`, a maximal independent set `I` containing `v` is an independent
   dominating set, and it misses the `r` neighbours of `v`, so `i(G) ≤ |I| ≤ n - r`.
B. For a maximal matching `M`, let `W` be the covered vertices (`|W| ≤ 2|M|`) and `U` the rest.
   Every neighbour of a vertex of `U` lies in `W` (else the edge could be added to `M`).
   Every `w ∈ W` has its `M`-partner, which is in `W`, as a neighbour, so `w` has at most
   `r - 1` neighbours in `U`. Double counting the `U`–`W` edges: `|U| r ≤ |W| (r - 1)`.
   Hence `n r = |U| r + |W| r ≤ |W| (2r - 1) ≤ 2 |M| (2r - 1)`.
C. With `2(2r-1)(n-r) ≤ nr ≤ 2(2r-1)|M|` we get `n - r ≤ |M|`, so `i(G) ≤ |M|` for every
   maximal matching, and `i(G) ≤ μ*(G)`.
-/

/-- Every finite graph has a maximal matching. -/
lemma exists_isMaximalEdgeMatching : ∃ M : Finset (Sym2 V), G.IsMaximalEdgeMatching M := by
  obtain ⟨M, -, hmax⟩ := Finite.exists_le_maximal
    (p := fun M : Finset (Sym2 V) => G.IsEdgeMatching M) (a := ∅) (by simp [IsEdgeMatching])
  refine ⟨M, hmax.1, fun e _ heM hins => heM ?_⟩
  exact hmax.2 hins (Finset.subset_insert e M) (Finset.mem_insert_self e M)

/-- Step A: `i(G) ≤ n - r` for an `r`-regular graph with a vertex `v`. -/
lemma indepDominationNumber_le_card_sub (r : ℕ) (hReg : ∀ v, G.degree v = r) (v : V) :
    G.indepDominationNumber ≤ Fintype.card V - r := by
  obtain ⟨I, -, hmax⟩ := Finite.exists_le_maximal
    (p := fun I : Finset V => G.IsIndepSet (I : Set V) ∧ v ∈ I) (a := {v})
    ⟨by simp, by simp⟩
  have hind : G.IsIndepSet (I : Set V) := hmax.1.1
  have hv : v ∈ I := hmax.1.2
  -- a maximal independent set is dominating
  have hdom : G.IsDominating (I : Set V) := by
    intro u
    by_contra h
    push Not at h
    obtain ⟨hu, hnadj⟩ := h
    have hp : G.IsIndepSet ((insert u I : Finset V) : Set V) ∧ v ∈ insert u I := by
      refine ⟨?_, Finset.mem_insert_of_mem hv⟩
      intro a ha b hb hab hadj
      rw [Finset.coe_insert, Set.mem_insert_iff] at ha hb
      rcases ha with rfl | ha <;> rcases hb with rfl | hb
      · exact hab rfl
      · exact hnadj b hb hadj
      · exact hnadj a ha hadj.symm
      · exact hind ha hb hab hadj
    exact hu (hmax.2 hp (Finset.subset_insert u I) (Finset.mem_insert_self u I))
  -- `I` misses the `r` neighbours of `v`
  have hcard : I.card ≤ Fintype.card V - r := by
    have hdisj : Disjoint I (G.neighborFinset v) := by
      rw [Finset.disjoint_left]
      intro w hw hwn
      have hadj : G.Adj v w := (mem_neighborFinset G v w).1 hwn
      exact hind hv hw (G.ne_of_adj hadj) hadj
    have h1 := Finset.card_union_of_disjoint hdisj
    have h2 := Finset.card_le_univ (I ∪ G.neighborFinset v)
    rw [card_neighborFinset_eq_degree, hReg v] at h1
    omega
  have hi : G.indepDominationNumber ≤ I.card := by
    unfold indepDominationNumber
    exact Nat.sInf_le ⟨I, ⟨hind, hdom, rfl⟩⟩
  exact hi.trans hcard

/-- Step B: `n r ≤ 2 |M| (2r - 1)` for every maximal matching `M` of an `r`-regular graph. -/
lemma card_mul_le_of_isMaximalEdgeMatching (r : ℕ) (hReg : ∀ v, G.degree v = r)
    {M : Finset (Sym2 V)} (hM : G.IsMaximalEdgeMatching M) :
    Fintype.card V * r ≤ 2 * M.card * (2 * r - 1) := by
  classical
  let W : Finset V := Finset.univ.filter (fun v => ∃ e ∈ M, v ∈ e)
  let U : Finset V := Finset.univ.filter (fun v => ¬ ∃ e ∈ M, v ∈ e)
  -- `|W| ≤ 2 |M|`
  have hW : W.card ≤ 2 * M.card := by
    have hsub : W ⊆ M.biUnion (fun e => e.toFinset) := by
      intro v hv
      obtain ⟨e, he, hve⟩ := (Finset.mem_filter.1 hv).2
      exact Finset.mem_biUnion.2 ⟨e, he, Sym2.mem_toFinset.2 hve⟩
    calc W.card ≤ (M.biUnion (fun e => e.toFinset)).card := Finset.card_le_card hsub
      _ ≤ ∑ e ∈ M, e.toFinset.card := Finset.card_biUnion_le
      _ ≤ ∑ _e ∈ M, 2 := Finset.sum_le_sum (fun e _ => by
          rw [Sym2.card_toFinset]; split_ifs <;> omega)
      _ = 2 * M.card := by rw [Finset.sum_const, smul_eq_mul, mul_comm]
  -- every neighbour of a vertex of `U` lies in `W`
  have hUW : ∀ u ∈ U, ∀ w, G.Adj u w → w ∈ W := by
    intro u hu w huw
    by_contra hw
    have hu' : ∀ e ∈ M, u ∉ e := by
      intro e he hue; exact (Finset.mem_filter.1 hu).2 ⟨e, he, hue⟩
    have hw' : ∀ e ∈ M, w ∉ e := by
      intro e he hwe; exact hw (Finset.mem_filter.2 ⟨Finset.mem_univ w, e, he, hwe⟩)
    have hnot : s(u, w) ∉ M := fun h => hu' _ h (Sym2.mem_mk_left u w)
    apply hM.2 s(u, w) huw hnot
    refine ⟨?_, ?_⟩
    · intro e he
      rcases Finset.mem_insert.1 he with rfl | he
      · exact huw
      · exact hM.1.1 e he
    · intro e₁ he₁ e₂ he₂
      rcases Finset.mem_insert.1 he₁ with rfl | hm₁ <;>
        rcases Finset.mem_insert.1 he₂ with rfl | hm₂
      · exact Or.inl rfl
      · right; intro x ⟨hx1, hx2⟩
        rcases Sym2.mem_iff.1 hx1 with h | h
        · exact hu' _ hm₂ (h ▸ hx2)
        · exact hw' _ hm₂ (h ▸ hx2)
      · right; intro x ⟨hx1, hx2⟩
        rcases Sym2.mem_iff.1 hx2 with h | h
        · exact hu' _ hm₁ (h ▸ hx1)
        · exact hw' _ hm₁ (h ▸ hx1)
      · exact hM.1.2 e₁ hm₁ e₂ hm₂
  -- double counting: `|U| r ≤ |W| (r - 1)`
  have hcount : U.card * r ≤ W.card * (r - 1) := by
    apply Finset.card_mul_le_card_mul (fun u w => G.Adj u w)
    · intro u hu
      have hsub : G.neighborFinset u ⊆ W.bipartiteAbove (fun u w => G.Adj u w) u := by
        intro w hw
        have huw : G.Adj u w := (mem_neighborFinset G u w).1 hw
        exact Finset.mem_filter.2 ⟨hUW u hu w huw, huw⟩
      calc r = (G.neighborFinset u).card := by rw [card_neighborFinset_eq_degree, hReg]
        _ ≤ _ := Finset.card_le_card hsub
    · intro w hw
      obtain ⟨e, he, hwe⟩ := (Finset.mem_filter.1 hw).2
      obtain ⟨p, rfl⟩ := Sym2.mem_iff_exists.mp hwe
      have hwp : G.Adj w p := hM.1.1 _ he
      have hpW : p ∈ W := Finset.mem_filter.2 ⟨Finset.mem_univ p, _, he, Sym2.mem_mk_right w p⟩
      have hsub : U.bipartiteBelow (fun u w => G.Adj u w) w ⊆ (G.neighborFinset w).erase p := by
        intro u hu
        obtain ⟨huU, huw⟩ := Finset.mem_filter.1 hu
        refine Finset.mem_erase.2 ⟨?_, (mem_neighborFinset G w u).2 huw.symm⟩
        rintro rfl
        exact (Finset.mem_filter.1 huU).2 (Finset.mem_filter.1 hpW).2
      calc _ ≤ ((G.neighborFinset w).erase p).card := Finset.card_le_card hsub
        _ = r - 1 := by
          rw [Finset.card_erase_of_mem ((mem_neighborFinset G w p).2 hwp),
            card_neighborFinset_eq_degree, hReg]
  -- `|U| + |W| = n`
  have hsplit : W.card + U.card = Fintype.card V := by
    have := Finset.card_filter_add_card_filter_not (s := (Finset.univ : Finset V))
      (fun v => ∃ e ∈ M, v ∈ e)
    rw [Finset.card_univ] at this
    exact this
  -- arithmetic
  rcases Nat.eq_zero_or_pos r with rfl | hr
  · simp
  · obtain ⟨k, rfl⟩ : ∃ k, r = k + 1 := ⟨r - 1, by omega⟩
    have e1 : k + 1 - 1 = k := by omega
    have e2 : 2 * (k + 1) - 1 = 2 * k + 1 := by omega
    rw [e1] at hcount
    rw [e2, ← hsplit]
    nlinarith

/-- Step C: **TxGraffiti Conjecture 3 for dense regular graphs**: if `G` is `r`-regular with
`r ≥ 1` and `2(2r-1)(n-r) ≤ nr`, then `i(G) ≤ μ*(G)`. -/
theorem tx3_dense (r : ℕ) (hReg : ∀ v, G.degree v = r) (hr : 1 ≤ r)
    (hdense : 2 * (2 * r - 1) * (Fintype.card V - r) ≤ Fintype.card V * r) :
    G.indepDominationNumber ≤ G.saturationNumber := by
  rcases isEmpty_or_nonempty V with hV | ⟨⟨v⟩⟩
  · have hi : G.indepDominationNumber ≤ (∅ : Finset V).card := by
      unfold indepDominationNumber
      refine Nat.sInf_le ⟨∅, ⟨?_, ?_, rfl⟩⟩
      · simp
      · intro u; exact hV.elim u
    simp only [Finset.card_empty, nonpos_iff_eq_zero] at hi
    rw [hi]; exact Nat.zero_le _
  have hne : {n | ∃ M : Finset (Sym2 V), G.IsMaximalEdgeMatching M ∧ M.card = n}.Nonempty := by
    obtain ⟨M, hM⟩ := exists_isMaximalEdgeMatching G
    exact ⟨_, M, hM, rfl⟩
  unfold saturationNumber
  apply le_csInf hne
  rintro k ⟨M, hM, rfl⟩
  have hA := indepDominationNumber_le_card_sub G r hReg v
  have hB := card_mul_le_of_isMaximalEdgeMatching G r hReg hM
  have hpos : 0 < 2 * (2 * r - 1) := by omega
  have hle : 2 * (2 * r - 1) * (Fintype.card V - r) ≤ 2 * (2 * r - 1) * M.card := by
    calc _ ≤ Fintype.card V * r := hdense
      _ ≤ 2 * M.card * (2 * r - 1) := hB
      _ = 2 * (2 * r - 1) * M.card := by ring
  exact hA.trans (Nat.le_of_mul_le_mul_left hle hpos)

/-- **TxGraffiti Conjecture 3 holds for `r`-regular graphs with `4r ≥ 3n`.** -/
theorem tx3_three_quarters (r : ℕ) (hReg : ∀ v, G.degree v = r) (hr : 1 ≤ r)
    (h34 : 3 * Fintype.card V ≤ 4 * r) :
    G.indepDominationNumber ≤ G.saturationNumber := by
  apply tx3_dense G r hReg hr
  rcases le_or_gt r (Fintype.card V) with hrn | hrn
  · obtain ⟨d, hd⟩ : ∃ d, Fintype.card V = r + d := ⟨Fintype.card V - r, by omega⟩
    rw [hd, Nat.add_sub_cancel_left]
    have h3 : 3 * d ≤ r := by omega
    obtain ⟨k, rfl⟩ : ∃ k, r = k + 1 := ⟨r - 1, by omega⟩
    have e2 : 2 * (k + 1) - 1 = 2 * k + 1 := by omega
    rw [e2]
    nlinarith
  · rw [Nat.sub_eq_zero_of_le hrn.le]; simp

end Txgraffiti3Sweep
