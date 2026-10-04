import FormalConjectures.WrittenOnTheWallII.GraphConjecture61

/-!
# Sweep wowii61 (Graffiti.pc conjecture 61): a proved reduction

Written argument (see `sweep/wowii61/NOTES.md`):
1. Any set `s` inducing a forest has `s.card ≤ f(G)` (`card_le_largestInducedForestSize`).
2. If `I` is independent and `v ∉ I`, then `G.induce (insert v I)` is a subgraph of the
   star centred at `v`, hence acyclic (`induce_insert_indep_isAcyclic`).
3. If `G` is connected on at least two vertices, a maximum independent set misses some vertex,
   so `α(G) + 1 ≤ f(G)` (`indepNum_add_one_le`).
4. If `diam G ≤ 3` then `⌈diam/3⌉ ≤ 1`, so `residue ≤ α` gives the conjecture
   (`conjecture61_of_diam_le_three`). The hypothesis `residue G ≤ G.indepNum` is the
   Favaron–Mahéo–Saclé theorem (from memory, not proved here).
5. Along a walk, two consecutive vertices are never both in an independent set
   (`walk_support_filter_length`).
6. A diametral path has `diam + 1` distinct vertices, so `⌊(diam+1)/2⌋ ≤ n - α`
   (`diam_half_le_card_sub_indepNum`).
7. Hence, given `residue ≤ α`, the conjecture holds when `n - f + ⌈diam/3⌉ ≤ ⌊(diam+1)/2⌋`
   (`conjecture61_of_feedback_le`), in particular for trees (`conjecture61_of_isAcyclic`).
8. If `x, y` are nonadjacent with no common neighbour, `I ∪ {x, y}` induces a forest
   (`induce_insert_two_isAcyclic`); vertices outside `I` near the two ends of a diametral pair
   are at distance `≥ diam - 2`, so `diam ≥ 5 → α + 2 ≤ f` (`indepNum_add_two_le`), and given
   `residue ≤ α` the conjecture holds for `diam ∈ {5, 6}` (`conjecture61_of_diam_five_six`).
-/

namespace Wowii61Sweep

open SimpleGraph

variable {α : Type*} [Fintype α] [DecidableEq α]

omit [DecidableEq α] in
/-- Step 1. -/
theorem card_le_largestInducedForestSize (G : SimpleGraph α) (s : Finset α)
    (hs : (G.induce (s : Set α)).IsAcyclic) : s.card ≤ G.largestInducedForestSize := by
  classical
  unfold largestInducedForestSize
  apply le_csSup
  · refine ⟨Fintype.card α, ?_⟩
    rintro n ⟨t, -, rfl⟩
    exact Finset.card_le_univ t
  · exact ⟨s, hs, rfl⟩

omit [Fintype α] in
/-- Step 2. -/
theorem induce_insert_indep_isAcyclic (G : SimpleGraph α) (I : Finset α)
    (hI : G.IsIndepSet (I : Set α)) (v : α) :
    (G.induce ((insert v I : Finset α) : Set α)).IsAcyclic := by
  refine (isAcyclic_starGraph
    (⟨v, by simp⟩ : ((insert v I : Finset α) : Set α))).anti ?_
  intro x y hxy
  rw [starGraph_adj]
  refine ⟨hxy.ne, ?_⟩
  by_contra hne
  push Not at hne
  obtain ⟨hx, hy⟩ := hne
  have mem : ∀ z : ((insert v I : Finset α) : Set α), z ≠ ⟨v, by simp⟩ → (z : α) ∈ I := by
    intro z hz
    have hz2 := z.2
    simp only [Finset.coe_insert, Set.mem_insert_iff, Finset.mem_coe] at hz2
    rcases hz2 with h | h
    · exact absurd (Subtype.ext h) hz
    · exact h
  have hadj : G.Adj x y := hxy
  exact hI (mem x hx) (mem y hy) (fun h => hxy.ne (Subtype.ext h)) hadj

/-- Step 3. -/
theorem indepNum_add_one_le [Nontrivial α] (G : SimpleGraph α) (h : G.Connected) :
    G.indepNum + 1 ≤ G.largestInducedForestSize := by
  classical
  obtain ⟨I, hI⟩ := G.exists_isNIndepSet_indepNum
  have hv : ∃ v, v ∉ I := by
    by_contra hall
    push Not at hall
    obtain ⟨a, b, hab⟩ := exists_pair_ne α
    obtain ⟨p⟩ := h.preconnected a b
    cases p with
    | nil => exact hab rfl
    | cons hadj _ =>
      exact hI.isIndepSet (by simp [hall]) (by simp [hall]) hadj.ne hadj
  obtain ⟨v, hv⟩ := hv
  have key := card_le_largestInducedForestSize G (insert v I)
    (induce_insert_indep_isAcyclic G I hI.isIndepSet v)
  rw [Finset.card_insert_of_notMem hv, hI.card_eq] at key
  exact key

/-- Step 4. -/
theorem conjecture61_of_diam_le_three [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (hres : residue G ≤ G.indepNum) (hd : G.diam ≤ 3) :
    (residue G : ℝ) + ⌈(G.diam : ℝ) / 3⌉ ≤ (G.largestInducedForestSize : ℝ) := by
  have h1 : ⌈(G.diam : ℝ) / 3⌉ ≤ 1 := by
    rw [Int.ceil_le]
    have : (G.diam : ℝ) ≤ 3 := by exact_mod_cast hd
    push_cast
    linarith
  have h2 := indepNum_add_one_le G h
  have h3 : (residue G : ℝ) + 1 ≤ (G.largestInducedForestSize : ℝ) := by
    exact_mod_cast (by omega : residue G + 1 ≤ G.largestInducedForestSize)
  have h1' : ((⌈(G.diam : ℝ) / 3⌉ : ℤ) : ℝ) ≤ 1 := by exact_mod_cast h1
  linarith

omit [Fintype α] in
/-- Step 5. Along any walk, at least `⌊(length + 1) / 2⌋` support entries lie outside an
independent set `I` (two consecutive support entries cannot both lie in `I`). -/
theorem walk_support_filter_length (G : SimpleGraph α) (I : Finset α)
    (hI : G.IsIndepSet (I : Set α)) :
    ∀ n, ∀ {u v : α} (p : G.Walk u v), p.length = n →
      (p.length + 1) / 2 ≤ (p.support.filter (fun x => decide (x ∉ I))).length := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro u v p hn
    cases p with
    | nil => simp
    | @cons _ w _ h q =>
      by_cases hu : u ∈ I
      · cases q with
        | nil =>
          have hv : v ∉ I := fun hv => hI hu hv h.ne h
          simp [hu, hv]
        | @cons _ x _ h' q' =>
          have hw : w ∉ I := fun hw => hI hu hw h.ne h
          have := ih q'.length (by simp at hn; omega) q' rfl
          simp [Walk.support_cons, hu, hw] at this ⊢
          omega
      · have := ih q.length (by simp at hn; omega) q rfl
        simp [Walk.support_cons, hu] at this ⊢
        omega

/-- Step 6. A diametral path has `diam + 1` distinct vertices, at most `⌈(diam+1)/2⌉` of them
in a maximum independent set, so `⌊(diam + 1) / 2⌋ ≤ n - α`. -/
theorem diam_half_le_card_sub_indepNum [Nontrivial α] (G : SimpleGraph α) (h : G.Connected) :
    (G.diam + 1) / 2 ≤ Fintype.card α - G.indepNum := by
  classical
  obtain ⟨I, hI⟩ := G.exists_isNIndepSet_indepNum
  obtain ⟨u, v, huv⟩ := G.exists_dist_eq_diam
  obtain ⟨p, hp, hlen⟩ := h.exists_path_of_dist u v
  have h1 := walk_support_filter_length G I hI.isIndepSet _ p rfl
  have hnd : (p.support.filter (fun x => decide (x ∉ I))).Nodup := hp.support_nodup.filter _
  have h2 : (p.support.filter (fun x => decide (x ∉ I))).length ≤ (Finset.univ \ I).card := by
    rw [← List.toFinset_card_of_nodup hnd]
    apply Finset.card_le_card
    intro x hx
    simp only [List.mem_toFinset, List.mem_filter, decide_eq_true_eq] at hx
    simpa using hx.2
  rw [Finset.card_univ_sdiff, hI.card_eq] at h2
  rw [hlen, huv] at h1
  omega

omit [DecidableEq α] in
/-- `f(G) ≤ n`. -/
theorem largestInducedForestSize_le_card (G : SimpleGraph α) :
    G.largestInducedForestSize ≤ Fintype.card α := by
  unfold largestInducedForestSize
  apply csSup_le
  · exact ⟨0, ∅, fun v => absurd v.2 (by simp), rfl⟩
  · rintro n ⟨t, -, rfl⟩
    exact Finset.card_le_univ t

/-- Step 7. Conditional on `residue ≤ α`: the conjecture holds whenever the feedback vertex
number `n - f` is at most `⌊(diam+1)/2⌋ - ⌈diam/3⌉`. -/
theorem conjecture61_of_feedback_le [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (hres : residue G ≤ G.indepNum)
    (hfb : Fintype.card α - G.largestInducedForestSize + (G.diam + 2) / 3 ≤ (G.diam + 1) / 2) :
    (residue G : ℝ) + ⌈(G.diam : ℝ) / 3⌉ ≤ (G.largestInducedForestSize : ℝ) := by
  classical
  have hα : G.indepNum ≤ Fintype.card α := by
    obtain ⟨I, hI⟩ := G.exists_isNIndepSet_indepNum
    rw [← hI.card_eq]
    exact Finset.card_le_univ I
  have h6 := diam_half_le_card_sub_indepNum G h
  have hf := largestInducedForestSize_le_card G
  have hnat : residue G + (G.diam + 2) / 3 ≤ G.largestInducedForestSize := by omega
  have hc : ⌈(G.diam : ℝ) / 3⌉ ≤ (((G.diam + 2) / 3 : ℕ) : ℤ) := by
    rw [Int.ceil_le, Int.cast_natCast]
    have h3 : G.diam ≤ 3 * ((G.diam + 2) / 3) := by omega
    have : (G.diam : ℝ) ≤ 3 * (((G.diam + 2) / 3 : ℕ) : ℝ) := by exact_mod_cast h3
    linarith
  have hc' := (Int.cast_le (R := ℝ)).mpr hc
  rw [Int.cast_natCast] at hc'
  have hr : (residue G : ℝ) + (((G.diam + 2) / 3 : ℕ) : ℝ) ≤ (G.largestInducedForestSize : ℝ) := by
    exact_mod_cast hnat
  linarith

/-- Step 8. Conditional on `residue ≤ α`: the conjecture holds for trees. -/
theorem conjecture61_of_isAcyclic [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (hac : G.IsAcyclic) (hres : residue G ≤ G.indepNum) :
    (residue G : ℝ) + ⌈(G.diam : ℝ) / 3⌉ ≤ (G.largestInducedForestSize : ℝ) := by
  apply conjecture61_of_feedback_le G h hres
  have : Fintype.card α ≤ G.largestInducedForestSize := by
    have := card_le_largestInducedForestSize G Finset.univ (hac.induce _)
    simpa using this
  omega

omit [Fintype α] in
/-- Step 9 (Lemma S for two added vertices). If `x, y` are nonadjacent and have no
common neighbour, then `I ∪ {x, y}` induces a forest: every edge has an endpoint in `I` whose
only neighbour is the other endpoint, so every edge is a bridge. -/
theorem induce_insert_two_isAcyclic (G : SimpleGraph α) (I : Finset α)
    (hI : G.IsIndepSet (I : Set α)) (x y : α)
    (hxy : ¬ G.Adj x y) (hc : ∀ w, G.Adj w x → G.Adj w y → False) :
    (G.induce ((insert x (insert y I) : Finset α) : Set α)).IsAcyclic := by
  set H := G.induce ((insert x (insert y I) : Finset α) : Set α) with hH
  have mem : ∀ z : ((insert x (insert y I) : Finset α) : Set α),
      (z : α) = x ∨ (z : α) = y ∨ (z : α) ∈ I := by
    intro z
    have := z.2
    simpa using this
  have outside : ∀ a b : ((insert x (insert y I) : Finset α) : Set α), (a : α) ∈ I →
      G.Adj a b → (b : α) = x ∨ (b : α) = y := by
    intro a b ha hab
    rcases mem b with h | h | h
    · exact Or.inl h
    · exact Or.inr h
    · exact absurd hab (hI ha h hab.ne)
  have key : ∀ a b : ((insert x (insert y I) : Finset α) : Set α), (a : α) ∈ I → H.Adj a b →
      ∀ c, H.Adj a c → c = b := by
    intro a b ha hab c hac
    have hab' : G.Adj a b := hab
    have hac' : G.Adj a c := hac
    apply Subtype.ext
    rcases outside a b ha hab' with hb | hb <;> rcases outside a c ha hac' with hc' | hc'
    · rw [hb, hc']
    · rw [hb] at hab'; rw [hc'] at hac'; exact (hc a hab' hac').elim
    · rw [hb] at hab'; rw [hc'] at hac'; exact (hc a hac' hab').elim
    · rw [hb, hc']
  have bridge : ∀ a b : ((insert x (insert y I) : Finset α) : Set α), (a : α) ∈ I →
      H.Adj a b → H.IsBridge s(a, b) := by
    intro a b ha hab
    rw [isBridge_iff]
    apply not_reachable_of_neighborSet_left_eq_empty hab.ne
    ext c
    simp only [mem_neighborSet, deleteEdges_adj, Set.mem_singleton_iff, Set.mem_empty_iff_false,
      iff_false, not_and, not_not]
    intro hac
    rw [key a b ha hab c hac]
  rw [isAcyclic_iff_forall_adj_isBridge]
  intro a b hab
  have hab' : G.Adj a b := hab
  rcases mem a with ha | ha | ha
  · rcases mem b with hb | hb | hb
    · exact absurd (Subtype.ext (ha.trans hb.symm)) hab.ne
    · rw [ha, hb] at hab'; exact absurd hab' hxy
    · rw [Sym2.eq_swap]; exact bridge b a hb hab.symm
  · rcases mem b with hb | hb | hb
    · rw [ha, hb] at hab'; exact absurd hab'.symm hxy
    · exact absurd (Subtype.ext (ha.trans hb.symm)) hab.ne
    · rw [Sym2.eq_swap]; exact bridge b a hb hab.symm
  · exact bridge a b ha hab

/-- Step 10. If `diam ≥ 5` then `α + 2 ≤ f`. -/
theorem indepNum_add_two_le [Nontrivial α] (G : SimpleGraph α) (h : G.Connected)
    (hd : 5 ≤ G.diam) : G.indepNum + 2 ≤ G.largestInducedForestSize := by
  classical
  obtain ⟨I, hI⟩ := G.exists_isNIndepSet_indepNum
  obtain ⟨u, v, huv⟩ := G.exists_dist_eq_diam
  have near : ∀ z : α, ∃ z', z' ∉ I ∧ G.dist z z' ≤ 1 := by
    intro z
    by_cases hz : z ∈ I
    · obtain ⟨w, hw⟩ : ∃ w, G.Adj z w := by
        obtain ⟨a, ha⟩ := exists_ne z
        obtain ⟨p⟩ := h.preconnected z a
        cases p with
        | nil => exact absurd rfl ha
        | cons hadj _ => exact ⟨_, hadj⟩
      refine ⟨w, fun hwI => hI.isIndepSet hz hwI hw.ne hw, ?_⟩
      rw [dist_eq_one_iff_adj.mpr hw]
    · exact ⟨z, hz, by simp⟩
  obtain ⟨x, hx, hux⟩ := near u
  obtain ⟨y, hy, hvy⟩ := near v
  have t1 : G.dist u v ≤ G.dist u x + G.dist x v := h.dist_triangle
  have t2 : G.dist x v ≤ G.dist x y + G.dist y v := h.dist_triangle
  have hvy' : G.dist y v ≤ 1 := by rw [dist_comm]; exact hvy
  have hxy3 : 3 ≤ G.dist x y := by omega
  have hnadj : ¬ G.Adj x y := fun hadj => by
    rw [dist_eq_one_iff_adj.mpr hadj] at hxy3; omega
  have hc : ∀ w, G.Adj w x → G.Adj w y → False := by
    intro w hwx hwy
    have := dist_le ((Walk.cons hwx.symm (Walk.cons hwy Walk.nil)) : G.Walk x y)
    simp at this
    omega
  have hne : x ≠ y := by
    rintro rfl
    simp at hxy3
  have hxI : x ∉ insert y I := by simp [hne, hx]
  have key := card_le_largestInducedForestSize G (insert x (insert y I))
    (induce_insert_two_isAcyclic G I hI.isIndepSet x y hnadj hc)
  rw [Finset.card_insert_of_notMem hxI, Finset.card_insert_of_notMem hy, hI.card_eq] at key
  omega

/-- Step 11. Conditional on `residue ≤ α`: the conjecture holds when `diam ∈ {5, 6}`. -/
theorem conjecture61_of_diam_five_six [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (hres : residue G ≤ G.indepNum) (hd5 : 5 ≤ G.diam) (hd6 : G.diam ≤ 6) :
    (residue G : ℝ) + ⌈(G.diam : ℝ) / 3⌉ ≤ (G.largestInducedForestSize : ℝ) := by
  have h1 : ⌈(G.diam : ℝ) / 3⌉ ≤ 2 := by
    rw [Int.ceil_le]
    have : (G.diam : ℝ) ≤ 6 := by exact_mod_cast hd6
    push_cast
    linarith
  have h2 := indepNum_add_two_le G h hd5
  have h3 : (residue G : ℝ) + 2 ≤ (G.largestInducedForestSize : ℝ) := by
    exact_mod_cast (by omega : residue G + 2 ≤ G.largestInducedForestSize)
  have h1' : ((⌈(G.diam : ℝ) / 3⌉ : ℤ) : ℝ) ≤ 2 := by exact_mod_cast h1
  linarith

end Wowii61Sweep
