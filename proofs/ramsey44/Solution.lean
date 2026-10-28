import Solution.Paley

/-! Solution for the ramsey44 target. See `TASK.md` and `NOTES.md`. -/

namespace Ramsey44

open SimpleGraph Finset

variable {V : Type*}

/-- Inside `s`, `G` has a `k`-clique or an independent set of size `l`. -/
def Good (G : SimpleGraph V) (k l : Nat) (s : Finset V) : Prop :=
  (∃ t ⊆ s, G.IsNClique k t) ∨ (∃ t ⊆ s, Gᶜ.IsNClique l t)

theorem good_mono {G : SimpleGraph V} {k l : Nat} {s s' : Finset V} (h : s ⊆ s')
    (hg : Good G k l s) : Good G k l s' := by
  rcases hg with ⟨t, ht, hc⟩ | ⟨t, ht, hc⟩
  · exact Or.inl ⟨t, ht.trans h, hc⟩
  · exact Or.inr ⟨t, ht.trans h, hc⟩

theorem good_symm {G : SimpleGraph V} {k l : Nat} {s : Finset V} (hg : Good G k l s) :
    Good Gᶜ l k s := by
  rcases hg with ⟨t, ht, hc⟩ | ⟨t, ht, hc⟩
  · exact Or.inr ⟨t, ht, by rw [compl_compl]; exact hc⟩
  · exact Or.inl ⟨t, ht, hc⟩

theorem good_two (G : SimpleGraph V) (l : Nat) (s : Finset V) (h : l ≤ #s) : Good G 2 l s := by
  classical
  obtain ⟨t, hts, htc⟩ := exists_subset_card_eq h
  by_cases hadj : ∃ x ∈ t, ∃ y ∈ t, G.Adj x y
  · obtain ⟨x, hx, y, hy, hxy⟩ := hadj
    refine Or.inl ⟨{x, y}, ?_, ?_⟩
    · intro z hz
      rcases mem_insert.mp hz with rfl | hz
      · exact hts hx
      · rw [mem_singleton.mp hz]; exact hts hy
    · rw [isNClique_iff, coe_pair, isClique_pair, card_pair hxy.ne]
      exact ⟨fun _ => hxy, rfl⟩
  · push Not at hadj
    refine Or.inr ⟨t, hts, ⟨?_, htc⟩⟩
    intro x hx y hy hne
    exact (compl_adj G x y).mpr ⟨hne, hadj x hx y hy⟩

theorem good_nbr {G : SimpleGraph V} [DecidableEq V] [DecidableRel G.Adj] {k l : Nat}
    {s : Finset V} {v : V} (hv : v ∈ s) (h : Good G k (l + 1) ((s.erase v).filter (G.Adj v))) :
    Good G (k + 1) (l + 1) s := by
  have hsub : (s.erase v).filter (G.Adj v) ⊆ s := (filter_subset _ _).trans (erase_subset _ _)
  rcases h with ⟨t, ht, hc⟩ | ⟨t, ht, hc⟩
  · exact Or.inl ⟨insert v t, insert_subset hv (ht.trans hsub),
      hc.insert fun b hb => (mem_filter.mp (ht hb)).2⟩
  · exact Or.inr ⟨t, ht.trans hsub, hc⟩

theorem good_non {G : SimpleGraph V} [DecidableEq V] [DecidableRel G.Adj] {k l : Nat}
    {s : Finset V} {v : V} (hv : v ∈ s)
    (h : Good G (k + 1) l ((s.erase v).filter (fun w => ¬ G.Adj v w))) :
    Good G (k + 1) (l + 1) s := by
  have hsub : (s.erase v).filter (fun w => ¬ G.Adj v w) ⊆ s :=
    (filter_subset _ _).trans (erase_subset _ _)
  rcases h with ⟨t, ht, hc⟩ | ⟨t, ht, hc⟩
  · exact Or.inl ⟨t, ht.trans hsub, hc⟩
  · refine Or.inr ⟨insert v t, insert_subset hv (ht.trans hsub), hc.insert fun b hb => ?_⟩
    have hb' := mem_filter.mp (ht hb)
    exact (compl_adj G v b).mpr ⟨fun e => (mem_erase.mp hb'.1).1 e.symm, hb'.2⟩

theorem card_split (G : SimpleGraph V) [DecidableEq V] [DecidableRel G.Adj] (s : Finset V)
    (v : V) (hv : v ∈ s) :
    #((s.erase v).filter (G.Adj v)) + #((s.erase v).filter (fun w => ¬ G.Adj v w)) + 1 = #s := by
  rw [card_filter_add_card_filter_not, card_erase_of_mem hv]
  have := card_pos.mpr ⟨v, hv⟩
  omega

theorem good_step (G : SimpleGraph V) {k l a b : Nat} (ha : 0 < a)
    (h1 : ∀ s : Finset V, a ≤ #s → Good G k (l + 1) s)
    (h2 : ∀ s : Finset V, b ≤ #s → Good G (k + 1) l s)
    (s : Finset V) (hs : a + b ≤ #s) : Good G (k + 1) (l + 1) s := by
  classical
  obtain ⟨v, hv⟩ : s.Nonempty := card_pos.mp (by omega)
  have hsplit := card_split G s v hv
  by_cases hN : a ≤ #((s.erase v).filter (G.Adj v))
  · exact good_nbr hv (h1 _ hN)
  · exact good_non hv (h2 _ (by omega))

theorem good_33 (G : SimpleGraph V) (s : Finset V) (hs : 6 ≤ #s) : Good G 3 3 s :=
  good_step G (k := 2) (l := 2) (a := 3) (b := 3) (by norm_num)
    (fun s hs => good_two G 3 s hs)
    (fun s hs => by have := good_symm (good_two Gᶜ 3 s hs); rwa [compl_compl] at this) s hs

theorem parity (G : SimpleGraph V) [DecidableEq V] [DecidableRel G.Adj] (s : Finset V) :
    ∑ v ∈ s, (#((s.erase v).filter (G.Adj v)) : ZMod 2) = 0 := by
  have e : ∀ v ∈ s, (s.erase v).filter (G.Adj v) = s.filter (G.Adj v) := by
    intro v _
    rw [filter_erase]
    exact erase_eq_of_notMem (by simp)
  rw [sum_congr rfl (fun v hv => by rw [e v hv])]
  simp_rw [natCast_card_filter]
  rw [← sum_product' (f := fun v w => if G.Adj v w then (1 : ZMod 2) else 0)]
  refine sum_involution (fun p _ => p.swap) ?_ ?_ ?_ ?_
  · intro p _
    have : G.Adj p.1 p.2 ↔ G.Adj p.2 p.1 := ⟨fun h => h.symm, fun h => h.symm⟩
    simp only [Prod.fst_swap, Prod.snd_swap]
    by_cases h : G.Adj p.1 p.2
    · rw [if_pos h, if_pos (this.mp h)]; decide
    · rw [if_neg h, if_neg (fun h' => h (this.mpr h'))]; simp
  · intro p _ hne heq
    have h : G.Adj p.1 p.2 := by by_contra h; exact hne (if_neg h)
    have : p.1 = p.2 := by
      have := congrArg Prod.fst heq
      simpa using this.symm
    exact G.irrefl (this ▸ h)
  · intro p hp
    simp only [mem_product] at hp ⊢
    exact ⟨hp.2, hp.1⟩
  · intro p _
    exact Prod.swap_swap p

theorem good_34 (G : SimpleGraph V) (s : Finset V) (hs : 9 ≤ #s) : Good G 3 4 s := by
  classical
  by_contra hbad
  obtain ⟨u, hus, huc⟩ := exists_subset_card_eq hs
  have hbad' : ¬ Good G 3 4 u := fun h => hbad (good_mono hus h)
  have hdeg : ∀ v ∈ u, #((u.erase v).filter (G.Adj v)) = 3 := by
    intro v hv
    have hsplit := card_split G u v hv
    have h1 : ¬ 4 ≤ #((u.erase v).filter (G.Adj v)) := fun h =>
      hbad' (good_nbr (k := 2) (l := 3) hv (good_two G 4 _ h))
    have h2 : ¬ 6 ≤ #((u.erase v).filter (fun w => ¬ G.Adj v w)) := fun h =>
      hbad' (good_non (k := 2) (l := 3) hv (good_33 G _ h))
    omega
  have hp := parity G u
  rw [sum_congr rfl (fun v hv => by rw [hdeg v hv]), sum_const, huc] at hp
  revert hp
  decide

theorem good_44 (G : SimpleGraph V) (s : Finset V) (hs : 18 ≤ #s) : Good G 4 4 s :=
  good_step G (k := 3) (l := 3) (a := 9) (b := 9) (by norm_num)
    (fun s hs => good_34 G s hs)
    (fun s hs => by have := good_symm (good_34 Gᶜ s hs); rwa [compl_compl] at this) s hs

theorem upper : RamseyNumbers.IsGraphRamsey 18 4 4 := by
  intro G ⟨h1, h2⟩
  rcases good_44 G Finset.univ (by simp) with ⟨t, -, ht⟩ | ⟨t, -, ht⟩
  · exact h1 t ht
  · exact h2 t ht

theorem lower : ¬ RamseyNumbers.IsGraphRamsey 17 4 4 :=
  fun h => h paley ⟨paley_cliqueFree, paley_compl_cliqueFree⟩

end Ramsey44

theorem ramsey_4_4 : type_of% @RamseyNumbers.ramsey_number_four_four := by
  show SimpleGraph.classicalRamsey 4 4 = 18
  rw [RamseyNumbers.classicalRamsey_eq_sInf]
  have mono : ∀ d n, RamseyNumbers.IsGraphRamsey n 4 4 →
      RamseyNumbers.IsGraphRamsey (n + d) 4 4 := by
    intro d
    induction d with
    | zero => intro n h; exact h
    | succ d ih => intro n h; exact RamseyNumbers.IsGraphRamsey.succ _ _ _ (ih n h)
  apply le_antisymm (Nat.sInf_le Ramsey44.upper)
  apply le_csInf ⟨18, Ramsey44.upper⟩
  intro n hn
  by_contra hlt
  have := mono (17 - n) n hn
  rw [show n + (17 - n) = 17 by omega] at this
  exact Ramsey44.lower this
