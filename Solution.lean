import FormalConjectures.WrittenOnTheWallII.GraphConjecture133

/-!
# Sweep wowii133: the C4 branch of Graffiti.pc 133

The conjecture says `rad + l(G) ^ cC4 ≤ path(G)`. When `G` has a 4-cycle the exponent is `0`,
so the claim is `rad + 1 ≤ path`. This holds for every connected graph:
a shortest walk from `u` to a vertex `v` at distance `ecc u ≥ rad` has no chord,
so its support is an induced path with `dist u v + 1 ≥ rad + 1` vertices.
Hence the conjecture reduces to `C4`-free graphs (`conjecture133_of_C4free_case`).
-/

open SimpleGraph

namespace Wowii133Sweep

variable {α : Type*} [Fintype α] [DecidableEq α]

omit [Fintype α] [DecidableEq α] in
/-- Step 1. A shortest walk has no chord: vertex `i` and vertex `j ≥ i + 2` are not adjacent,
since otherwise `take i`, the chord, and `drop j` form a shorter walk. -/
lemma geodesic_not_adj {G : SimpleGraph α} {u v : α} (p : G.Walk u v)
    (hp : p.length = G.dist u v) {i j : ℕ} (hij : i + 2 ≤ j) (hj : j ≤ p.length) :
    ¬ G.Adj (p.getVert i) (p.getVert j) := by
  intro hadj
  let q : G.Walk u v := (p.take i).append (Walk.cons hadj (p.drop j))
  have hq : q.length = i + 1 + (p.length - j) := by
    simp only [q, Walk.length_append, Walk.take_length, Walk.length_cons, Walk.drop_length]
    omega
  have := G.dist_le q
  omega

omit [Fintype α] [DecidableEq α] in
/-- Step 2. The support of a shortest walk is an induced path. -/
lemma isInducedPath_support_of_length_eq_dist {G : SimpleGraph α} {u v : α} (p : G.Walk u v)
    (hp : p.length = G.dist u v) : G.isInducedPath p.support := by
  refine ⟨(p.isPath_of_length_eq_dist hp).support_nodup, ?_⟩
  intro i j
  have hi : i.val ≤ p.length := by have := i.isLt; simp at this; omega
  have hj : j.val ≤ p.length := by have := j.isLt; simp at this; omega
  simp only [List.get_eq_getElem, Walk.support_getElem_eq_getVert]
  constructor
  · intro hadj
    rcases lt_trichotomy i.val j.val with h | h | h
    · by_contra hne
      exact geodesic_not_adj p hp (by omega) hj hadj
    · rw [h] at hadj
      exact (G.irrefl hadj).elim
    · by_contra hne
      exact geodesic_not_adj p hp (by omega) hi hadj.symm
  · rintro (h | h)
    · rw [← h]
      exact p.adj_getVert_succ (by omega)
    · rw [← h]
      exact (p.adj_getVert_succ (by omega)).symm

/-- Step 3. In a connected graph on at least two vertices, `rad + 1 ≤ path`. -/
theorem radius_toNat_add_one_le_path [Nontrivial α] (G : SimpleGraph α) (h : G.Connected) :
    G.radius.toNat + 1 ≤ path G := by
  obtain ⟨u⟩ : Nonempty α := inferInstance
  obtain ⟨v, hv⟩ := G.exists_edist_eq_eccent_of_finite u
  obtain ⟨p, hp⟩ := h.exists_walk_length_eq_dist u v
  have h1 : G.radius ≤ G.edist u v := hv ▸ G.radius_le_eccent
  have h2 : G.edist u v = (G.dist u v : ℕ∞) := (h.preconnected u v).coe_dist_eq_edist.symm
  have h3 : G.radius.toNat ≤ G.dist u v := by
    rw [h2] at h1
    exact (ENat.toNat_le_toNat h1 (ENat.natCast_ne_top _)).trans (by simp)
  have h4 := length_le_path_of_isInducedPath G p.support
    (isInducedPath_support_of_length_eq_dist p hp)
  rw [Walk.length_support] at h4
  omega

/-- Step 4. Conjecture 133 holds for every connected graph that contains a 4-cycle. -/
theorem conjecture133_of_hasC4 [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected)
    (hC4 : ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a) :
    let rad := G.radius.toNat
    let hasC4 := ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a
    let cC4 : ℕ := if hasC4 then 0 else 1
    (rad : ℝ) + l G ^ cC4 ≤ (path G : ℝ) := by
  intro rad hasC4 cC4
  have hc : cC4 = 0 := if_pos hC4
  rw [hc, pow_zero]
  exact_mod_cast radius_toNat_add_one_le_path G h

/-- Step 5. Reduction: Conjecture 133 for `G` follows from its `C4`-free case
`rad + l(G) ≤ path` (needed only when `G` has no 4-cycle). -/
theorem conjecture133_of_C4free_case [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected)
    (hfree : ¬ (∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a) →
      (G.radius.toNat : ℝ) + l G ≤ (path G : ℝ)) :
    let rad := G.radius.toNat
    let hasC4 := ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a
    let cC4 : ℕ := if hasC4 then 0 else 1
    (rad : ℝ) + l G ^ cC4 ≤ (path G : ℝ) := by
  intro rad hasC4 cC4
  by_cases hC4 : hasC4
  · exact conjecture133_of_hasC4 G h hC4
  · have hc : cC4 = 1 := if_neg hC4
    rw [hc, pow_one]
    exact hfree hC4

/-- Step 6. In a connected graph on at least two vertices, `diam + 1 ≤ path`
(a diametral shortest walk is an induced path). -/
theorem diam_add_one_le_path [Nontrivial α] (G : SimpleGraph α) (h : G.Connected) :
    G.diam + 1 ≤ path G := by
  obtain ⟨u, v, huv⟩ := G.exists_dist_eq_diam
  obtain ⟨p, hp⟩ := h.exists_walk_length_eq_dist u v
  have h4 := length_le_path_of_isInducedPath G p.support
    (isInducedPath_support_of_length_eq_dist p hp)
  rw [Walk.length_support] at h4
  omega

omit [DecidableEq α] in
/-- Step 7. `rad ≤ diam` for a connected graph. -/
theorem radius_toNat_le_diam [Nontrivial α] (G : SimpleGraph α) (h : G.Connected) :
    G.radius.toNat ≤ G.diam :=
  ENat.toNat_le_toNat G.radius_le_ediam (G.connected_iff_ediam_ne_top.mp h)

/-- Step 8. Sufficient condition: Conjecture 133 holds whenever
`l(G) ^ cC4 ≤ diam + 1 - rad`. This contains the `C4` case (left side `1`, right side `≥ 1`)
and, on paper, all trees (`l < 2`, `diam ≥ 2 rad - 1`). -/
theorem conjecture133_of_le_diam [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) :
    let rad := G.radius.toNat
    let hasC4 := ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a
    let cC4 : ℕ := if hasC4 then 0 else 1
    l G ^ cC4 ≤ (G.diam : ℝ) + 1 - (rad : ℝ) →
    (rad : ℝ) + l G ^ cC4 ≤ (path G : ℝ) := by
  intro rad hasC4 cC4 hle
  have hd : ((G.diam + 1 : ℕ) : ℝ) ≤ (path G : ℝ) := by
    exact_mod_cast diam_add_one_le_path G h
  push_cast at hd
  linarith

-- Radius one (a dominating vertex)

omit [Fintype α] [DecidableEq α] in
/-- Step 9. If the neighbourhood of `v` is a clique, then `l(v) ≤ 1`. -/
lemma indepNeighborsCard_le_one {G : SimpleGraph α} (v : α)
    (hv : ∀ x y, G.Adj v x → G.Adj v y → x ≠ y → G.Adj x y) : indepNeighborsCard G v ≤ 1 := by
  unfold indepNeighborsCard
  obtain ⟨s, hs⟩ := (G.induce (G.neighborSet v)).exists_isNIndepSet_indepNum
  rw [← hs.card_eq]
  apply Finset.card_le_one.mpr
  intro a ha b hb
  by_contra hab
  apply hs.isIndepSet ha hb hab
  exact hv a.1 b.1 a.2 b.2 (fun h => hab (Subtype.ext h))

/-- Step 10. `l(v) ≤ n - 1`. -/
lemma indepNeighborsCard_le_card_sub_one {G : SimpleGraph α} (v : α) :
    indepNeighborsCard G v ≤ Fintype.card α - 1 := by
  unfold indepNeighborsCard
  obtain ⟨s, hs⟩ := (G.induce (G.neighborSet v)).exists_isNIndepSet_indepNum
  rw [← hs.card_eq]
  have hsub : s.map (Function.Embedding.subtype _) ⊆ Finset.univ.erase v := by
    intro x hx
    obtain ⟨y, _, rfl⟩ := Finset.mem_map.mp hx
    refine Finset.mem_erase.mpr ⟨?_, Finset.mem_univ _⟩
    exact (G.ne_of_adj y.2).symm
  have := Finset.card_le_card hsub
  rw [Finset.card_map, Finset.card_erase_of_mem (Finset.mem_univ _), Finset.card_univ] at this
  exact this

/-- Step 11. Conjecture 133 holds for every connected graph with a vertex adjacent to all others
(equivalently, of radius 1). -/
theorem conjecture133_of_dominating [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (c : α) (hc : ∀ v, v ≠ c → G.Adj c v) :
    let rad := G.radius.toNat
    let hasC4 := ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a
    let cC4 : ℕ := if hasC4 then 0 else 1
    (rad : ℝ) + l G ^ cC4 ≤ (path G : ℝ) := by
  intro rad hasC4 cC4
  by_cases hC4 : hasC4
  · exact conjecture133_of_hasC4 G h hC4
  have hcC4 : cC4 = 1 := if_neg hC4
  rw [hcC4, pow_one]
  have hn : (0 : ℝ) < Fintype.card α := by exact_mod_cast Fintype.card_pos
  have hn2 : 1 < Fintype.card α := Fintype.one_lt_card_iff_nontrivial.mpr ‹_›
  -- the radius is at most 1
  have hrad : rad ≤ 1 := by
    have h1 : G.eccent c ≤ 1 := (G.eccent_le_one_iff c).mpr (fun v hv => hc v (Ne.symm hv))
    have h2 : G.radius ≤ 1 := G.radius_le_eccent.trans h1
    exact (ENat.toNat_le_toNat h2 (by simp)).trans (by simp)
  have hradR : (rad : ℝ) ≤ 1 := by exact_mod_cast hrad
  by_cases hcomp : ∀ a b, a ≠ b → G.Adj a b
  · -- complete graph: every neighbourhood is a clique, so `l ≤ 1`
    have hl : l G ≤ 1 := by
      have hsum : ∑ v ∈ Finset.univ, indepNeighbors G v ≤ ∑ _v ∈ (Finset.univ : Finset α), (1 : ℝ) := by
        apply Finset.sum_le_sum
        intro v _
        unfold indepNeighbors
        exact_mod_cast indepNeighborsCard_le_one v (fun x y _ _ hxy => hcomp x y hxy)
      simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at hsum
      show (∑ v ∈ Finset.univ, indepNeighbors G v) / (Fintype.card α : ℝ) ≤ 1
      rw [div_le_one hn]
      exact hsum
    have hp : ((rad + 1 : ℕ) : ℝ) ≤ (path G : ℝ) := by
      exact_mod_cast radius_toNat_add_one_le_path G h
    push_cast at hp
    linarith
  · -- not complete: `a - c - b` is an induced path, and `l < 2`
    push Not at hcomp
    obtain ⟨a, b, hab, hnadj⟩ := hcomp
    have hac : a ≠ c := fun hac => hnadj (hac ▸ hc b (fun hbc => hab (hac.trans hbc.symm)))
    have hbc : b ≠ c := fun hbc => hnadj (hbc ▸ (hc a (fun hac' => hab (hac'.trans hbc.symm))).symm)
    have hpath3 : 3 ≤ path G := by
      have hind : G.isInducedPath [a, c, b] := by
        have hnadj' : ¬ G.Adj b a := fun h => hnadj h.symm
        refine ⟨by simp [hab, hac, Ne.symm hbc], ?_⟩
        intro i j
        fin_cases i <;> fin_cases j <;>
          simp [hnadj, hnadj', (hc a hac).symm, hc b hbc, (hc b hbc).symm, hc a hac]
      simpa using length_le_path_of_isInducedPath G _ hind
    -- every `u ≠ c` has a clique neighbourhood (else a 4-cycle through `c`)
    have hu : ∀ u, u ≠ c → indepNeighborsCard G u ≤ 1 := by
      intro u huc
      apply indepNeighborsCard_le_one
      intro x y hux huy hxy
      by_cases hxc : x = c
      · subst hxc; exact hc y (fun hyc => hxy hyc.symm)
      by_cases hyc : y = c
      · subst hyc; exact (hc x hxc).symm
      exfalso
      apply hC4
      exact ⟨c, x, u, y, Ne.symm hxc, Ne.symm huc, Ne.symm hyc, G.ne_of_adj hux.symm,
        hxy, G.ne_of_adj huy, hc x hxc, hux.symm, huy, (hc y hyc).symm⟩
    have hl : l G < 2 := by
      have hsum : ∑ v ∈ Finset.univ, indepNeighbors G v ≤
          ((Fintype.card α : ℝ) - 1) + ((Fintype.card α : ℝ) - 1) := by
        rw [← Finset.add_sum_erase _ _ (Finset.mem_univ c)]
        apply add_le_add
        · unfold indepNeighbors
          have := indepNeighborsCard_le_card_sub_one (G := G) c
          have h1 : ((Fintype.card α - 1 : ℕ) : ℝ) = (Fintype.card α : ℝ) - 1 := by
            rw [Nat.cast_sub (by omega)]; simp
          rw [← h1]
          exact_mod_cast this
        · calc ∑ v ∈ Finset.univ.erase c, indepNeighbors G v
              ≤ ∑ _v ∈ Finset.univ.erase c, (1 : ℝ) := by
                apply Finset.sum_le_sum
                intro v hv
                unfold indepNeighbors
                exact_mod_cast hu v (Finset.ne_of_mem_erase hv)
            _ = (Fintype.card α : ℝ) - 1 := by
                simp [Finset.card_erase_of_mem (Finset.mem_univ c), Nat.cast_sub (by omega : 1 ≤ Fintype.card α)]
      show (∑ v ∈ Finset.univ, indepNeighbors G v) / (Fintype.card α : ℝ) < 2
      rw [div_lt_iff₀ hn]
      linarith
    have hp : (3 : ℝ) ≤ (path G : ℝ) := by exact_mod_cast hpath3
    linarith

end Wowii133Sweep
