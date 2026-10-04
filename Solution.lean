import FormalConjectures.Arxiv.«2605.02731».DeanCycles

/-! Solution for the dean3 target. See `TASK.md` and `NOTES.md`.

Only a partial result is proved: the longest-path fan lemma `DeanThree.dean_three_fan`.
The main theorem `dean_three` is still open here (see `NOTES.md`, "What is missing"). -/

namespace DeanThree

open SimpleGraph

set_option linter.unusedSectionVars false

variable {V : Type} [Fintype V] [DecidableEq V] {G : SimpleGraph V}

/-- A longest path exists in a nonempty finite graph. -/
lemma exists_longest_path [Nonempty V] :
    ∃ (a b : V) (p : G.Walk a b), p.IsPath ∧
      ∀ (x y : V) (q : G.Walk x y), q.IsPath → q.length ≤ p.length := by
  classical
  let P : ℕ → Prop := fun n => ∃ (a b : V) (p : G.Walk a b), p.IsPath ∧ p.length = n
  have h0 : P 0 := ⟨Classical.arbitrary V, _, Walk.nil, Walk.IsPath.nil, rfl⟩
  obtain ⟨a, b, p, hp, hlen⟩ := Nat.findGreatest_spec (Nat.zero_le (Fintype.card V)) h0
  refine ⟨a, b, p, hp, fun x y q hq => ?_⟩
  rw [hlen]
  exact Nat.le_findGreatest hq.length_lt.le ⟨x, y, q, hq, rfl⟩

/-- A neighbour of the first vertex of a longest path lies on the path. -/
lemma nbr_mem_support {a b : V} (p : G.Walk a b) (hp : p.IsPath)
    (hmax : ∀ (x y : V) (q : G.Walk x y), q.IsPath → q.length ≤ p.length)
    {w : V} (hw : G.Adj a w) : w ∈ p.support := by
  by_contra hns
  have := hmax w b (Walk.cons hw.symm p) (hp.cons hns)
  simp at this

/-- The fan cycle `a → v_j → … → v_i → a` of a path `p` starting at `a`. -/
lemma fan_cycle {a b : V} (p : G.Walk a b) (hp : p.IsPath) {i j : ℕ} (hi : 1 ≤ i) (hij : i < j)
    (hj : j ≤ p.length) (hai : G.Adj a (p.getVert i)) (haj : G.Adj a (p.getVert j)) :
    j - i + 2 ∈ G.cycleLengths := by
  have hinj := hp.getVert_injOn
  let q := (p.drop i).take (j - i)
  have hq : q.IsPath := (hp.drop i).take _
  have hqlen : q.length = j - i := by
    simp only [q, Walk.take_length, Walk.drop_length]; omega
  have hsupp : ∀ x ∈ q.support, ∃ m, i ≤ m ∧ m ≤ j ∧ p.getVert m = x := by
    intro x hx
    obtain ⟨k, hk, hkl⟩ := Walk.mem_support_iff_exists_getVert.mp hx
    refine ⟨i + min (j - i) k, by omega, by omega, ?_⟩
    rw [← hk]
    simp only [q, Walk.take_getVert, Walk.drop_getVert]
  have ha : a ∉ q.support := by
    intro hx
    obtain ⟨m, him, hmj, hm⟩ := hsupp a hx
    have : m = 0 := hinj (show m ≤ p.length by omega) (show 0 ≤ p.length by omega)
      (by rw [hm, Walk.getVert_zero])
    omega
  have he : (p.drop i).getVert (j - i) = p.getVert j := by
    rw [Walk.drop_getVert]; congr 1; omega
  have hne : p.getVert j ≠ p.getVert i := by
    intro h
    have : j = i := hinj (show j ≤ p.length by omega) (show i ≤ p.length by omega) h
    omega
  have haj' : G.Adj a ((p.drop i).getVert (j - i)) := he ▸ haj
  let R := Walk.cons hai q
  have hR : R.IsPath := hq.cons ha
  refine ⟨a, Walk.cons haj' R.reverse, ?_, ?_⟩
  · rw [Walk.cons_isCycle_iff]
    refine ⟨hR.reverse, ?_⟩
    rw [Walk.edges_reverse, List.mem_reverse]
    simp only [R, Walk.edges_cons, List.mem_cons]
    rintro (h | h)
    · rw [Sym2.eq_iff] at h
      rcases h with ⟨-, h⟩ | ⟨h, -⟩
      · exact hne (he ▸ h)
      · rw [← h] at hai; exact G.irrefl hai
    · exact ha (q.fst_mem_support_of_mem_edges h)
  · simp only [Walk.length_cons, Walk.length_reverse, R, hqlen]

/-- Partial result towards Chen–Saito: either there is a cycle of length divisible by 3, or a
longest path whose first vertex `a` has all its (at least 3) neighbours on the path at indices
`i` with `i % 3 ≠ 2`, and any two neighbour indices `i < j` satisfy `(j - i) % 3 ≠ 1`. -/
theorem dean_three_fan [DecidableRel G.Adj] (hG : 3 ≤ G.minDegree) :
    (∃ m ∈ G.cycleLengths, 3 ∣ m) ∨
    ∃ (a b : V) (p : G.Walk a b), p.IsPath ∧
      (∀ (x y : V) (q : G.Walk x y), q.IsPath → q.length ≤ p.length) ∧ 3 ≤ G.degree a ∧
      (∀ w, G.Adj a w → ∃ i, 1 ≤ i ∧ i ≤ p.length ∧ p.getVert i = w ∧ i % 3 ≠ 2) ∧
      (∀ i j, i < j → j ≤ p.length → G.Adj a (p.getVert i) → G.Adj a (p.getVert j) →
        (j - i) % 3 ≠ 1) := by
  have : Nonempty V := by
    by_contra hV
    rw [not_nonempty_iff] at hV
    have : Subsingleton V := ⟨fun x => isEmptyElim x⟩
    rw [minDegree_of_subsingleton] at hG
    omega
  by_cases hc : ∃ m ∈ G.cycleLengths, 3 ∣ m
  · exact Or.inl hc
  right
  have hc' : ∀ m ∈ G.cycleLengths, ¬ 3 ∣ m := fun m hm hd => hc ⟨m, hm, hd⟩
  obtain ⟨a, b, p, hp, hmax⟩ := exists_longest_path (G := G)
  have pos : ∀ i, G.Adj a (p.getVert i) → 1 ≤ i := by
    intro i hai
    rcases Nat.eq_zero_or_pos i with rfl | h
    · rw [Walk.getVert_zero] at hai; exact (G.irrefl hai).elim
    · exact h
  refine ⟨a, b, p, hp, hmax, hG.trans (G.minDegree_le_degree a), ?_, ?_⟩
  · intro w hw
    obtain ⟨i, hi, hil⟩ := Walk.mem_support_iff_exists_getVert.mp (nbr_mem_support p hp hmax hw)
    have hai : G.Adj a (p.getVert i) := by rw [hi]; exact hw
    refine ⟨i, pos i hai, hil, hi, fun hmod => ?_⟩
    have h2 : 1 < i := by omega
    have h01 : G.Adj a (p.getVert 1) := by
      have := p.adj_getVert_succ (i := 0) (by omega)
      rwa [Walk.getVert_zero] at this
    exact hc' _ (fan_cycle p hp le_rfl h2 hil h01 hai) (by omega)
  · intro i j hij hj hai haj hmod
    exact hc' _ (fan_cycle p hp (pos i hai) hij hj hai haj) (by omega)

end DeanThree

theorem dean_three : type_of% @Arxiv.«2605.02731».dean_conjecture.variants.three := by
  sorry
