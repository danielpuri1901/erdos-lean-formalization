import FormalConjectures.WrittenOnTheWallII.GraphConjecture133

/-!
# Sweep wowii133: special cases of Graffiti.pc 133

The conjecture says `rad + l(G) ^ cC4 ≤ path(G)`. Proved here, with complete proofs:

* `radius_toNat_add_one_le_path`, `diam_add_one_le_path`: a shortest walk has no chord, so its
  support is an induced path; hence `path ≥ diam + 1 ≥ rad + 1`.
* `conjecture133_of_hasC4`: the conjecture holds for every connected graph with a 4-cycle
  (the exponent is `0`), and `conjecture133_of_C4free_case` reduces it to its `C4`-free case.
* `conjecture133_of_le_diam`: it holds whenever `l(G) ^ cC4 ≤ diam + 1 - rad`.
* `conjecture133_of_dominating`: it holds for every graph with a vertex adjacent to all others
  (radius 1).
* `radius_toNat_add_two_le_path`: in a `C4`-free graph with a vertex having two non-adjacent
  neighbours, `path ≥ rad + 2`.
* `conjecture133_of_l_le_two`: it holds for every connected graph with `l(G) ≤ 2`.
* `add_two_le_path_of_minl`: `C4`-free and `l(v) ≥ k ≥ 2` for all `v` gives `path ≥ k + 2`;
  hence `conjecture133_of_minl` and `conjecture133_of_const_l` (radius `≤ 2`, constant `l`,
  e.g. every Moore graph of diameter 2).

The full conjecture is NOT proved here; the open part is `C4`-free graphs with `l(G) > 2`.
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

-- The case `l(G) ≤ 2`: a geodesic of length `ecc v ≥ rad` ending at a vertex `v` with two
-- non-adjacent neighbours extends by one vertex in a `C4`-free graph, so `path ≥ rad + 2`.

omit [Fintype α] [DecidableEq α] in
/-- Step 12. Prepending a vertex to an induced path. -/
lemma isInducedPath_cons {G : SimpleGraph α} {L : List α} {x y : α}
    (hL : G.isInducedPath (y :: L)) (hx : x ∉ y :: L) (hxy : G.Adj x y)
    (hxL : ∀ z ∈ L, ¬ G.Adj x z) : G.isInducedPath (x :: y :: L) := by
  refine ⟨List.nodup_cons.mpr ⟨hx, hL.1⟩, ?_⟩
  rintro ⟨i, hi⟩ ⟨j, hj⟩
  simp only [List.length_cons] at hi hj
  have key : ∀ k (hk : k < L.length), ¬ G.Adj x L[k] := fun k hk => hxL _ (List.getElem_mem hk)
  rcases i with _ | _ | i <;> rcases j with _ | _ | j
  · simp
  · simpa using hxy
  · simpa using key j (by omega)
  · simpa using hxy.symm
  · simp
  · have := hL.2 ⟨0, by simp⟩ ⟨j + 1, by simp; omega⟩; simpa using this
  · simpa [G.adj_comm] using key i (by omega)
  · have := hL.2 ⟨i + 1, by simp; omega⟩ ⟨0, by simp⟩; simpa using this
  · have := hL.2 ⟨i + 1, by simp; omega⟩ ⟨j + 1, by simp; omega⟩; simpa using this

omit [Fintype α] [DecidableEq α] in
/-- Step 13. In a shortest walk, any walk between vertex `i` and vertex `j ≥ i` has length
at least `j - i` (else splice it in and get a shorter walk). -/
lemma geodesic_shortcut {G : SimpleGraph α} {u v : α} (p : G.Walk u v)
    (hp : p.length = G.dist u v) {i j : ℕ} (hj : j ≤ p.length)
    (q : G.Walk (p.getVert i) (p.getVert j)) : j - i ≤ q.length := by
  let r : G.Walk u v := (p.take i).append (q.append (p.drop j))
  have hr : r.length = min i p.length + q.length + (p.length - j) := by
    simp only [r, Walk.length_append, Walk.take_length, Walk.drop_length]; omega
  have := G.dist_le r
  omega

/-- Step 14. `C4`-free graph, `v` with two distinct non-adjacent neighbours `a`, `b`:
then `path ≥ rad + 2`. Take a geodesic `v = p_0, p_1, …, p_e = u` with `e = ecc v ≥ rad`,
pick `x ∈ {a, b}` with `x ≠ p_1`, `x ≁ p_1` (both adjacent to `p_1` would give a `C4`),
and prepend `x`. `x ≁ p_2` (else `v x p_2 p_1` is a `C4`), `x ≁ p_k` for `k ≥ 3` (shortcut). -/
theorem radius_toNat_add_two_le_path [Nontrivial α] (G : SimpleGraph α) (h : G.Connected)
    (hC4 : ¬ ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a)
    (v a b : α) (hva : G.Adj v a) (hvb : G.Adj v b) (hab : a ≠ b) (hnab : ¬ G.Adj a b) :
    G.radius.toNat + 2 ≤ path G := by
  obtain ⟨u, hu⟩ := G.exists_edist_eq_eccent_of_finite v
  obtain ⟨p, hp⟩ := h.exists_walk_length_eq_dist v u
  have h1 : G.radius ≤ G.edist v u := hu ▸ G.radius_le_eccent
  have h2 : G.edist v u = (G.dist v u : ℕ∞) := (h.preconnected v u).coe_dist_eq_edist.symm
  have h3 : G.radius.toNat ≤ p.length := by
    rw [h2] at h1
    rw [hp]
    exact (ENat.toNat_le_toNat h1 (ENat.natCast_ne_top _)).trans (by simp)
  have hlen : 1 ≤ p.length := by
    by_contra hcon
    have h0 : p.length = 0 := by omega
    have hvu : v = u := p.eq_of_length_eq_zero h0
    have : G.eccent v = 0 := by rw [← hu, hvu, SimpleGraph.edist_self]
    exact G.eccent_ne_zero v this
  -- walks starting at `p.getVert 0` are walks starting at `v`
  have hv0 : p.getVert 0 = v := p.getVert_zero
  set p1 := p.getVert 1 with hp1
  have hvp1 : G.Adj v p1 := by
    have := p.adj_getVert_succ (i := 0) (by omega)
    rwa [hv0] at this
  -- choose `x`
  obtain ⟨x, hvx, hxp1, hnxp1⟩ : ∃ x, G.Adj v x ∧ x ≠ p1 ∧ ¬ G.Adj x p1 := by
    by_contra hcon
    push Not at hcon
    by_cases ha1 : a = p1
    · have := hcon b hvb (fun hb => hab (ha1.trans hb.symm))
      rw [← ha1] at this
      exact hnab this.symm
    by_cases hb1 : b = p1
    · have := hcon a hva ha1
      rw [← hb1] at this
      exact hnab this
    exact hC4 ⟨v, a, p1, b, G.ne_of_adj hva, G.ne_of_adj hvp1, G.ne_of_adj hvb, ha1, hab,
      Ne.symm hb1, hva, hcon a hva ha1, (hcon b hvb hb1).symm, hvb.symm⟩
  -- a walk `v → x → w` seen as a walk from `p.getVert 0`
  have hfar : ∀ n, n ≤ p.length → G.Adj x (p.getVert n) → n ≤ 2 := by
    intro n hn hxz
    have := geodesic_shortcut p hp hn
      ((Walk.cons hvx (Walk.cons hxz Walk.nil)).copy hv0.symm rfl)
    simpa using this
  have hsupp := p.cons_tail_support.symm
  have hnodup := (p.isPath_of_length_eq_dist hp).support_nodup
  have hind := isInducedPath_support_of_length_eq_dist p hp
  rw [hsupp] at hnodup hind
  have hx : x ∉ v :: p.support.tail := by
    rw [← hsupp]
    intro hmem
    obtain ⟨n, hn, hnl⟩ := Walk.mem_support_iff_exists_getVert.mp hmem
    rcases n with _ | _ | n
    · rw [hv0] at hn; exact G.ne_of_adj hvx hn
    · exact hxp1 hn.symm
    · have := geodesic_not_adj p hp (i := 0) (j := n + 2) (by omega) hnl
      rw [hv0, hn] at this
      exact this hvx
  have hxL : ∀ z ∈ p.support.tail, ¬ G.Adj x z := by
    intro z hz hxz
    have hz' : z ∈ p.support := by rw [hsupp]; exact List.mem_cons_of_mem _ hz
    obtain ⟨n, hn, hnl⟩ := Walk.mem_support_iff_exists_getVert.mp hz'
    rcases n with _ | _ | _ | n
    · rw [hv0] at hn
      exact (List.nodup_cons.mp hnodup).1 (hn ▸ hz)
    · have hn' : p.getVert 1 = z := hn
      rw [← hn'] at hxz
      exact hnxp1 hxz
    · -- `v x p_2 p_1` is a 4-cycle
      have hp12 : G.Adj p1 (p.getVert 2) := p.adj_getVert_succ (i := 1) (by omega)
      have hvp2 : v ≠ p.getVert 2 := by
        intro hcon
        have := geodesic_shortcut p hp (i := 0) (j := 2) hnl (Walk.nil.copy rfl (hv0.trans hcon))
        simp at this
      have hxp2 : x ≠ p.getVert 2 := by
        intro hcon
        have := geodesic_not_adj p hp (i := 0) (j := 2) (by omega) hnl
        rw [hv0, ← hcon] at this
        exact this hvx
      rw [← hn] at hxz
      exact hC4 ⟨v, x, p.getVert 2, p1, G.ne_of_adj hvx, hvp2, G.ne_of_adj hvp1, hxp2, hxp1,
        (G.ne_of_adj hp12).symm, hvx, hxz, hp12.symm, hvp1.symm⟩
    · have := hfar (n + 3) hnl (hn ▸ hxz)
      omega
  have hpath := isInducedPath_cons hind hx hvx.symm hxL
  have h4 := length_le_path_of_isInducedPath G _ hpath
  have hl : (p.support.tail).length = p.length := by
    have := p.length_support
    rw [hsupp] at this
    simpa using this
  simp only [List.length_cons, hl] at h4
  omega

omit [DecidableEq α] in
/-- Step 15. In a complete graph every neighbourhood is a clique, so `l(G) ≤ 1`. -/
lemma l_le_one_of_complete [Nonempty α] (G : SimpleGraph α)
    (hcomp : ∀ a b, a ≠ b → G.Adj a b) : l G ≤ 1 := by
  have hn : (0 : ℝ) < Fintype.card α := by exact_mod_cast Fintype.card_pos
  have hsum : ∑ v ∈ Finset.univ, indepNeighbors G v ≤ ∑ _v ∈ (Finset.univ : Finset α), (1 : ℝ) := by
    apply Finset.sum_le_sum
    intro v _
    unfold indepNeighbors
    exact_mod_cast indepNeighborsCard_le_one v (fun x y _ _ hxy => hcomp x y hxy)
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at hsum
  show (∑ v ∈ Finset.univ, indepNeighbors G v) / (Fintype.card α : ℝ) ≤ 1
  rw [div_le_one hn]
  exact hsum

/-- Step 16. Conjecture 133 holds for every connected graph with `l(G) ≤ 2`
(for example every tree, every cycle, every graph with at most as many edges as vertices,
every graph in which each neighbourhood has independence number at most 2). -/
theorem conjecture133_of_l_le_two [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (hl : l G ≤ 2) :
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
  by_cases hcomp : ∀ a b, a ≠ b → G.Adj a b
  · have hl1 := l_le_one_of_complete G hcomp
    have hp : ((rad + 1 : ℕ) : ℝ) ≤ (path G : ℝ) := by
      exact_mod_cast radius_toNat_add_one_le_path G h
    push_cast at hp
    linarith
  · push Not at hcomp
    obtain ⟨a, b, hab, hnadj⟩ := hcomp
    -- the first three vertices of a shortest `a`-`b` walk: `q_1` has non-adjacent neighbours
    obtain ⟨q, hq⟩ := h.exists_walk_length_eq_dist a b
    have hq2 : 2 ≤ q.length := by
      have h0 : q.length ≠ 0 := fun h0 => hab (q.eq_of_length_eq_zero h0)
      have h1 : q.length ≠ 1 := by
        intro h1
        apply hnadj
        have := q.adj_getVert_succ (i := 0) (by omega)
        have hb : q.getVert 1 = b := by rw [← h1]; exact q.getVert_length
        rwa [hb, Walk.getVert_zero] at this
      omega
    have hA : G.Adj (q.getVert 1) (q.getVert 0) := (q.adj_getVert_succ (i := 0) (by omega)).symm
    have hB : G.Adj (q.getVert 1) (q.getVert 2) := q.adj_getVert_succ (i := 1) (by omega)
    have hne : q.getVert 0 ≠ q.getVert 2 := by
      intro hcon
      have := geodesic_shortcut q hq (i := 0) (j := 2) hq2 (Walk.nil.copy rfl hcon)
      simp at this
    have hnA : ¬ G.Adj (q.getVert 0) (q.getVert 2) := geodesic_not_adj q hq (by omega) hq2
    have hp := radius_toNat_add_two_le_path G h hC4 _ _ _ hA hB hne hnA
    have hpR : ((rad + 2 : ℕ) : ℝ) ≤ (path G : ℝ) := by exact_mod_cast hp
    push_cast at hpR
    linarith

-- Greedy induced paths from a pointwise lower bound on `l`.

/-- `C4`-free in the "two common neighbours" form. -/
def C4free' (G : SimpleGraph α) : Prop :=
  ∀ a b c d : α, a ≠ b → c ≠ d → G.Adj a c → G.Adj c b → G.Adj a d → G.Adj d b → False

omit [Fintype α] [DecidableEq α] in
/-- Key counting step of the greedy: the neighbourhood of the head `x` of an induced path
`x :: y :: y₂ :: L₂` that cannot be extended has `l(x) ≤ |L₂| + 1`. -/
lemma indepNeighborsCard_le_of_cover {G : SimpleGraph α} (hC4 : C4free' G)
    (x y y₂ : α) (L₂ : List α) (hnd : (x :: y :: y₂ :: L₂).Nodup) (hxy : G.Adj x y)
    (hyy₂ : G.Adj y y₂) (hxy₂ : ¬ G.Adj x y₂) (hfar : ∀ z ∈ L₂, ¬ G.Adj x z)
    (hcover : ∀ w, G.Adj x w → w = y ∨ G.Adj w y ∨ w = y₂ ∨ G.Adj w y₂ ∨
      ∃ z ∈ L₂, w = z ∨ G.Adj w z) :
    indepNeighborsCard G x ≤ L₂.length + 1 := by
  classical
  unfold indepNeighborsCard
  obtain ⟨s, hs⟩ := (G.induce (G.neighborSet x)).exists_isNIndepSet_indepNum
  rw [← hs.card_eq]
  have hxne : ∀ z ∈ L₂, x ≠ z := by
    intro z hz hxz; subst hxz; simp at hnd; tauto
  have hy₂x : x ≠ y₂ := by intro h; subst h; simp at hnd
  -- every neighbour outside the `y`-branch is covered by `L₂`
  have hbranch : ∀ w, G.Adj x w → ¬ (w = y ∨ G.Adj w y) → ∃ z ∈ L₂, w = z ∨ G.Adj w z := by
    intro w hxw hny
    rcases hcover w hxw with h | h | h | h | h
    · exact absurd (Or.inl h) hny
    · exact absurd (Or.inr h) hny
    · exact absurd (h ▸ hxw) hxy₂
    · exfalso
      exact hC4 x y₂ w y (hy₂x) (fun hwy => hny (Or.inl hwy)) hxw h hxy hyy₂
    · exact h
  let f : ↥(G.neighborSet x) → α := fun w =>
    if (w.1 = y ∨ G.Adj w.1 y) then y else
      if h : ∃ z ∈ L₂, w.1 = z ∨ G.Adj w.1 z then h.choose else y
  have hmaps : ∀ w ∈ s, f w ∈ insert y L₂.toFinset := by
    intro w _
    simp only [f]
    split_ifs with h1 h2
    · simp
    · exact Finset.mem_insert_of_mem (List.mem_toFinset.mpr h2.choose_spec.1)
    · simp
  have hinj : Set.InjOn f s := by
    intro a ha b hb hab
    by_contra hne
    have hind : ¬ G.Adj a.1 b.1 := hs.isIndepSet ha hb hne
    have hne' : a.1 ≠ b.1 := fun h => hne (Subtype.ext h)
    have hxa : G.Adj x a.1 := a.2
    have hxb : G.Adj x b.1 := b.2
    simp only [f] at hab
    by_cases ha1 : (a.1 = y ∨ G.Adj a.1 y) <;> by_cases hb1 : (b.1 = y ∨ G.Adj b.1 y)
    · rcases ha1 with ha1 | ha1 <;> rcases hb1 with hb1 | hb1
      · exact hne' (ha1.trans hb1.symm)
      · exact hind (ha1 ▸ hb1.symm)
      · exact hind (hb1 ▸ ha1)
      · exact hC4 x y a.1 b.1 (G.ne_of_adj hxy) hne' hxa ha1 hxb hb1
    · obtain ⟨z, hz, hbz⟩ := hbranch b.1 hxb hb1
      have hex : ∃ z ∈ L₂, b.1 = z ∨ G.Adj b.1 z := ⟨z, hz, hbz⟩
      rw [if_pos ha1, if_neg hb1, dif_pos hex] at hab
      have := hex.choose_spec.1
      rw [← hab] at this
      simp at hnd; tauto
    · obtain ⟨z, hz, haz⟩ := hbranch a.1 hxa ha1
      have hex : ∃ z ∈ L₂, a.1 = z ∨ G.Adj a.1 z := ⟨z, hz, haz⟩
      rw [if_neg ha1, if_pos hb1, dif_pos hex] at hab
      have := hex.choose_spec.1
      rw [hab] at this
      simp at hnd; tauto
    · have hexa : ∃ z ∈ L₂, a.1 = z ∨ G.Adj a.1 z := hbranch a.1 hxa ha1
      have hexb : ∃ z ∈ L₂, b.1 = z ∨ G.Adj b.1 z := hbranch b.1 hxb hb1
      rw [if_neg ha1, if_neg hb1, dif_pos hexa, dif_pos hexb] at hab
      obtain ⟨hza, hza'⟩ := hexa.choose_spec
      obtain ⟨hzb, hzb'⟩ := hexb.choose_spec
      rw [hab] at hza hza'
      set z := hexb.choose
      have haz : G.Adj a.1 z := by
        rcases hza' with h | h
        · exact absurd (h ▸ hxa) (hfar z hzb)
        · exact h
      have hbz : G.Adj b.1 z := by
        rcases hzb' with h | h
        · exact absurd (h ▸ hxb) (hfar z hzb)
        · exact h
      exact hC4 x z a.1 b.1 (hxne z hzb) hne' hxa haz hxb hbz
  calc s.card ≤ (insert y L₂.toFinset).card := Finset.card_le_card_of_injOn f hmaps hinj
    _ ≤ L₂.toFinset.card + 1 := Finset.card_insert_le _ _
    _ ≤ L₂.length + 1 := by have := List.toFinset_card_le L₂; omega

/-- Greedy induced path: in a `C4`-free graph with `l(v) ≥ k ≥ 2` for every `v`,
`path ≥ k + 2`. Prepend a neighbour of the head while possible; when stuck, the counting lemma
gives `l(head) ≤ length - 2`. -/
theorem add_two_le_path_of_minl [Nonempty α] (G : SimpleGraph α) (hC4 : C4free' G) (k : ℕ)
    (hk : 2 ≤ k) (hl : ∀ v, k ≤ indepNeighborsCard G v) : k + 2 ≤ path G := by
  classical
  suffices H : ∀ m, 1 ≤ m → m ≤ k + 2 → ∃ L : List α, G.isInducedPath L ∧ L.length = m by
    obtain ⟨L, hL, hlen⟩ := H (k + 2) (by omega) le_rfl
    have := length_le_path_of_isInducedPath G L hL
    omega
  intro m hm1
  induction m, hm1 using Nat.le_induction with
  | base =>
    intro _
    obtain ⟨v⟩ := ‹Nonempty α›
    refine ⟨[v], ⟨List.nodup_singleton v, fun i j => ?_⟩, rfl⟩
    fin_cases i; fin_cases j; simp
  | succ m hm ih =>
    intro hmk
    obtain ⟨L, hL, hlen⟩ := ih (by omega)
    match L, hL, hlen with
    | [], _, hlen => simp at hlen; omega
    | [x], hL, hlen =>
      have : ∃ y, G.Adj x y := by
        by_contra hcon
        push Not at hcon
        have := indepNeighborsCard_le_one (G := G) x (fun a b hxa _ _ => absurd hxa (hcon a))
        have := hl x
        omega
      obtain ⟨y, hxy⟩ := this
      refine ⟨[y, x], ?_, by simp at hlen ⊢; omega⟩
      exact isInducedPath_cons (L := []) hL (by simp; exact (G.ne_of_adj hxy).symm) hxy.symm
        (by simp)
    | x :: y :: rest, hL, hlen =>
      have hxy : G.Adj x y := by
        have := hL.2 ⟨0, by simp⟩ ⟨1, by simp⟩; simpa using this
      obtain ⟨w, hw, hwx, hwz⟩ : ∃ w, w ∉ x :: y :: rest ∧ G.Adj w x ∧
          ∀ z ∈ y :: rest, ¬ G.Adj w z := by
        by_contra hcon
        push Not at hcon
        have hxw_ne : ∀ w, G.Adj x w → w ≠ x := fun w h => (G.ne_of_adj h).symm
        match rest, hL, hlen, hcon with
        | [], hL, hlen, hcon =>
          have : indepNeighborsCard G x ≤ 1 := by
            apply indepNeighborsCard_le_one
            have hny : ∀ w, G.Adj x w → w = y ∨ G.Adj w y := by
              intro w hxw
              by_cases hmem : w ∈ [x, y]
              · simp at hmem
                rcases hmem with h | h
                · exact absurd h (hxw_ne w hxw)
                · exact Or.inl h
              · obtain ⟨z, hz, hwz⟩ := hcon w hmem hxw.symm
                simp at hz; subst hz; exact Or.inr hwz
            intro a b hxa hxb hab
            rcases hny a hxa with ha | ha <;> rcases hny b hxb with hb | hb
            · exact absurd (ha.trans hb.symm) hab
            · exact ha ▸ hb.symm
            · exact hb ▸ ha
            · exact (hC4 x y a b (G.ne_of_adj hxy) hab hxa ha hxb hb).elim
          have := hl x
          omega
        | y₂ :: L₂, hL, hlen, hcon =>
          have hyy₂ : G.Adj y y₂ := by
            have := hL.2 ⟨1, by simp⟩ ⟨2, by simp⟩; simpa using this
          have hxy₂ : ¬ G.Adj x y₂ := by
            have := hL.2 ⟨0, by simp⟩ ⟨2, by simp⟩; simpa using this
          have hfar : ∀ z ∈ L₂, ¬ G.Adj x z := by
            intro z hz
            obtain ⟨j, hj, rfl⟩ := List.mem_iff_getElem.mp hz
            have := hL.2 ⟨0, by simp⟩ ⟨j + 3, by simp; omega⟩
            simpa using this
          have hcov : ∀ w, G.Adj x w → w = y ∨ G.Adj w y ∨ w = y₂ ∨ G.Adj w y₂ ∨
              ∃ z ∈ L₂, w = z ∨ G.Adj w z := by
            intro w hxw
            by_cases hmem : w ∈ x :: y :: y₂ :: L₂
            · simp at hmem
              rcases hmem with h | h | h | h
              · exact absurd h (hxw_ne w hxw)
              · exact Or.inl h
              · exact Or.inr (Or.inr (Or.inl h))
              · exact Or.inr (Or.inr (Or.inr (Or.inr ⟨w, h, Or.inl rfl⟩)))
            · obtain ⟨z, hz, hwz⟩ := hcon w hmem hxw.symm
              simp at hz
              rcases hz with h | h | h
              · subst h; exact Or.inr (Or.inl hwz)
              · subst h; exact Or.inr (Or.inr (Or.inr (Or.inl hwz)))
              · exact Or.inr (Or.inr (Or.inr (Or.inr ⟨z, h, Or.inr hwz⟩)))
          have := indepNeighborsCard_le_of_cover hC4 x y y₂ L₂ hL.1 hxy hyy₂ hxy₂ hfar hcov
          have := hl x
          simp at hlen
          omega
      refine ⟨w :: x :: y :: rest, isInducedPath_cons hL hw hwx hwz, ?_⟩
      simp at hlen ⊢; omega


/-- Step 19. Conjecture 133 holds for a connected graph in which every vertex has `l(v) ≥ k ≥ 2`
and `rad + l(G) ≤ k + 2`. -/
theorem conjecture133_of_minl [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (k : ℕ) (hk : 2 ≤ k) (hl : ∀ v, k ≤ indepNeighborsCard G v)
    (hle : (G.radius.toNat : ℝ) + l G ≤ k + 2) :
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
  have hfree : C4free' G := by
    intro a b c d hab hcd hac hcb had hdb
    exact hC4 ⟨a, c, b, d, G.ne_of_adj hac, hab, G.ne_of_adj had, G.ne_of_adj hcb, hcd,
      (G.ne_of_adj hdb).symm, hac, hcb, hdb.symm, had.symm⟩
  have hp : ((k + 2 : ℕ) : ℝ) ≤ (path G : ℝ) := by
    exact_mod_cast add_two_le_path_of_minl G hfree k hk hl
  push_cast at hp
  linarith

/-- Step 20. Conjecture 133 holds for every connected graph of radius at most 2 in which every
neighbourhood has the same independence number `k ≥ 2`. This covers every Moore graph of
diameter 2 (`C5`, Petersen, Hoffman–Singleton, and a 57-regular one if it exists), where
`l(v) = deg v = k` because the girth is 5. -/
theorem conjecture133_of_const_l [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (k : ℕ) (hk : 2 ≤ k) (hl : ∀ v, indepNeighborsCard G v = k)
    (hrad : G.radius.toNat ≤ 2) :
    let rad := G.radius.toNat
    let hasC4 := ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a
    let cC4 : ℕ := if hasC4 then 0 else 1
    (rad : ℝ) + l G ^ cC4 ≤ (path G : ℝ) := by
  have hn : (0 : ℝ) < Fintype.card α := by exact_mod_cast Fintype.card_pos
  have hlG : l G = k := by
    show (∑ v ∈ Finset.univ, indepNeighbors G v) / (Fintype.card α : ℝ) = k
    simp only [indepNeighbors, hl, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    field_simp
  apply conjecture133_of_minl G h k hk (fun v => (hl v).ge)
  rw [hlG]
  have : (G.radius.toNat : ℝ) ≤ 2 := by exact_mod_cast hrad
  linarith


-- Fidelity checks: the statements above are literally the statement of the imported
-- `conjecture133` (its type is used via `type_of%`; its proof is not used).

theorem fidelity_hasC4 [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj] (h : G.Connected)
    (hC4 : ∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
      G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a) :
    type_of% (WrittenOnTheWallII.GraphConjecture133.conjecture133 G h) :=
  conjecture133_of_hasC4 G h hC4

theorem fidelity_l_le_two [Nontrivial α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (h : G.Connected) (hl : l G ≤ 2) :
    type_of% (WrittenOnTheWallII.GraphConjecture133.conjecture133 G h) :=
  conjecture133_of_l_le_two G h hl

/-- The full conjecture follows from its `C4`-free case. -/
theorem fidelity_reduction [Nontrivial α]
    (hfree : ∀ (G : SimpleGraph α) [DecidableRel G.Adj], G.Connected →
      ¬ (∃ a b c d : α, a ≠ b ∧ a ≠ c ∧ a ≠ d ∧ b ≠ c ∧ b ≠ d ∧ c ≠ d ∧
        G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a) →
        (G.radius.toNat : ℝ) + l G ≤ (path G : ℝ))
    (G : SimpleGraph α) [DecidableRel G.Adj] (h : G.Connected) :
    type_of% (WrittenOnTheWallII.GraphConjecture133.conjecture133 G h) :=
  conjecture133_of_C4free_case G h (hfree G h)

end Wowii133Sweep
