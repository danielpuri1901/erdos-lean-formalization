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

end Wowii61Sweep
