import FormalConjectures.Arxiv.«2507.17780».«3»
import Solution.TxTop

/-! Solution for the txgraffiti3 target: TxGraffiti conjecture 3 is false. See `TASK.md`.

The counterexample is the connected cubic graph on 48 vertices from the public repository
https://github.com/ipitchford/txgraffiti-order48-successor (file `counterexample.edgelist`);
credit for finding the graph belongs to its authors. Its independent domination number is 16
and it has a maximal matching with 15 edges, so `i(G) ≤ μ*(G)` fails.

* `G` is defined from the table of closed-neighbourhood masks `Tx.cmT` (`Solution/TxDefs.lean`).
* `μ*(G) ≤ 15`: the edges `{2i, 2i+1}` (`i < 15`) form a maximal matching.
* `i(G) ≥ 16`: `Tx.P15` (`Solution/TxTop.lean`), a branch-and-bound certificate checked by the
  kernel in chunks, with the checker proved sound in `Solution/TxSound.lean`. -/

namespace Tx

/-- The 48-vertex cubic counterexample. -/
def G : SimpleGraph (Fin 48) where
  Adj a b := bit (cmT a.val) b.val = true ∧ a ≠ b
  symm := ⟨fun a b h => ⟨(cm_symm a.val a.isLt b.val b.isLt) ▸ h.1, h.2.symm⟩⟩
  loopless := ⟨fun _ h => h.2 rfl⟩

instance : DecidableRel G.Adj := fun a b =>
  inferInstanceAs (Decidable (bit (cmT a.val) b.val = true ∧ a ≠ b))

theorem G_deg : ∀ v, G.degree v = 3 := by decide +kernel

/-- Every edge has an endpoint below 30. -/
theorem G_low : ∀ a b : Fin 48, G.Adj a b → a.val < 30 ∨ b.val < 30 := by decide +kernel

theorem G_pairs : ∀ i : Fin 15, G.Adj ⟨2 * i.val, by omega⟩ ⟨2 * i.val + 1, by omega⟩ := by
  decide +kernel

/-- The matching `{2i, 2i+1}` for `i < 15`. -/
def mEdge (i : Fin 15) : Sym2 (Fin 48) := s(⟨2 * i.val, by omega⟩, ⟨2 * i.val + 1, by omega⟩)

def M : Finset (Sym2 (Fin 48)) := Finset.univ.image mEdge

theorem mem_mEdge (v : Fin 48) (i : Fin 15) : v ∈ mEdge i ↔ v.val / 2 = i.val := by
  unfold mEdge
  rw [Sym2.mem_iff, Fin.ext_iff, Fin.ext_iff]
  simp only
  omega

theorem mEdge_inj : Function.Injective mEdge := by
  intro i j h
  have hv : (⟨2 * i.val, by omega⟩ : Fin 48) ∈ mEdge j := by
    rw [← h, mem_mEdge]
    simp only
    omega
  rw [mem_mEdge] at hv
  simp only at hv
  exact Fin.ext (by omega)

theorem M_card : M.card = 15 := by
  unfold M
  rw [Finset.card_image_of_injective _ mEdge_inj]
  rfl

theorem M_max : G.IsMaximalEdgeMatching M := by
  have hmatch : ∀ e₁ ∈ M, ∀ e₂ ∈ M, e₁ = e₂ ∨ ∀ v : Fin 48, ¬ (v ∈ e₁ ∧ v ∈ e₂) := by
    intro e₁ h₁ e₂ h₂
    obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp h₁
    obtain ⟨j, -, rfl⟩ := Finset.mem_image.mp h₂
    by_cases hij : i = j
    · exact Or.inl (by rw [hij])
    · right
      intro v ⟨hv₁, hv₂⟩
      rw [mem_mEdge] at hv₁ hv₂
      exact hij (Fin.ext (by omega))
  refine ⟨⟨?_, hmatch⟩, ?_⟩
  · intro e he
    obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp he
    exact G_pairs i
  · intro e he heM hins
    induction e using Sym2.ind with
    | h a b =>
    rw [SimpleGraph.mem_edgeSet] at he
    have hc : ∃ c : Fin 48, c ∈ s(a, b) ∧ c.val < 30 := by
      rcases G_low a b he with h | h
      · exact ⟨a, Sym2.mem_mk_left a b, h⟩
      · exact ⟨b, Sym2.mem_mk_right a b, h⟩
    obtain ⟨c, hcab, hc30⟩ := hc
    have hcM : mEdge ⟨c.val / 2, by omega⟩ ∈ M := Finset.mem_image_of_mem _ (Finset.mem_univ _)
    rcases hins.2 s(a, b) (Finset.mem_insert_self _ _) (mEdge ⟨c.val / 2, by omega⟩)
      (Finset.mem_insert_of_mem hcM) with h | h
    · exact heM (h ▸ hcM)
    · exact h c ⟨hcab, (mem_mEdge c _).mpr rfl⟩

theorem G_sat : G.saturationNumber ≤ 15 :=
  Nat.sInf_le ⟨M, M_max, M_card⟩

/-- An independent dominating set with 16 vertices, so the set in `indepDominationNumber`
is nonempty. -/
def D16 : Finset (Fin 48) := {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 34}

theorem D16_indep : ∀ a ∈ D16, ∀ b ∈ D16, ¬ G.Adj a b := by decide +kernel

theorem D16_dom : ∀ v : Fin 48, v ∈ D16 ∨ ∃ w ∈ D16, G.Adj v w := by decide +kernel

theorem D16_ids : G.IsNIndepDominatingSet 16 D16 where
  isIndep := fun a ha b hb _ => D16_indep a ha b hb
  isDominating := fun v => by
    rcases D16_dom v with h | ⟨w, hw, h⟩
    · exact Or.inl h
    · exact Or.inr ⟨w, hw, h⟩
  card_eq := by decide +kernel

theorem G_ind : 16 ≤ G.indepDominationNumber := by
  have hne : ({n | ∃ D : Finset (Fin 48), G.IsNIndepDominatingSet n D} : Set Nat).Nonempty :=
    ⟨16, D16, D16_ids⟩
  obtain ⟨D, hD⟩ : ∃ D : Finset (Fin 48), G.IsNIndepDominatingSet G.indepDominationNumber D :=
    Nat.sInf_mem hne
  by_contra hlt
  apply P15 (D.map Fin.valEmbedding)
  · intro t ht
    obtain ⟨v, -, rfl⟩ := Finset.mem_map.mp ht
    exact v.isLt
  · rw [Finset.card_map, hD.card_eq]
    omega
  · intro a ha b hb hab
    obtain ⟨a', ha', rfl⟩ := Finset.mem_map.mp ha
    obtain ⟨b', hb', rfl⟩ := Finset.mem_map.mp hb
    by_contra hne
    have hne' : a' ≠ b' := fun h => hne (by rw [h])
    exact hD.isIndep ha' hb' hne' ⟨hab, hne'⟩
  · intro t _
    exact ⟨bit_zero t, bit_zero t⟩
  · intro v hv
    right
    rcases hD.isDominating ⟨v, hv⟩ with h | ⟨w, hw, h⟩
    · exact ⟨v, Finset.mem_map.mpr ⟨⟨v, hv⟩, h, rfl⟩, cm_self v hv⟩
    · refine ⟨w.val, Finset.mem_map.mpr ⟨w, hw, rfl⟩, ?_⟩
      rw [cm_symm w.val w.isLt v hv]
      exact h.1

end Tx

theorem txgraffiti3_false : ¬ (type_of% @Arxiv.«2507.17780».tx_graffiti_conjecture_3) := by
  intro h
  have h1 := h (Fin 48) Tx.G 3 Tx.G_deg (by norm_num)
  have h2 := Tx.G_sat
  have h3 := Tx.G_ind
  omega
