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

end Txg2
