import FormalConjectures.Arxiv.«2507.17780».«2»

/-!
# Sweep txgraffiti2: partial results

* `Txg2.zf_le_card`, `Txg2.bound_of_certificate`: a forcing set `S` and an independent set
  `I` with `#S ≤ #I + 1` prove `Z(G) ≤ α(G) + 1` for that graph.
* `Txg2.zf_le_card_sub_one`: every connected graph on `n ≥ 2` vertices has `Z(G) ≤ n - 1`.
* `Txg2.bound_of_card_le_indepNum_add_two`: the conjectured bound holds (with no degree
  hypothesis) whenever `n ≤ α(G) + 2`.
* `Txg2.K4_violates`: `K4` is connected, has maximum degree `3`, and `α(K4) + 1 < Z(K4)`,
  so the hypothesis excluding `K4` cannot be dropped.
* `Txg2.prism_tight`: the triangular prism meets all hypotheses and has `Z = α + 1 = 3`,
  so the bound is attained by a cubic graph other than `K4`.
-/

open SimpleGraph Arxiv.«2507.17780»

namespace Txg2

section General

variable {V : Type} [Fintype V] [DecidableEq V] (G : SimpleGraph V) [DecidableRel G.Adj]

/-- A zero forcing set bounds the zero forcing number. -/
theorem zf_le_card {S : Finset V} (hS : IsZeroForcingSet G S) : zeroForcingNumber G ≤ S.card :=
  Nat.sInf_le ⟨S, rfl, hS⟩

/-- Certificate form: a forcing set at most one larger than an independent set. -/
theorem bound_of_certificate {S I : Finset V} (hS : IsZeroForcingSet G S)
    (hI : G.IsIndepSet (I : Set V)) (h : S.card ≤ I.card + 1) :
    zeroForcingNumber G ≤ G.indepNum + 1 :=
  (zf_le_card G hS).trans (h.trans (Nat.add_le_add_right hI.card_le_indepNum 1))

theorem subset_step (S : Finset V) : S ⊆ zeroForcingStep G S :=
  Finset.subset_union_left

theorem step_univ : zeroForcingStep G Finset.univ = Finset.univ :=
  Finset.eq_univ_of_forall fun x => subset_step G _ (Finset.mem_univ x)

theorem iterate_univ (k : ℕ) : (zeroForcingStep G)^[k] Finset.univ = Finset.univ :=
  Function.iterate_fixed (step_univ G) k

/-- `univ` is a zero forcing set. -/
theorem univ_forcing : IsZeroForcingSet G Finset.univ :=
  iterate_univ G _

/-- The colour-change step is monotone. -/
theorem step_mono : Monotone (zeroForcingStep G) := by
  intro S T h x hx
  unfold zeroForcingStep at hx ⊢
  rcases Finset.mem_union.mp hx with hx | hx
  · exact Finset.mem_union_left _ (h hx)
  · by_cases hxT : x ∈ T
    · exact Finset.mem_union_left _ hxT
    · obtain ⟨-, -, v, hvS, hvx, hu⟩ := Finset.mem_filter.mp hx
      exact Finset.mem_union_right _ (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hxT, v, h hvS, hvx,
        fun u hvu huT => hu u hvu fun huS => huT (h huS)⟩)

/-- The zero forcing closure is monotone. -/
theorem closure_mono {S T : Finset V} (h : S ⊆ T) :
    zeroForcingClosure G S ⊆ zeroForcingClosure G T :=
  (step_mono G).iterate _ h

/-- If `v` is adjacent to `w`, then all vertices but `w` force `w` in one step. -/
theorem step_erase {v w : V} (hvw : G.Adj v w) :
    zeroForcingStep G (Finset.univ.erase w) = Finset.univ := by
  apply Finset.eq_univ_of_forall
  intro x
  by_cases hx : x = w
  · subst hx
    unfold zeroForcingStep
    refine Finset.mem_union_right _ ?_
    rw [Finset.mem_filter]
    refine ⟨Finset.mem_univ _, Finset.notMem_erase _ _, v,
      Finset.mem_erase.mpr ⟨G.ne_of_adj hvw, Finset.mem_univ _⟩, hvw, fun u _ hu => ?_⟩
    by_contra hne
    exact hu (Finset.mem_erase.mpr ⟨hne, Finset.mem_univ _⟩)
  · exact subset_step G _ (Finset.mem_erase.mpr ⟨hx, Finset.mem_univ _⟩)

/-- All vertices but one vertex with a neighbour form a zero forcing set. -/
theorem erase_forcing {v w : V} (hvw : G.Adj v w) : IsZeroForcingSet G (Finset.univ.erase w) := by
  unfold IsZeroForcingSet zeroForcingClosure
  have hpos : Fintype.card V ≠ 0 := (Fintype.card_pos_iff.mpr ⟨w⟩).ne'
  obtain ⟨k, hk⟩ := Nat.exists_eq_succ_of_ne_zero hpos
  rw [hk, Function.iterate_succ_apply, step_erase G hvw, iterate_univ]

omit [DecidableEq V] [DecidableRel G.Adj] in
/-- A connected graph on at least two vertices has an edge. -/
theorem exists_adj (hconn : G.Connected) (h2 : 2 ≤ Fintype.card V) : ∃ v w, G.Adj v w := by
  obtain ⟨a, b, hab⟩ := Fintype.exists_pair_of_one_lt_card h2
  obtain ⟨p⟩ := hconn.preconnected a b
  cases p with
  | nil => exact absurd rfl hab
  | cons h _ => exact ⟨_, _, h⟩

/-- Every connected graph on `n ≥ 2` vertices has `Z(G) ≤ n - 1`. -/
theorem zf_le_card_sub_one (hconn : G.Connected) (h2 : 2 ≤ Fintype.card V) :
    zeroForcingNumber G ≤ Fintype.card V - 1 := by
  obtain ⟨v, w, hvw⟩ := exists_adj G hconn h2
  have := zf_le_card G (erase_forcing G hvw)
  rwa [Finset.card_erase_of_mem (Finset.mem_univ w), Finset.card_univ] at this

/-- Special case of the conjecture: it holds for every connected graph (no degree bound)
with `n ≤ α(G) + 2`. -/
theorem bound_of_card_le_indepNum_add_two (hconn : G.Connected)
    (h : Fintype.card V ≤ G.indepNum + 2) : zeroForcingNumber G ≤ G.indepNum + 1 := by
  by_cases h2 : 2 ≤ Fintype.card V
  · have := zf_le_card_sub_one G hconn h2
    omega
  · have h1 := zf_le_card G (univ_forcing G)
    rw [Finset.card_univ] at h1
    omega

end General

section K4

/-- In `K4` every zero forcing set has at least three vertices. -/
theorem K4_forcing_card :
    ∀ S : Finset (Fin 4),
      zeroForcingClosure (⊤ : SimpleGraph (Fin 4)) S = Finset.univ → 3 ≤ S.card := by
  decide +kernel

/-- In `K4` every independent set has at most one vertex. -/
theorem K4_indep_card :
    ∀ s : Finset (Fin 4), (⊤ : SimpleGraph (Fin 4)).IsIndepSet (s : Set (Fin 4)) → s.card ≤ 1 := by
  decide +kernel

theorem K4_zf : 3 ≤ zeroForcingNumber (⊤ : SimpleGraph (Fin 4)) :=
  le_csInf ⟨4, Finset.univ, rfl, univ_forcing _⟩ fun _ ⟨S, hS, hf⟩ => hS ▸ K4_forcing_card S hf

theorem K4_indepNum : (⊤ : SimpleGraph (Fin 4)).indepNum ≤ 1 := by
  obtain ⟨s, hs⟩ := (⊤ : SimpleGraph (Fin 4)).exists_isNIndepSet_indepNum
  rw [← hs.card_eq]
  exact K4_indep_card s hs.isIndepSet

/-- `K4` satisfies every hypothesis of the conjecture except the exclusion of `K4`, and
violates its conclusion: the exclusion is necessary. -/
theorem K4_violates :
    (⊤ : SimpleGraph (Fin 4)).Connected ∧ (⊤ : SimpleGraph (Fin 4)).maxDegree ≤ 3 ∧
      (⊤ : SimpleGraph (Fin 4)).indepNum + 1 < zeroForcingNumber (⊤ : SimpleGraph (Fin 4)) := by
  refine ⟨connected_top, ?_, ?_⟩
  · exact maxDegree_le_of_forall_degree_le _ 3 (by decide)
  · have := K4_zf
    have := K4_indepNum
    omega

end K4

section Prism

/-- Edges of the triangular prism `K3 □ K2`: two triangles joined by a matching. -/
def prismEdges : List (Fin 6 × Fin 6) :=
  [(0, 1), (1, 2), (2, 0), (3, 4), (4, 5), (5, 3), (0, 3), (1, 4), (2, 5)]

/-- Adjacency of the prism. -/
def prismAdj (a b : Fin 6) : Prop := (a, b) ∈ prismEdges ∨ (b, a) ∈ prismEdges

instance : DecidableRel prismAdj := fun _ _ => instDecidableOr

/-- The triangular prism, a connected cubic graph other than `K4`. -/
def prism : SimpleGraph (Fin 6) where
  Adj := prismAdj
  symm := ⟨fun _ _ h => Or.symm h⟩
  loopless := ⟨by decide⟩

instance : DecidableRel prism.Adj := inferInstanceAs (DecidableRel prismAdj)

theorem prism_connected : prism.Connected := by
  have adj : ∀ a b : Fin 6, prism.Adj a b → prism.Reachable a b := fun _ _ h => h.reachable
  have r1 : prism.Reachable 0 1 := adj _ _ (by decide)
  have r2 : prism.Reachable 0 2 := adj _ _ (by decide)
  have r3 : prism.Reachable 0 3 := adj _ _ (by decide)
  have r4 : prism.Reachable 0 4 := r1.trans (adj _ _ (by decide))
  have r5 : prism.Reachable 0 5 := r2.trans (adj _ _ (by decide))
  have h : ∀ v, prism.Reachable 0 v := by
    intro v
    fin_cases v <;> first | exact Reachable.refl _ | assumption
  exact (SimpleGraph.connected_iff_exists_forall_reachable (G := prism)).mpr ⟨0, h⟩

theorem prism_maxDegree : prism.maxDegree ≤ 3 :=
  maxDegree_le_of_forall_degree_le _ 3 (by decide)

/-- Every zero forcing set of the prism has at least three vertices. -/
theorem prism_forcing_card :
    ∀ S : Finset (Fin 6), zeroForcingClosure prism S = Finset.univ → 3 ≤ S.card := by
  decide +kernel

/-- Every independent set of the prism has at most two vertices. -/
theorem prism_indep_card :
    ∀ s : Finset (Fin 6), prism.IsIndepSet (s : Set (Fin 6)) → s.card ≤ 2 := by
  decide +kernel

theorem prism_zf : zeroForcingNumber prism = 3 := by
  apply le_antisymm
  · have h : IsZeroForcingSet prism {0, 1, 3} := by
      unfold IsZeroForcingSet; decide +kernel
    exact zf_le_card prism h
  · exact le_csInf ⟨6, Finset.univ, rfl, univ_forcing _⟩
      fun _ ⟨S, hS, hf⟩ => hS ▸ prism_forcing_card S hf

theorem prism_indepNum : prism.indepNum = 2 := by
  apply le_antisymm
  · obtain ⟨s, hs⟩ := prism.exists_isNIndepSet_indepNum
    rw [← hs.card_eq]
    exact prism_indep_card s hs.isIndepSet
  · have h : prism.IsIndepSet (({0, 4} : Finset (Fin 6)) : Set (Fin 6)) := by
      decide +kernel
    exact h.card_le_indepNum

/-- The prism satisfies all hypotheses of the conjecture and attains the bound `Z = α + 1`,
so the `+ 1` cannot be dropped, even for cubic graphs other than `K4`. -/
theorem prism_tight :
    prism.Connected ∧ prism.maxDegree ≤ 3 ∧ (prism = ⊤ → Fintype.card (Fin 6) ≠ 4) ∧
      zeroForcingNumber prism = prism.indepNum + 1 := by
  refine ⟨prism_connected, prism_maxDegree, fun _ => by decide, ?_⟩
  rw [prism_zf, prism_indepNum]

end Prism

end Txg2

