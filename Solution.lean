import FormalConjectures.Arxiv.«2507.17780».«2»

/-! Solution for the txgraffiti2 target. See `TASK.md` and `NOTES.md`.

The counterexample is the graph H = G(K3) of M. Fischer, "A counterexample to the zero forcing
versus independence conjecture for cubic and subcubic graphs", arXiv 2607.23664: a connected
graph on 24 vertices with maximum degree 3, independence number 9 and zero forcing number 11.
The lower bound on the zero forcing number uses forts, as in that paper.

Labels (`data/txgraffiti2/H24.edgelist`): 0, 1, 2 are the triangle c_0, c_1, c_2; 3, 4, 5 are
r_0, r_1, r_2 with edges c_j r_j; copy k (k = 0..5) of K3 is z = 6 + 3k, a = 7 + 3k, b = 8 + 3k,
with z joined to r_(k / 2). Branch j is r_j with copies 2j and 2j + 1. -/

namespace TxGraffiti2

open SimpleGraph Finset Arxiv.«2507.17780»

/- ### Forts -/

/-- A fort: a nonempty set `F` such that no vertex outside `F` has exactly one neighbour in `F`. -/
abbrev IsFort {V : Type*} (G : SimpleGraph V) (F : Finset V) : Prop :=
  F.Nonempty ∧ ∀ v, v ∉ F → ∀ w ∈ F, G.Adj v w → ∃ u ∈ F, u ≠ w ∧ G.Adj v u

/-- A zero forcing step never enters a fort that the current set misses. -/
theorem step_misses_fort {V : Type*} [Fintype V] [DecidableEq V] (G : SimpleGraph V)
    [DecidableRel G.Adj] {F T : Finset V} (hF : IsFort G F) (hT : ∀ x ∈ F, x ∉ T) :
    ∀ x ∈ F, x ∉ zeroForcingStep G T := by
  intro x hx hxs
  simp only [zeroForcingStep, Finset.mem_union, Finset.mem_filter, Finset.mem_univ,
    true_and] at hxs
  rcases hxs with hxT | ⟨_, v, hvT, hvx, hv⟩
  · exact hT x hx hxT
  · have hvF : v ∉ F := fun h => hT v h hvT
    obtain ⟨u, huF, hux, hvu⟩ := hF.2 v hvF x hx hvx
    exact hux (hv u hvu (hT u huF))

/-- Fort lemma: a zero forcing set meets every fort. -/
theorem fort_meets {V : Type*} [Fintype V] [DecidableEq V] (G : SimpleGraph V)
    [DecidableRel G.Adj] {S F : Finset V} (hS : IsZeroForcingSet G S) (hF : IsFort G F) :
    ∃ x ∈ F, x ∈ S := by
  by_contra hmiss
  have h0 : ∀ x ∈ F, x ∉ S := fun x hx hxS => hmiss ⟨x, hx, hxS⟩
  have hiter : ∀ n : Nat, ∀ x ∈ F, x ∉ (zeroForcingStep G)^[n] S := by
    intro n
    induction n with
    | zero => exact h0
    | succ n ih =>
      rw [Function.iterate_succ_apply']
      exact step_misses_fort G hF ih
  obtain ⟨x, hx⟩ := hF.1
  have hcl : x ∈ zeroForcingClosure G S := by
    rw [hS]; exact Finset.mem_univ x
  exact hiter _ x hx hcl

/- ### The graph -/

/-- Neighbourhood bitmasks of the 24 vertices (from `data/txgraffiti2/H24.edgelist`). -/
def adjM : List Nat :=
  [14, 21, 35, 577, 36866, 2359300, 392, 320, 192, 3080, 2560, 1536, 24592, 20480, 12288,
   196624, 163840, 98304, 1572896, 1310720, 786432, 12582944, 10485760, 6291456]

/-- Adjacency as a `Bool` function on labels. -/
def adjB (i j : Nat) : Bool := (adjM.getD i 0).testBit j

theorem adjB_symm : ∀ i < 24, ∀ j < 24, adjB i j = adjB j i := by decide +kernel

theorem adjB_irrefl : ∀ i < 24, adjB i i = false := by decide +kernel

theorem adjB_lt {i j : Nat} (h : adjB i j = true) : j < 24 := by
  by_contra hj
  have hm : adjM.getD i 0 < 2 ^ 24 := by
    by_cases hi : i < 24
    · have : ∀ i < 24, adjM.getD i 0 < 2 ^ 24 := by decide +kernel
      exact this i hi
    · have hlen : adjM.length ≤ i := by simp [adjM]; omega
      rw [List.getD_eq_default adjM 0 hlen]
      positivity
  have hf : adjB i j = false :=
    Nat.testBit_eq_false_of_lt (lt_of_lt_of_le hm (Nat.pow_le_pow_right (by norm_num) (by omega)))
  rw [hf] at h
  exact Bool.false_ne_true h

/-- Fischer's graph H. -/
def H : SimpleGraph (Fin 24) where
  Adj i j := adjB i j = true
  symm := ⟨fun i j (h : adjB i j = true) => by
    show adjB j i = true
    rw [adjB_symm j j.isLt i i.isLt]
    exact h⟩
  loopless := ⟨fun i (h : adjB i i = true) => by
    rw [adjB_irrefl i i.isLt] at h
    exact Bool.false_ne_true h⟩

instance : DecidableRel H.Adj := fun i j => inferInstanceAs (Decidable (adjB i j = true))

/-- A parent with a smaller label for every vertex other than 0. -/
def par : List Nat := [0, 0, 0, 0, 1, 2, 3, 6, 6, 3, 9, 9, 4, 12, 12, 4, 15, 15, 5, 18, 18, 5, 21, 21]

theorem par_ok : ∀ n < 24, n ≠ 0 → par.getD n 0 < n ∧ adjB (par.getD n 0) n = true := by
  decide +kernel

theorem H_reach : ∀ n (h : n < 24), H.Reachable 0 ⟨n, h⟩ := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro h
    by_cases hn : n = 0
    · subst hn
      exact SimpleGraph.Reachable.refl _
    · obtain ⟨hlt, hadj⟩ := par_ok n h hn
      have hadj' : H.Adj ⟨par.getD n 0, by omega⟩ ⟨n, h⟩ := hadj
      exact (ih _ hlt (by omega)).trans hadj'.reachable

theorem H_connected : H.Connected :=
  (connected_iff_exists_forall_reachable (G := H)).mpr ⟨0, fun v => H_reach v.val v.isLt⟩

theorem deg_ok : ∀ v < 24, ((List.range 24).filter (adjB v ·)).length ≤ 3 := by decide +kernel

theorem H_degree (v : Fin 24) : H.degree v ≤ 3 := by
  rw [← card_neighborFinset_eq_degree]
  calc (H.neighborFinset v).card
      ≤ ((List.range 24).filter (adjB v ·)).toFinset.card := by
        apply Finset.card_le_card_of_injOn (fun w : Fin 24 => w.val)
        · intro w hw
          have hw' : adjB v w = true := (mem_neighborFinset H v w).mp hw
          simp [hw']
        · intro a _ b _ hab
          exact Fin.ext hab
    _ ≤ ((List.range 24).filter (adjB v ·)).length := List.toFinset_card_le _
    _ ≤ 3 := deg_ok v v.isLt

theorem H_maxDegree : H.maxDegree ≤ 3 := maxDegree_le_of_forall_degree_le H 3 H_degree

/-- A cover of the vertices by 9 cliques: the six copies of K3 and the three edges c_j r_j. -/
def col : List Nat := [6, 7, 8, 6, 7, 8, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5]

theorem col_ok : ∀ u < 24, ∀ v < 24, u ≠ v → col.getD u 0 = col.getD v 0 → adjB u v = true := by
  decide +kernel

theorem col_lt : ∀ u < 24, col.getD u 0 < 9 := by decide +kernel

theorem H_indepNum : H.indepNum ≤ 9 := by
  obtain ⟨s, hs⟩ := exists_isNIndepSet_indepNum (G := H)
  rw [← hs.card_eq]
  have : s.card ≤ (Finset.range 9).card := by
    apply Finset.card_le_card_of_injOn (fun v : Fin 24 => col.getD v 0)
    · intro v _
      exact Finset.mem_range.mpr (col_lt v v.isLt)
    · intro u hu v hv huv
      by_contra hne
      exact hs.isIndepSet hu hv hne
        (col_ok u u.isLt v v.isLt (fun h => hne (Fin.ext h)) huv)
  simpa using this

/- ### Forts of H, as label lists -/

/-- The vertex set of a label list. -/
def toFS (l : List Nat) : Finset (Fin 24) := Finset.univ.filter (fun y : Fin 24 => y.val ∈ l)

theorem mem_toFS {l : List Nat} {y : Fin 24} : y ∈ toFS l ↔ y.val ∈ l := by
  simp [toFS]

/-- `Bool` fort check on a label list. -/
def fortB (l : List Nat) : Bool :=
  l.any (· < 24) && (List.range 24).all fun v =>
    l.contains v || l.all fun w => !adjB v w || l.any fun u => u != w && adjB v u

theorem fortB_sound {l : List Nat} (h : fortB l = true) : IsFort H (toFS l) := by
  simp only [fortB, Bool.and_eq_true, List.any_eq_true, List.all_eq_true, List.mem_range,
    Bool.or_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨x, hx, hx24⟩, h2⟩ := h
  refine ⟨⟨⟨x, hx24⟩, mem_toFS.mpr hx⟩, ?_⟩
  intro v hv w hw hvw
  rw [mem_toFS] at hv hw
  have hvw' : adjB v w = true := hvw
  rcases h2 v v.isLt with h3 | h3
  · simp at h3
    exact absurd h3 hv
  · rcases h3 w hw with h4 | ⟨u, hu, h5⟩
    · simp [hvw'] at h4
    · simp only [bne_iff_ne, ne_eq] at h5
      refine ⟨⟨u, adjB_lt h5.2⟩, mem_toFS.mpr hu, fun heq => h5.1 ?_, h5.2⟩
      rw [← heq]

/-- `T` meets every list in `Fs`. -/
def hitsB (T : List Nat) (Fs : List (List Nat)) : Bool :=
  Fs.all fun F => F.any fun x => T.contains x

/-- Membership in `S` on labels. -/
def sb (S : Finset (Fin 24)) (n : Nat) : Bool :=
  if h : n < 24 then decide ((⟨n, h⟩ : Fin 24) ∈ S) else false

theorem sb_val (S : Finset (Fin 24)) (y : Fin 24) : sb S y.val = decide (y ∈ S) := by
  simp [sb]

theorem hits_of_zf {S : Finset (Fin 24)} (hS : IsZeroForcingSet H S) {F : List Nat}
    (hF : fortB F = true) : ∃ x ∈ F, sb S x = true := by
  obtain ⟨y, hy, hyS⟩ := fort_meets H hS (fortB_sound hF)
  exact ⟨y.val, mem_toFS.mp hy, by simp [sb_val, hyS]⟩

theorem branch_count {S : Finset (Fin 24)} (hS : IsZeroForcingSet H S) (B : List Nat)
    (loc E : List (List Nat)) (hfort : loc.all fortB = true)
    (hsub : (loc.all fun F => F.all B.contains) = true)
    (hlocal : ∀ T ∈ B.sublists, hitsB T loc = true → 3 + (hitsB T E).toNat ≤ T.length) :
    3 + (hitsB (B.filter (sb S)) E).toNat ≤ (B.filter (sb S)).length := by
  apply hlocal _ (List.mem_sublists.mpr List.filter_sublist)
  simp only [hitsB, List.all_eq_true, List.any_eq_true] at hfort hsub ⊢
  intro F hF
  obtain ⟨x, hx, hxS⟩ := hits_of_zf hS (hfort F hF)
  have hxB : x ∈ B := by simpa using hsub F hF x hx
  exact ⟨x, hx, by simpa [List.mem_filter] using ⟨hxB, hxS⟩⟩

theorem miss_E (S : Finset (Fin 24)) (B : List Nat) (E : List (List Nat))
    (hsub : (E.all fun F => F.all B.contains) = true) (h : hitsB (B.filter (sb S)) E = false) :
    ∃ e ∈ E, ∀ x ∈ e, sb S x = false := by
  by_contra hc
  have hh : hitsB (B.filter (sb S)) E = true := by
    simp only [hitsB, List.all_eq_true, List.any_eq_true] at hsub ⊢
    intro F hF
    have hx : ∃ x ∈ F, sb S x = true := by
      by_contra h'
      exact hc ⟨F, hF, fun x hx => by
        cases hb : sb S x
        · rfl
        · exact absurd ⟨x, hx, hb⟩ h'⟩
    obtain ⟨x, hx, hxS⟩ := hx
    have hxB : x ∈ B := by simpa using hsub F hF x hx
    exact ⟨x, hx, by simpa [List.mem_filter] using ⟨hxB, hxS⟩⟩
  rw [h] at hh
  exact Bool.false_ne_true hh

theorem pair {S : Finset (Fin 24)} (hS : IsZeroForcingSet H S) (ci cj : Nat)
    (Bi Bj : List Nat) (Ei Ej : List (List Nat))
    (hsi : (Ei.all fun F => F.all Bi.contains) = true)
    (hsj : (Ej.all fun F => F.all Bj.contains) = true)
    (hf : (Ei.all fun e => Ej.all fun e' => fortB (ci :: cj :: (e ++ e'))) = true) :
    sb S ci = true ∨ sb S cj = true ∨ hitsB (Bi.filter (sb S)) Ei = true ∨
      hitsB (Bj.filter (sb S)) Ej = true := by
  cases hA : hitsB (Bi.filter (sb S)) Ei
  · cases hB : hitsB (Bj.filter (sb S)) Ej
    · obtain ⟨e, he, he0⟩ := miss_E S Bi Ei hsi hA
      obtain ⟨e', he', he0'⟩ := miss_E S Bj Ej hsj hB
      simp only [List.all_eq_true] at hf
      obtain ⟨x, hx, hxS⟩ := hits_of_zf hS (hf e he e' he')
      simp only [List.mem_cons, List.mem_append] at hx
      rcases hx with rfl | rfl | hx | hx
      · exact Or.inl hxS
      · exact Or.inr (Or.inl hxS)
      · rw [he0 x hx] at hxS
        exact absurd hxS Bool.false_ne_true
      · rw [he0' x hx] at hxS
        exact absurd hxS Bool.false_ne_true
    · simp
  · simp

/- ### Branch data -/

/-- Branch 0: r_0 and copies 0, 1 of K3. -/
def B0 : List Nat := [3, 6, 7, 8, 9, 10, 11]

/-- The 12 forts inside branch 0. -/
def loc0 : List (List Nat) :=
  [[7, 8], [10, 11], [7, 8, 10, 11], [6, 7, 9, 10], [6, 7, 9, 11], [6, 7, 9, 10, 11], [6, 8, 9, 10], [6, 8, 9, 11], [6, 8, 9, 10, 11], [6, 7, 8, 9, 10], [6, 7, 8, 9, 11], [6, 7, 8, 9, 10, 11]]

/-- The E-sets of branch 0. -/
def E0 : List (List Nat) := [[6, 7], [6, 8], [9, 10], [9, 11]]

/-- Branch 1: r_1 and copies 2, 3 of K3. -/
def B1 : List Nat := [4, 12, 13, 14, 15, 16, 17]

/-- The 12 forts inside branch 1. -/
def loc1 : List (List Nat) :=
  [[13, 14], [16, 17], [13, 14, 16, 17], [12, 13, 15, 16], [12, 13, 15, 17], [12, 13, 15, 16, 17], [12, 14, 15, 16], [12, 14, 15, 17], [12, 14, 15, 16, 17], [12, 13, 14, 15, 16], [12, 13, 14, 15, 17], [12, 13, 14, 15, 16, 17]]

/-- The E-sets of branch 1. -/
def E1 : List (List Nat) := [[12, 13], [12, 14], [15, 16], [15, 17]]

/-- Branch 2: r_2 and copies 4, 5 of K3. -/
def B2 : List Nat := [5, 18, 19, 20, 21, 22, 23]

/-- The 12 forts inside branch 2. -/
def loc2 : List (List Nat) :=
  [[19, 20], [22, 23], [19, 20, 22, 23], [18, 19, 21, 22], [18, 19, 21, 23], [18, 19, 21, 22, 23], [18, 20, 21, 22], [18, 20, 21, 23], [18, 20, 21, 22, 23], [18, 19, 20, 21, 22], [18, 19, 20, 21, 23], [18, 19, 20, 21, 22, 23]]

/-- The E-sets of branch 2. -/
def E2 : List (List Nat) := [[18, 19], [18, 20], [21, 22], [21, 23]]


theorem loc0_ok : loc0.all fortB = true := by decide +kernel
theorem loc1_ok : loc1.all fortB = true := by decide +kernel
theorem loc2_ok : loc2.all fortB = true := by decide +kernel

theorem sub0 : (loc0.all fun F => F.all B0.contains) = true ∧
    (E0.all fun F => F.all B0.contains) = true := by decide +kernel
theorem sub1 : (loc1.all fun F => F.all B1.contains) = true ∧
    (E1.all fun F => F.all B1.contains) = true := by decide +kernel
theorem sub2 : (loc2.all fun F => F.all B2.contains) = true ∧
    (E2.all fun F => F.all B2.contains) = true := by decide +kernel

theorem local0 : ∀ T ∈ B0.sublists, hitsB T loc0 = true → 3 + (hitsB T E0).toNat ≤ T.length := by
  decide +kernel
theorem local1 : ∀ T ∈ B1.sublists, hitsB T loc1 = true → 3 + (hitsB T E1).toNat ≤ T.length := by
  decide +kernel
theorem local2 : ∀ T ∈ B2.sublists, hitsB T loc2 = true → 3 + (hitsB T E2).toNat ≤ T.length := by
  decide +kernel

theorem glob01 : (E0.all fun e => E1.all fun e' => fortB (0 :: 1 :: (e ++ e'))) = true := by
  decide +kernel
theorem glob02 : (E0.all fun e => E2.all fun e' => fortB (0 :: 2 :: (e ++ e'))) = true := by
  decide +kernel
theorem glob12 : (E1.all fun e => E2.all fun e' => fortB (1 :: 2 :: (e ++ e'))) = true := by
  decide +kernel

/- ### Counting -/

/-- All 24 labels, branch by branch and then the centre. -/
def Lall : List Nat := B0 ++ B1 ++ B2 ++ [0, 1, 2]

theorem Lall_nodup : Lall.Nodup := by decide +kernel
theorem Lall_lt : ∀ n ∈ Lall, n < 24 := by decide +kernel
theorem Lall_mem : ∀ n < 24, n ∈ Lall := by decide +kernel

theorem card_eq (S : Finset (Fin 24)) : S.card = (Lall.filter (sb S)).length := by
  rw [← List.toFinset_card_of_nodup (Lall_nodup.filter _), ← Finset.card_map Fin.valEmbedding]
  congr 1
  ext n
  simp only [Finset.mem_map, Fin.valEmbedding_apply, List.mem_toFinset, List.mem_filter]
  constructor
  · rintro ⟨y, hy, rfl⟩
    exact ⟨Lall_mem y y.isLt, by simp [sb_val, hy]⟩
  · rintro ⟨hn, hs⟩
    have h24 := Lall_lt n hn
    refine ⟨⟨n, h24⟩, ?_, rfl⟩
    simpa [sb, h24] using hs

theorem card_ge (S : Finset (Fin 24)) (hS : IsZeroForcingSet H S) : 11 ≤ S.card := by
  rw [card_eq]
  simp only [Lall, List.filter_append, List.length_append]
  have h0 := branch_count hS B0 loc0 E0 loc0_ok sub0.1 local0
  have h1 := branch_count hS B1 loc1 E1 loc1_ok sub1.1 local1
  have h2 := branch_count hS B2 loc2 E2 loc2_ok sub2.1 local2
  have p01 := pair hS 0 1 B0 B1 E0 E1 sub0.2 sub1.2 glob01
  have p02 := pair hS 0 2 B0 B2 E0 E2 sub0.2 sub2.2 glob02
  have p12 := pair hS 1 2 B1 B2 E1 E2 sub1.2 sub2.2 glob12
  have hc : ([0, 1, 2].filter (sb S)).length =
      (sb S 0).toNat + (sb S 1).toNat + (sb S 2).toNat := by
    simp only [List.filter_cons, List.filter_nil]
    cases sb S 0 <;> cases sb S 1 <;> cases sb S 2 <;> simp
  rw [hc]
  generalize hitsB (List.filter (sb S) B0) E0 = a0 at h0 p01 p02
  generalize hitsB (List.filter (sb S) B1) E1 = a1 at h1 p01 p12
  generalize hitsB (List.filter (sb S) B2) E2 = a2 at h2 p02 p12
  generalize sb S 0 = g0 at p01 p02 ⊢
  generalize sb S 1 = g1 at p01 p12 ⊢
  generalize sb S 2 = g2 at p02 p12 ⊢
  cases a0 <;> cases a1 <;> cases a2 <;> cases g0 <;> cases g1 <;> cases g2 <;>
    simp only [Bool.toNat_true, Bool.toNat_false, Bool.false_eq_true, or_false, or_true] at * <;> omega

theorem univ_zf : IsZeroForcingSet H Finset.univ := by
  unfold IsZeroForcingSet zeroForcingClosure
  apply Function.iterate_fixed
  simp [zeroForcingStep]

theorem H_zeroForcingNumber : 11 ≤ zeroForcingNumber H := by
  unfold zeroForcingNumber
  refine le_csInf ?_ ?_
  · exact ⟨(Finset.univ : Finset (Fin 24)).card, Finset.univ, rfl, univ_zf⟩
  · rintro k ⟨S, rfl, hS⟩
    exact card_ge S hS

end TxGraffiti2

open TxGraffiti2 in
theorem txgraffiti2_false : ¬ (type_of% @Arxiv.«2507.17780».tx_graffiti_conjecture_2) := by
  intro h
  have h1 := h (Fin 24) H H_connected H_maxDegree (fun _ => by simp)
  have h2 := H_zeroForcingNumber
  have h3 := H_indepNum
  omega
