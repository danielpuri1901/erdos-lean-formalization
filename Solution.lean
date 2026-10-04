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

end Wowii40Sweep
