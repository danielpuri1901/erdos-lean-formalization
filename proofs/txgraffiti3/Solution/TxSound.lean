import Mathlib
import Solution.TxDefs

/-! Soundness of the txgraffiti3 certificate checker `Tx.chk`.

`P k d x` says: there is no set `T` of vertices (`< 48`) with at most `k` elements that is
independent, avoids the dominated mask `d` and the excluded mask `x`, and together with `d`
dominates every vertex. `chk_sound` shows that a successful run of `chk` proves `P k d x`. -/

namespace Tx

open Finset

theorem bit_eq (d v : Nat) : bit d v = d.testBit v := by
  rw [Nat.testBit_eq_decide_div_mod_eq]
  have h1 : Nat.land (Nat.shiftRight d v) 1 = d / 2 ^ v % 2 := by
    show (d >>> v) &&& 1 = _
    rw [Nat.and_one_is_mod, Nat.shiftRight_eq_div_pow]
  unfold bit
  rw [h1]
  cases h : Nat.beq (d / 2 ^ v % 2) 1
  · exact (decide_eq_false (Nat.ne_of_beq_eq_false h)).symm
  · exact (decide_eq_true (Nat.eq_of_beq_eq_true h)).symm

theorem bit_lor (a b v : Nat) : bit (Nat.lor a b) v = (bit a v || bit b v) := by
  simp only [bit_eq]
  exact Nat.testBit_or a b v

theorem bit_pow (w v : Nat) : bit (Nat.pow 2 w) v = decide (w = v) := by
  rw [bit_eq]
  exact Nat.testBit_two_pow

theorem bit_zero (v : Nat) : bit 0 v = false := by
  rw [bit_eq]
  exact Nat.zero_testBit v

/-- `cnt` with a variable bound. -/
def cntR (d n : Nat) : Nat :=
  Nat.rec (motive := fun _ => Nat) 0
    (fun i r => Nat.add r (Nat.sub 1 (Nat.land (Nat.shiftRight d i) 1))) n

theorem cntR_succ (d n : Nat) :
    cntR d (n + 1) = cntR d n + (1 - Nat.land (Nat.shiftRight d n) 1) := rfl

theorem cntR_eq (d n : Nat) : cntR d n = ((range n).filter (fun v => bit d v = false)).card := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [cntR_succ, ih, range_add_one, filter_insert]
    have hm : Nat.land (Nat.shiftRight d n) 1 < 2 := by
      show (d >>> n) &&& 1 < 2
      rw [Nat.and_one_is_mod]
      exact Nat.mod_lt _ (by norm_num)
    have hb : bit d n = Nat.beq (Nat.land (Nat.shiftRight d n) 1) 1 := rfl
    have hn : n ∉ (range n).filter (fun v => bit d v = false) := by simp
    by_cases h : bit d n = false
    · rw [if_pos h, card_insert_of_notMem hn]
      have h0 := Nat.ne_of_beq_eq_false (hb ▸ h)
      omega
    · rw [if_neg h]
      have h1 : Nat.beq (Nat.land (Nat.shiftRight d n) 1) 1 = true := by
        rw [← hb]; simpa using h
      have h0 := Nat.eq_of_beq_eq_true h1
      omega

theorem cnt_eq (d : Nat) : cnt d = ((range 48).filter (fun v => bit d v = false)).card :=
  cntR_eq d 48

/-! Facts about the table, checked by the kernel. -/

theorem cm_self : ∀ v < 48, bit (cmT v) v = true := by decide +kernel

theorem cm_symm : ∀ a < 48, ∀ b < 48, bit (cmT a) b = bit (cmT b) a := by decide +kernel

theorem nb4 : ∀ t < 48, ((range 48).filter (fun v => bit (cmT t) v = true)).card ≤ 4 := by
  decide +kernel

theorem tb_cm : ∀ u < 48, ∀ p ∈ tb u, p.2 = cmT p.1 := by decide +kernel

theorem tb_complete : ∀ t < 48, ∀ u < 48, bit (cmT t) u = true → t ∈ (tb u).map Prod.fst := by
  decide +kernel

/-- No independent set `T` (`|T| ≤ k`), disjoint from `d ∪ x`, dominates the rest of the graph. -/
def P (k d x : Nat) : Prop :=
  ∀ T : Finset Nat, (∀ t ∈ T, t < 48) → T.card ≤ k →
    (∀ a ∈ T, ∀ b ∈ T, bit (cmT a) b = true → a = b) →
    (∀ t ∈ T, bit d t = false ∧ bit x t = false) →
    (∀ v < 48, bit d v = true ∨ ∃ t ∈ T, bit (cmT t) v = true) → False

/-- Each vertex dominates at most 4 vertices. -/
theorem bound (d k : Nat) (T : Finset Nat) (hT : ∀ t ∈ T, t < 48) (hk : T.card ≤ k)
    (hdom : ∀ v < 48, bit d v = true ∨ ∃ t ∈ T, bit (cmT t) v = true) : cnt d ≤ 4 * k := by
  rw [cnt_eq]
  have hsub : (range 48).filter (fun v => bit d v = false) ⊆
      T.biUnion (fun t => (range 48).filter (fun v => bit (cmT t) v = true)) := by
    intro v hv
    simp only [mem_filter, mem_range] at hv
    rcases hdom v hv.1 with h | ⟨t, ht, h⟩
    · rw [hv.2] at h; cases h
    · exact mem_biUnion.mpr ⟨t, ht, mem_filter.mpr ⟨mem_range.mpr hv.1, h⟩⟩
  calc _ ≤ _ := card_le_card hsub
    _ ≤ ∑ t ∈ T, ((range 48).filter (fun v => bit (cmT t) v = true)).card := card_biUnion_le
    _ ≤ ∑ _t ∈ T, 4 := sum_le_sum (fun t ht => nb4 t (hT t ht))
    _ = 4 * T.card := by rw [sum_const, smul_eq_mul, mul_comm]
    _ ≤ 4 * k := by omega

theorem bound_P {k d x : Nat} (h : 4 * k < cnt d) : P k d x := by
  intro T hT hk _ _ hdom
  have := bound d k T hT hk hdom
  omega

theorem brL_cons (f : Nat → Nat → Nat → Option Nat) (d : Nat) (p : Nat × Nat)
    (L : List (Nat × Nat)) (x c : Nat) :
    brL f d (p :: L) x c = (bif bit d p.1 || bit x p.1 then brL f d L x c else
      Option.rec none (fun c' => brL f d L (Nat.lor x (Nat.pow 2 p.1)) c')
        (f (Nat.lor d p.2) x c)) := rfl

theorem brL_sound (k : Nat) (f : Nat → Nat → Nat → Option Nat)
    (hf : ∀ d' x' c r, f d' x' c = some r → P k d' x') (d : Nat) (T : Finset Nat)
    (hT : ∀ t ∈ T, t < 48) (hcard : T.card ≤ k + 1)
    (hind : ∀ a ∈ T, ∀ b ∈ T, bit (cmT a) b = true → a = b)
    (hdom : ∀ v < 48, bit d v = true ∨ ∃ t ∈ T, bit (cmT t) v = true) :
    ∀ L : List (Nat × Nat), (∀ p ∈ L, p.2 = cmT p.1) → ∀ x c r, brL f d L x c = some r →
      (∀ t ∈ T, bit d t = false ∧ bit x t = false) → (∃ t ∈ T, t ∈ L.map Prod.fst) → False := by
  intro L
  induction L with
  | nil =>
    intro _ x c r _ _ ⟨t, _, ht⟩
    simp at ht
  | cons p L ih =>
    intro hL x c r h hav ⟨t, htT, htL⟩
    rw [brL_cons] at h
    have hp2 : p.2 = cmT p.1 := hL p List.mem_cons_self
    have hL' : ∀ q ∈ L, q.2 = cmT q.1 := fun q hq => hL q (List.mem_cons_of_mem _ hq)
    rw [List.map_cons, List.mem_cons] at htL
    cases hb : (bit d p.1 || bit x p.1)
    · rw [hb, cond_false] at h
      cases hfc : f (Nat.lor d p.2) x c with
      | none =>
        rw [hfc] at h
        cases h
      | some c' =>
        rw [hfc] at h
        change brL f d L (Nat.lor x (Nat.pow 2 p.1)) c' = some r at h
        by_cases hpT : p.1 ∈ T
        · have hP := hf _ _ _ _ hfc
          rw [hp2] at hP
          apply hP (T.erase p.1)
          · intro s hs
            exact hT s (mem_of_mem_erase hs)
          · rw [card_erase_of_mem hpT]
            omega
          · intro a ha b hb' hab
            exact hind a (mem_of_mem_erase ha) b (mem_of_mem_erase hb') hab
          · intro s hs
            have hsne := ne_of_mem_erase hs
            have hsT := mem_of_mem_erase hs
            refine ⟨?_, (hav s hsT).2⟩
            rw [bit_lor, (hav s hsT).1, Bool.false_or]
            cases hc : bit (cmT p.1) s
            · rfl
            · exact absurd (hind p.1 hpT s hsT hc).symm hsne
          · intro v hv
            rcases hdom v hv with h1 | ⟨s, hs, h2⟩
            · left
              rw [bit_lor, h1, Bool.true_or]
            · by_cases hsp : s = p.1
              · left
                rw [bit_lor, ← hsp, h2, Bool.or_true]
              · right
                exact ⟨s, mem_erase.mpr ⟨hsp, hs⟩, h2⟩
        · apply ih hL' _ _ _ h
          · intro s hs
            refine ⟨(hav s hs).1, ?_⟩
            rw [bit_lor, bit_pow, (hav s hs).2, Bool.false_or, decide_eq_false_iff_not]
            intro he
            exact hpT (he ▸ hs)
          · refine ⟨t, htT, ?_⟩
            rcases htL with he | he
            · exact absurd (he ▸ htT) hpT
            · exact he
    · rw [hb, cond_true] at h
      apply ih hL' x c r h hav
      refine ⟨t, htT, ?_⟩
      rcases htL with he | he
      · exfalso
        rw [he] at htT
        have h3 := hav _ htT
        rw [h3.1, h3.2] at hb
        cases hb
      · exact he

theorem inOk_sound (k d x : Nat) :
    ∀ ok : List (Nat × Nat × Nat), inOk k d x ok = true → (k, d, x) ∈ ok
  | [], h => by cases h
  | s :: l, h => by
    simp only [inOk, Bool.or_eq_true, Bool.and_eq_true] at h
    rcases h with ⟨⟨h1, h2⟩, h3⟩ | h
    · have e1 := Nat.eq_of_beq_eq_true h1
      have e2 := Nat.eq_of_beq_eq_true h2
      have e3 := Nat.eq_of_beq_eq_true h3
      have : s = (k, d, x) := by
        obtain ⟨a, b, c⟩ := s
        simp only at e1 e2 e3
        rw [e1, e2, e3]
      rw [this]
      exact List.mem_cons_self
    · exact List.mem_cons_of_mem _ (inOk_sound k d x l h)

theorem nd_cases {ok : List (Nat × Nat × Nat)} {k d x c : Nat} {br : Nat → Nat → Option Nat}
    {r : Nat} (h : nd ok k d x c br = some r) :
    4 * k < cnt d ∨ inOk k d x ok = true ∨
      ∃ r', br (Nat.land c 63) (Nat.shiftRight c 6) = some r' := by
  unfold nd at h
  cases h1 : Nat.beq (Nat.land c 63) 48
  · rw [h1, cond_false] at h
    cases h2 : Nat.beq (Nat.land c 63) 49
    · rw [h2, cond_false] at h
      exact Or.inr (Or.inr ⟨r, h⟩)
    · rw [h2, cond_true] at h
      cases h3 : inOk k d x ok
      · rw [h3, cond_false] at h
        cases h
      · exact Or.inr (Or.inl rfl)
  · rw [h1, cond_true] at h
    cases h3 : Nat.blt (Nat.mul 4 k) (cnt d)
    · rw [h3, cond_false] at h
      cases h
    · left
      exact Nat.le_of_ble_eq_true h3

theorem chk_zero (ok : List (Nat × Nat × Nat)) (d x c : Nat) :
    chk ok 0 d x c = nd ok 0 d x c (fun _ _ => none) := rfl

theorem chk_succ (ok : List (Nat × Nat × Nat)) (k d x c : Nat) :
    chk ok (k + 1) d x c = nd ok (k + 1) d x c (fun e c' =>
      bif Nat.blt e 48 && !(bit d e) then brL (chk ok k) d (tb e) x c' else none) := rfl

theorem chk_sound (ok : List (Nat × Nat × Nat)) (hok : ∀ s ∈ ok, P s.1 s.2.1 s.2.2) :
    ∀ k d x c r, chk ok k d x c = some r → P k d x := by
  intro k
  induction k with
  | zero =>
    intro d x c r h
    rw [chk_zero] at h
    rcases nd_cases h with h1 | h1 | ⟨r', h1⟩
    · exact bound_P h1
    · exact hok _ (inOk_sound _ _ _ ok h1)
    · cases h1
  | succ k ih =>
    intro d x c r h
    rw [chk_succ] at h
    rcases nd_cases h with h1 | h1 | ⟨r', h1⟩
    · exact bound_P h1
    · exact hok _ (inOk_sound _ _ _ ok h1)
    · cases hc : (Nat.blt (Nat.land c 63) 48 && !bit d (Nat.land c 63))
      · rw [hc, cond_false] at h1
        cases h1
      · rw [hc, cond_true] at h1
        rw [Bool.and_eq_true, Bool.not_eq_true'] at hc
        obtain ⟨he48, hde⟩ := hc
        have he : Nat.land c 63 < 48 := Nat.le_of_ble_eq_true he48
        intro T hT hcard hind hav hdom
        rcases hdom _ he with h2 | ⟨t, htT, ht⟩
        · rw [hde] at h2
          cases h2
        · exact brL_sound k (chk ok k) ih d T hT hcard hind hdom (tb _) (tb_cm _ he) x _ r' h1
            hav ⟨t, htT, tb_complete t (hT t htT) _ he ht⟩

/-- A chunk check with no frontier states proves `P`. -/
theorem chk_sound' {k d x c : Nat} (h : (chk [] k d x c).isSome = true) : P k d x := by
  obtain ⟨r, hr⟩ := Option.isSome_iff_exists.mp h
  exact chk_sound [] (fun _ h => by cases h) k d x c r hr

end Tx
