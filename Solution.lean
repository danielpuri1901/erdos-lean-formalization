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

end Wowii133Sweep
