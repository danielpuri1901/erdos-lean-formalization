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
  sorry

theorem good_symm {G : SimpleGraph V} {k l : Nat} {s : Finset V} (hg : Good G k l s) :
    Good Gᶜ l k s := by
  sorry

theorem good_two (G : SimpleGraph V) (l : Nat) (s : Finset V) (h : l ≤ #s) : Good G 2 l s := by
  sorry

theorem good_nbr {G : SimpleGraph V} [DecidableEq V] [DecidableRel G.Adj] {k l : Nat}
    {s : Finset V} {v : V} (hv : v ∈ s) (h : Good G k (l + 1) ((s.erase v).filter (G.Adj v))) :
    Good G (k + 1) (l + 1) s := by
  sorry

theorem good_non {G : SimpleGraph V} [DecidableEq V] [DecidableRel G.Adj] {k l : Nat}
    {s : Finset V} {v : V} (hv : v ∈ s)
    (h : Good G (k + 1) l ((s.erase v).filter (fun w => ¬ G.Adj v w))) :
    Good G (k + 1) (l + 1) s := by
  sorry

theorem card_split (G : SimpleGraph V) [DecidableEq V] [DecidableRel G.Adj] (s : Finset V)
    (v : V) (hv : v ∈ s) :
    #((s.erase v).filter (G.Adj v)) + #((s.erase v).filter (fun w => ¬ G.Adj v w)) + 1 = #s := by
  sorry

theorem good_step (G : SimpleGraph V) {k l a b : Nat} (ha : 0 < a)
    (h1 : ∀ s : Finset V, a ≤ #s → Good G k (l + 1) s)
    (h2 : ∀ s : Finset V, b ≤ #s → Good G (k + 1) l s)
    (s : Finset V) (hs : a + b ≤ #s) : Good G (k + 1) (l + 1) s := by
  sorry

theorem good_33 (G : SimpleGraph V) (s : Finset V) (hs : 6 ≤ #s) : Good G 3 3 s := by
  sorry

theorem parity (G : SimpleGraph V) [DecidableEq V] [DecidableRel G.Adj] (s : Finset V) :
    ∑ v ∈ s, (#((s.erase v).filter (G.Adj v)) : ZMod 2) = 0 := by
  sorry

theorem good_34 (G : SimpleGraph V) (s : Finset V) (hs : 9 ≤ #s) : Good G 3 4 s := by
  sorry

theorem good_44 (G : SimpleGraph V) (s : Finset V) (hs : 18 ≤ #s) : Good G 4 4 s := by
  sorry

theorem upper : RamseyNumbers.IsGraphRamsey 18 4 4 := by
  sorry

theorem lower : ¬ RamseyNumbers.IsGraphRamsey 17 4 4 := by
  sorry

end Ramsey44

theorem ramsey_4_4 : type_of% @RamseyNumbers.ramsey_number_four_four := by
  sorry
