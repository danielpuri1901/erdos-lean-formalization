import Solution.Gap

/-!
# Strategy certificates for the gap-form Catch-Up evaluator

`gvL` is a structurally recursive list copy of `gv` (`gv_eq_gvL`).  A pair of certificates
(`chkGe`, `chkLe`) shows that a position is a draw without evaluating the whole game tree.
-/

namespace CatchUpDeep

open CatchUp

/-- Structurally recursive list copy of `gv`, with fuel `n` (the length of the list). -/
def gvL : ℕ → List ℕ → ℕ → Outcome
  | 0, _, g => if g = 0 then .draw else .loss
  | n + 1, l, g =>
    if l = [] then (if g = 0 then .draw else .loss)
    else if l.sum < g then .loss
    else Outcome.best (l.map fun x =>
      if g ≤ x then (gvL n (l.erase x) (x - g)).neg else gvL n (l.erase x) (g - x))

theorem best_congr' {l₁ l₂ : List Outcome} (h : ∀ o, o ∈ l₁ ↔ o ∈ l₂) :
    Outcome.best l₁ = Outcome.best l₂ := by
  simp only [best_eq_bestMem, bestMem, h]

theorem gv_eq_gvL : ∀ (n : ℕ) (l : List ℕ) (R : Finset ℕ), R.val = ↑l → l.length = n →
    ∀ g, gv R g = gvL n l g := by
  intro n
  induction n with
  | zero =>
    intro l R hRl hlen g
    obtain rfl : l = [] := List.eq_nil_of_length_eq_zero hlen
    have hR : R = ∅ := Finset.val_eq_zero.mp (by simpa using hRl)
    subst hR
    rw [gv_empty]
    simp [gvL]
  | succ n ih =>
    intro l R hRl hlen g
    have hnil : l ≠ [] := by rintro rfl; simp at hlen
    have hR : R ≠ ∅ := by
      intro h
      apply hnil
      subst h
      simpa using hRl.symm
    have hsum : R.sum (fun x => x) = l.sum := by
      unfold Finset.sum
      rw [hRl]
      simp
    have hmem : ∀ x, x ∈ R ↔ x ∈ l := by
      intro x
      rw [Finset.mem_def, hRl, Multiset.mem_coe]
    have key : ∀ x ∈ l, ∀ g', gv (R.erase x) g' = gvL n (l.erase x) g' := by
      intro x hx g'
      apply ih
      · rw [Finset.erase_val, hRl, Multiset.coe_erase]
      · rw [List.length_erase_of_mem hx]; omega
    rw [gv_eq, gvL]
    simp only [hR, hnil, if_false, hsum]
    by_cases hlt : l.sum < g
    · simp [hlt]
    · simp only [hlt, if_false]
      apply best_congr'
      intro o
      simp only [List.mem_map, Finset.mem_toList, Finset.mem_attach, true_and, Subtype.exists]
      constructor
      · rintro ⟨x, hx, rfl⟩
        refine ⟨x, (hmem x).1 hx, ?_⟩
        simp [key x ((hmem x).1 hx)]
      · rintro ⟨x, hx, rfl⟩
        refine ⟨x, (hmem x).2 hx, ?_⟩
        simp [key x hx]

theorem value_Icc_eq_gvL (N : ℕ) : value (Finset.Icc 1 N) = gvL N (List.range' 1 N) 0 := by
  rw [value_eq_gv]
  apply gv_eq_gvL
  · rw [Nat.Icc_eq_range']
    simp
  · simp

mutual
/-- A strategy certificate. -/
inductive Cert where
  /-- terminal position -/
  | leaf : Cert
  /-- "≥ draw": the mover picks `x`, then continue with the sub-certificate -/
  | pick : ℕ → Cert → Cert
  /-- "≤ draw": one sub-certificate for every available `x` -/
  | all : CertList → Cert
/-- A list of keyed sub-certificates. -/
inductive CertList where
  | nil : CertList
  | cons : ℕ → Cert → CertList → CertList
end

/-- The keys of a certificate list. -/
def CertList.keys : CertList → List ℕ
  | .nil => []
  | .cons x _ rest => x :: rest.keys

mutual
/-- `chkGe l g c = true` certifies that the mover at `(l, g)` secures at least a draw. -/
def chkGe : List ℕ → ℕ → Cert → Bool
  | l, g, .leaf => l.isEmpty && (g == 0)
  | l, g, .pick x c => decide (x ∈ l) && !(decide (l.sum < g)) &&
      (if g ≤ x then chkLe (l.erase x) (x - g) c else chkGe (l.erase x) (g - x) c)
  | _, _, .all _ => false
/-- `chkLe l g c = true` certifies that the mover at `(l, g)` gets at most a draw. -/
def chkLe : List ℕ → ℕ → Cert → Bool
  | l, g, .leaf => l.isEmpty || decide (l.sum < g)
  | l, g, .all cs => (l.all fun x => decide (x ∈ cs.keys)) && chkLeList l g cs
  | _, _, .pick _ _ => false
/-- Every keyed sub-certificate of the list is valid. -/
def chkLeList : List ℕ → ℕ → CertList → Bool
  | _, _, .nil => true
  | l, g, .cons x c rest => decide (x ∈ l) &&
      (if g ≤ x then chkGe (l.erase x) (x - g) c else chkLe (l.erase x) (g - x) c) &&
      chkLeList l g rest
end

example : chkGe [1, 2] 0 (.pick 2 (.all (.cons 1 .leaf .nil))) = true := by decide +kernel

theorem neg_ne_loss {o : Outcome} (h : o ≠ .win) : o.neg ≠ .loss := by
  cases o <;> simp_all [Outcome.neg]

theorem neg_ne_win {o : Outcome} (h : o ≠ .loss) : o.neg ≠ .win := by
  cases o <;> simp_all [Outcome.neg]

theorem chkLeList_of_mem : ∀ (k : ℕ) (cs : CertList), cs.keys.length = k →
    ∀ (l : List ℕ) (g x : ℕ), chkLeList l g cs = true → x ∈ cs.keys → ∃ c, x ∈ l ∧
      (if g ≤ x then chkGe (l.erase x) (x - g) c else chkLe (l.erase x) (g - x) c) = true := by
  intro k
  induction k with
  | zero =>
    intro cs hk l g x _ hx
    cases cs with
    | nil => simp [CertList.keys] at hx
    | cons y c rest => simp [CertList.keys] at hk
  | succ k ih =>
    intro cs hk l g x h hx
    cases cs with
    | nil => simp [CertList.keys] at hx
    | cons y c rest =>
      simp only [CertList.keys, List.length_cons, List.mem_cons] at hk hx
      rw [chkLeList] at h
      simp only [Bool.and_eq_true, decide_eq_true_eq] at h
      obtain ⟨⟨hy, hc⟩, hrest⟩ := h
      rcases hx with rfl | hx
      · exact ⟨c, hy, hc⟩
      · exact ih rest (by omega) l g x hrest hx

theorem sound_aux : ∀ (n : ℕ) (l : List ℕ), l.length = n → ∀ (g : ℕ) (c : Cert),
    (chkGe l g c = true → gvL n l g ≠ .loss) ∧ (chkLe l g c = true → gvL n l g ≠ .win) := by
  intro n
  induction n with
  | zero =>
    intro l hl g c
    obtain rfl : l = [] := List.eq_nil_of_length_eq_zero hl
    refine ⟨fun h => ?_, fun _ => ?_⟩
    · cases c with
      | leaf =>
        simp [chkGe] at h
        simp [gvL, h]
      | pick x c => simp [chkGe] at h
      | all cs => simp [chkGe] at h
    · simp only [gvL]
      split_ifs <;> simp
  | succ m ih =>
    intro l hl g c
    have hnil : l ≠ [] := by rintro rfl; simp at hl
    have key : ∀ x ∈ l, (l.erase x).length = m := by
      intro x hx; rw [List.length_erase_of_mem hx]; omega
    refine ⟨fun h => ?_, fun h => ?_⟩
    · cases c with
      | leaf => simp [chkGe, hnil] at h
      | all cs => simp [chkGe] at h
      | pick x c =>
        simp only [chkGe, Bool.and_eq_true, decide_eq_true_eq, Bool.not_eq_true',
          decide_eq_false_iff_not] at h
        obtain ⟨⟨hx, hs⟩, hc⟩ := h
        rw [gvL, if_neg hnil, if_neg hs]
        intro hb
        rw [best_eq_loss_iff] at hb
        have hmem : (if g ≤ x then (gvL m (l.erase x) (x - g)).neg else gvL m (l.erase x) (g - x))
            ∈ l.map (fun x => if g ≤ x then (gvL m (l.erase x) (x - g)).neg
              else gvL m (l.erase x) (g - x)) := List.mem_map_of_mem hx
        have hne : (if g ≤ x then (gvL m (l.erase x) (x - g)).neg
            else gvL m (l.erase x) (g - x)) ≠ .loss := by
          split_ifs at hc ⊢ with hgx
          · exact neg_ne_loss ((ih _ (key x hx) _ _).2 hc)
          · exact (ih _ (key x hx) _ _).1 hc
        revert hmem hne
        generalize (if g ≤ x then (gvL m (l.erase x) (x - g)).neg
            else gvL m (l.erase x) (g - x)) = o
        intro hmem hne
        cases o with
        | win => exact hb.1 hmem
        | loss => exact hne rfl
        | draw => exact hb.2 hmem
    · cases c with
      | leaf =>
        simp [chkLe, hnil] at h
        rw [gvL, if_neg hnil, if_pos h]
        simp
      | pick x c => simp [chkLe] at h
      | all cs =>
        simp only [chkLe, Bool.and_eq_true, List.all_eq_true, decide_eq_true_eq] at h
        obtain ⟨hall, hlist⟩ := h
        rw [gvL, if_neg hnil]
        split_ifs with hs
        · simp
        · rw [Ne, best_eq_win_iff, List.mem_map]
          rintro ⟨x, hx, hw⟩
          obtain ⟨c, -, hc⟩ := chkLeList_of_mem _ cs rfl l g x hlist (hall x hx)
          split_ifs at hc hw with hgx
          · exact neg_ne_win ((ih _ (key x hx) _ _).1 hc) hw
          · exact (ih _ (key x hx) _ _).2 hc hw

theorem chkGe_sound : ∀ (c : Cert) (n : ℕ) (l : List ℕ), l.length = n → ∀ g,
    chkGe l g c = true → gvL n l g ≠ .loss :=
  fun c n l hl g => (sound_aux n l hl g c).1

theorem chkLe_sound : ∀ (c : Cert) (n : ℕ) (l : List ℕ), l.length = n → ∀ g,
    chkLe l g c = true → gvL n l g ≠ .win :=
  fun c n l hl g => (sound_aux n l hl g c).2

theorem gvL_eq_draw_of_certs {n : ℕ} {l : List ℕ} (hl : l.length = n) {g : ℕ} (cge cle : Cert)
    (h1 : chkGe l g cge = true) (h2 : chkLe l g cle = true) : gvL n l g = .draw := by
  have a := chkGe_sound cge n l hl g h1
  have b := chkLe_sound cle n l hl g h2
  cases h : gvL n l g <;> simp_all

theorem value_Icc_eq_draw_of_certs (N : ℕ) (cge cle : Cert)
    (h1 : chkGe (List.range' 1 N) 0 cge = true) (h2 : chkLe (List.range' 1 N) 0 cle = true) :
    value (Finset.Icc 1 N) = .draw := by
  rw [value_Icc_eq_gvL]
  exact gvL_eq_draw_of_certs (by simp) cge cle h1 h2

end CatchUpDeep
