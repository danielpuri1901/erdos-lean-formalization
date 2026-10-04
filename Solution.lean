import FormalConjectures.WrittenOnTheWallII.GraphConjecture40

/-!
# wowii40 sweep: Graffiti.pc conjecture 40, special case

Plain argument (see `sweep/wowii40/NOTES.md`): for a connected graph on `n ≥ 2` vertices,
`p ≤ n - 1` (one edge plus singletons is a path cover) and `b ≤ n`. If `G` is acyclic then `f = n`,
so `⌈(p + b + 1) / 2⌉ ≤ ⌈(n - 1 + n + 1) / 2⌉ = n = f`.
-/

open SimpleGraph

namespace Wowii40Sweep

variable {α : Type*} [Fintype α] [DecidableEq α] (G : SimpleGraph α)

/-- One edge `{u, v}` plus all other vertices as singletons. -/
def edgeCover (u v : α) : Finset (Finset α) :=
  insert {u, v} ((Finset.univ \ {u, v}).image fun w => {w})

/-- Step 1: the edge cover is a path cover. -/
lemma edgeCover_isPathCover {u v : α} (huv : G.Adj u v) :
    IsPathCover G (edgeCover u v) := by
  refine ⟨?_, ?_, ?_⟩
  · intro s1 h1 s2 h2 hne
    rw [edgeCover, Finset.mem_insert, Finset.mem_image] at h1 h2
    rcases h1 with rfl | ⟨w1, hw1, rfl⟩ <;> rcases h2 with rfl | ⟨w2, hw2, rfl⟩
    · exact absurd rfl hne
    · exact Finset.disjoint_singleton_right.mpr (Finset.mem_sdiff.mp hw2).2
    · exact Finset.disjoint_singleton_left.mpr (Finset.mem_sdiff.mp hw1).2
    · exact Finset.disjoint_singleton.mpr fun h => hne (by rw [h])
  · intro x _
    rw [Finset.mem_biUnion]
    by_cases hx : x ∈ ({u, v} : Finset α)
    · exact ⟨{u, v}, Finset.mem_insert_self _ _, hx⟩
    · exact ⟨{x}, Finset.mem_insert_of_mem (Finset.mem_image.mpr
        ⟨x, Finset.mem_sdiff.mpr ⟨Finset.mem_univ x, hx⟩, rfl⟩), Finset.mem_singleton_self x⟩
  · intro s hs
    rw [edgeCover, Finset.mem_insert, Finset.mem_image] at hs
    rcases hs with rfl | ⟨w, _, rfl⟩
    · exact ⟨u, v, huv.toWalk, Walk.IsPath.of_adj huv, by simp⟩
    · exact ⟨w, w, Walk.nil, Walk.IsPath.nil, by simp⟩

/-- Step 2: the edge cover has `n - 1` members. -/
lemma edgeCover_card {u v : α} (huv : u ≠ v) :
    (edgeCover u v).card = Fintype.card α - 1 := by
  have hnot : ({u, v} : Finset α) ∉ (Finset.univ \ {u, v}).image fun w => {w} := by
    intro hmem
    obtain ⟨w, _, hweq⟩ := Finset.mem_image.mp hmem
    have hu : u ∈ ({w} : Finset α) := by rw [hweq]; simp
    have hv : v ∈ ({w} : Finset α) := by rw [hweq]; simp
    rw [Finset.mem_singleton] at hu hv
    exact huv (hu.trans hv.symm)
  have h2 : 2 ≤ Fintype.card α := by
    have := Finset.card_le_univ ({u, v} : Finset α)
    rwa [Finset.card_pair huv] at this
  rw [edgeCover, Finset.card_insert_of_notMem hnot,
    Finset.card_image_of_injective _ Finset.singleton_injective, Finset.card_univ_sdiff,
    Finset.card_pair huv]
  omega

/-- Step 3: `p ≤ n - 1` when `G` has an edge. -/
lemma pathCoverNumber_le_card_sub_one {u v : α} (huv : G.Adj u v) :
    pathCoverNumber G ≤ Fintype.card α - 1 :=
  Nat.sInf_le ⟨edgeCover u v, edgeCover_card huv.ne, edgeCover_isPathCover G huv⟩

omit [DecidableEq α] in
/-- Step 4: `b ≤ n`. -/
lemma largestInducedBipartiteSubgraphSize_le_card :
    G.largestInducedBipartiteSubgraphSize ≤ Fintype.card α := by
  apply csSup_le'
  rintro n ⟨s, _, rfl⟩
  exact Finset.card_le_univ s

omit [DecidableEq α] in
/-- Step 5: `f = n` for an acyclic graph (only `≥` is needed). -/
lemma card_le_largestInducedForestSize (hG : G.IsAcyclic) :
    Fintype.card α ≤ G.largestInducedForestSize := by
  apply le_csSup
  · exact ⟨Fintype.card α, by rintro n ⟨s, _, rfl⟩; exact Finset.card_le_univ s⟩
  · exact ⟨Finset.univ, hG.induce _, Finset.card_univ⟩

omit [DecidableEq α] in
/-- Step 6: a connected graph on at least two vertices has an edge. -/
lemma exists_adj (h_conn : G.Connected) (h_nontrivial : 1 < Fintype.card α) :
    ∃ u v, G.Adj u v := by
  have := Fintype.one_lt_card_iff_nontrivial.mp h_nontrivial
  obtain ⟨u, v, huv⟩ := exists_pair_ne α
  obtain ⟨p⟩ := h_conn.preconnected u v
  cases p with
  | nil => exact absurd rfl huv
  | cons h _ => exact ⟨_, _, h⟩

/-- Conjecture 40 holds for trees. -/
theorem conjecture40_of_isAcyclic (h_conn : G.Connected) (h_nontrivial : 1 < Fintype.card α)
    (hG : G.IsAcyclic) :
    ⌈(((pathCoverNumber G : ℝ) + b G + 1) / 2)⌉ ≤ G.largestInducedForestSize := by
  -- p ≤ n - 1, b ≤ n, n ≤ f
  obtain ⟨u, v, huv⟩ := exists_adj G h_conn h_nontrivial
  have hp := pathCoverNumber_le_card_sub_one G huv
  have hb := largestInducedBipartiteSubgraphSize_le_card G
  have hf := card_le_largestInducedForestSize G hG
  -- the same three facts over ℝ
  have hp' : (pathCoverNumber G : ℝ) + 1 ≤ (Fintype.card α : ℝ) := by
    have : pathCoverNumber G + 1 ≤ Fintype.card α := by omega
    exact_mod_cast this
  have hb' : b G ≤ (Fintype.card α : ℝ) := by
    show (G.largestInducedBipartiteSubgraphSize : ℝ) ≤ _
    exact_mod_cast hb
  have hf' : (Fintype.card α : ℝ) ≤ (G.largestInducedForestSize : ℝ) := by exact_mod_cast hf
  -- (p + b + 1) / 2 ≤ (n - 1 + n + 1) / 2 = n ≤ f
  rw [Int.ceil_le]
  push_cast
  linarith

/- ## Second special case: traceable graphs (`p ≤ 1`)

Plain argument: let `s` be a largest induced bipartite set with colour classes `X`, `Y`, and let `Z`
be the larger class, so `b ≤ 2 |Z|`. `Z` is independent and `Z ≠ V` (G has an edge), so for some
`w ∉ Z` the set `Z ∪ {w}` induces a star plus isolated vertices, a forest. Hence `f ≥ |Z| + 1` and
`b + 2 ≤ 2 f`. If `p ≤ 1` then `(p + b + 1) / 2 ≤ (b + 2) / 2 ≤ f`.
-/

omit [Fintype α] in
/-- Step 7: an independent set plus one vertex induces a forest. -/
lemma induce_insert_isAcyclic (w : α) (X : Finset α) (hX : ∀ x ∈ X, ∀ y ∈ X, ¬ G.Adj x y) :
    (G.induce (↑(insert w X) : Set α)).IsAcyclic := by
  have mem : ∀ z : (↑(insert w X) : Set α), (z : α) = w ∨ (z : α) ∈ X := fun z => by
    have := z.2
    simpa only [Finset.coe_insert, Set.mem_insert_iff, Finset.mem_coe] using this
  -- every edge of the induced graph contains `w`
  have edge : ∀ x y : (↑(insert w X) : Set α), G.Adj x y → (x : α) ≠ w → (y : α) = w := by
    intro x y hxy hxw
    rcases mem y with h | h
    · exact h
    · exact absurd hxy (hX _ ((mem x).resolve_left hxw) _ h)
  rw [isAcyclic_iff_forall_adj_isBridge]
  intro a c hac
  rw [isBridge_iff]
  -- after deleting the edge `ac`, its endpoint different from `w` has no neighbours
  have isolated : ∀ x y : (↑(insert w X) : Set α), (x : α) ≠ w → (x = a ∨ x = c) →
      ¬ ((G.induce (↑(insert w X) : Set α)).deleteEdges {s(a, c)}).Adj x y := by
    intro x y hxw hx hxy
    rw [deleteEdges_adj, Set.mem_singleton_iff] at hxy
    obtain ⟨hxy, hne⟩ := hxy
    have hyw : (y : α) = w := edge x y hxy hxw
    apply hne
    rcases hx with rfl | rfl
    · have hcw : (c : α) = w := edge x c hac hxw
      rw [Subtype.ext (hyw.trans hcw.symm)]
    · have haw : (a : α) = w := edge x a hac.symm hxw
      rw [Subtype.ext (hyw.trans haw.symm), Sym2.eq_swap]
  intro hreach
  by_cases haw : (a : α) = w
  · have hcw : (c : α) ≠ w := fun hcw => hac.ne (Subtype.ext (haw.trans hcw.symm))
    obtain ⟨p⟩ := hreach.symm
    cases p with
    | nil => exact hac.ne rfl
    | cons h _ => exact isolated _ _ hcw (Or.inr rfl) h
  · obtain ⟨p⟩ := hreach
    cases p with
    | nil => exact hac.ne rfl
    | cons h _ => exact isolated _ _ haw (Or.inl rfl) h

/-- Step 8: `b + 2 ≤ 2 f` for a connected graph on at least two vertices. -/
lemma b_add_two_le (h_conn : G.Connected) (h_nontrivial : 1 < Fintype.card α) :
    G.largestInducedBipartiteSubgraphSize + 2 ≤ 2 * G.largestInducedForestSize := by
  -- a largest induced bipartite set `s` with a 2-colouring `c`
  obtain ⟨s, hs, hcard⟩ :=
    Nat.sSup_mem (s := {n | ∃ s : Finset α, (G.induce s).IsBipartite ∧ s.card = n})
      ⟨0, ∅, (induce_isBipartite_iff_exists_coloring G ∅).mpr ⟨fun _ => 0, by simp⟩, rfl⟩
      ⟨Fintype.card α, by rintro n ⟨t, _, rfl⟩; exact Finset.card_le_univ t⟩
  change s.card = G.largestInducedBipartiteSubgraphSize at hcard
  obtain ⟨c, hc⟩ := (induce_isBipartite_iff_exists_coloring G s).mp hs
  -- the two colour classes are independent and together have `b` vertices
  have hXY := Finset.card_filter_add_card_filter_not (s := s) (fun v => c v = 0)
  have hX : ∀ x ∈ s.filter (fun v => c v = 0), ∀ y ∈ s.filter (fun v => c v = 0),
      ¬ G.Adj x y := by
    intro x hx y hy hxy
    rw [Finset.mem_filter] at hx hy
    exact hc x hx.1 y hy.1 hxy (hx.2.trans hy.2.symm)
  have hY : ∀ x ∈ s.filter (fun v => ¬ c v = 0), ∀ y ∈ s.filter (fun v => ¬ c v = 0),
      ¬ G.Adj x y := by
    intro x hx y hy hxy
    rw [Finset.mem_filter] at hx hy
    have key : ∀ i j : Fin 2, i ≠ 0 → j ≠ 0 → i = j := by decide
    exact hc x hx.1 y hy.1 hxy (key _ _ hx.2 hy.2)
  -- `Z`: the larger colour class
  obtain ⟨Z, hZ, hZcard⟩ : ∃ Z : Finset α, (∀ x ∈ Z, ∀ y ∈ Z, ¬ G.Adj x y) ∧
      s.card ≤ 2 * Z.card := by
    rcases le_total (s.filter (fun v => c v = 0)).card (s.filter (fun v => ¬ c v = 0)).card
      with h | h
    · exact ⟨_, hY, by omega⟩
    · exact ⟨_, hX, by omega⟩
  -- a vertex outside `Z`: one end of an edge
  obtain ⟨w, hw⟩ : ∃ w, w ∉ Z := by
    obtain ⟨u, v, huv⟩ := exists_adj G h_conn h_nontrivial
    by_cases hu : u ∈ Z
    · exact ⟨v, fun hv => hZ u hu v hv huv⟩
    · exact ⟨u, hu⟩
  -- `Z ∪ {w}` is an induced forest
  have hf : (insert w Z).card ≤ G.largestInducedForestSize :=
    le_csSup ⟨Fintype.card α, by rintro n ⟨t, _, rfl⟩; exact Finset.card_le_univ t⟩
      ⟨insert w Z, induce_insert_isAcyclic G w Z hZ, rfl⟩
  rw [Finset.card_insert_of_notMem hw] at hf
  omega

/-- Conjecture 40 holds for traceable graphs (path cover number at most one). -/
theorem conjecture40_of_pathCoverNumber_le_one (h_conn : G.Connected)
    (h_nontrivial : 1 < Fintype.card α) (hp : pathCoverNumber G ≤ 1) :
    ⌈(((pathCoverNumber G : ℝ) + b G + 1) / 2)⌉ ≤ G.largestInducedForestSize := by
  have hbf := b_add_two_le G h_conn h_nontrivial
  have hp' : (pathCoverNumber G : ℝ) ≤ 1 := by exact_mod_cast hp
  have hbf' : b G + 2 ≤ 2 * (G.largestInducedForestSize : ℝ) := by
    show (G.largestInducedBipartiteSubgraphSize : ℝ) + 2 ≤ _
    exact_mod_cast hbf
  -- (p + b + 1) / 2 ≤ (b + 2) / 2 ≤ f
  rw [Int.ceil_le]
  push_cast
  linarith

end Wowii40Sweep
