import FormalConjectures.WrittenOnTheWallII.GraphConjecture198a

/-! Sweep work for wowii198a: the Case A reduction (non-self-centered graphs). -/

open SimpleGraph

namespace Sweep198a

variable {α : Type*} [Fintype α] [DecidableEq α] [Nontrivial α]

/-- Case A reduction. If `G` is not self-centered, the conclusion of conjecture 198a follows from
Lemma 1 (two non-adjacent vertices at equal distance from `u` give `b G ≥ ecc u + 2`) and
Lemma 3 (if every distance layer around `u` is a clique, `G` has a Hamiltonian path). -/
theorem caseA_of_lemmas (G : SimpleGraph α) (h : G.Connected)
    (hb : b G ≤ 2 + averageEccentricity G)
    (hnsc : ∃ v w : α, G.eccent v ≠ G.eccent w)
    (L1 : ∀ u x y : α, x ≠ y → ¬ G.Adj x y → G.dist u x = G.dist u y →
      ((G.eccent u).toNat : ℝ) + 2 ≤ b G)
    (L3 : ∀ u : α, (∀ x y : α, G.dist u x = G.dist u y → x ≠ y → G.Adj x y) →
      ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian) :
    ∃ a c : α, ∃ p : G.Walk a c, p.IsHamiltonian := by
  -- a peripheral vertex `u`, and `D` = diameter
  obtain ⟨u, hu⟩ := G.exists_eccent_eq_ediam_of_finite
  have hD : G.ediam ≠ ⊤ := connected_iff_ediam_ne_top.mp h
  -- every eccentricity is at most `D`
  have hle : ∀ v, (G.eccent v).toNat ≤ G.ediam.toNat := fun v =>
    ENat.toNat_le_toNat eccent_le_ediam hD
  -- some eccentricity is below `D`
  have hlt : ∃ v, (G.eccent v).toNat < G.ediam.toNat := by
    obtain ⟨v, w, hvw⟩ := hnsc
    have hne : G.eccent v ≠ G.ediam ∨ G.eccent w ≠ G.ediam := by
      by_contra hc
      push Not at hc
      exact hvw (hc.1.trans hc.2.symm)
    rcases hne with hne | hne
    · refine ⟨v, lt_of_le_of_ne (hle v) fun heq => hne ?_⟩
      have h1 : G.eccent v ≠ ⊤ := ne_top_of_le_ne_top hD eccent_le_ediam
      rw [← ENat.natCast_toNat h1, ← ENat.natCast_toNat hD, heq]
    · refine ⟨w, lt_of_le_of_ne (hle w) fun heq => hne ?_⟩
      have h1 : G.eccent w ≠ ⊤ := ne_top_of_le_ne_top hD eccent_le_ediam
      rw [← ENat.natCast_toNat h1, ← ENat.natCast_toNat hD, heq]
  -- so the average eccentricity is below `D`
  have hsum : (∑ v, (G.eccent v).toNat) < ∑ _v : α, G.ediam.toNat := by
    obtain ⟨v, hv⟩ := hlt
    exact Finset.sum_lt_sum (fun i _ => hle i) ⟨v, Finset.mem_univ v, hv⟩
  have hcard : (0 : ℝ) < Fintype.card α := by exact_mod_cast Fintype.card_pos
  have havg : averageEccentricity G < G.ediam.toNat := by
    unfold averageEccentricity
    rw [div_lt_iff₀ hcard]
    have : ((∑ v, (G.eccent v).toNat : ℕ) : ℝ) < ((∑ _v : α, G.ediam.toNat : ℕ) : ℝ) := by
      exact_mod_cast hsum
    simpa [Finset.sum_const, Finset.card_univ, mul_comm] using this
  -- every layer around `u` is a clique, else Lemma 1 contradicts the hypothesis
  refine L3 u fun x y hxy hne => ?_
  by_contra hadj
  have h1 := L1 u x y hne hadj hxy
  rw [hu] at h1
  linarith

end Sweep198a
