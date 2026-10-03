import FormalConjectures.GreensOpenProblems.«72»
import Solution.Green72.Checker

/-! Soundness of `Green72Proof.check`: a list that passes it gives `NoKInLineFor 3 n`. -/

namespace Green72Proof

open scoped List

/-- The collinearity equation in the form `allOk` evaluates it. -/
def Coll (p q r : ℕ × ℕ) : Prop :=
  r.2 * q.1 + r.1 * p.2 + p.1 * q.2 = r.2 * p.1 + r.1 * q.2 + q.1 * p.2

theorem allOk_cons (x1 x2 y1 y2 c1 c2 : ℕ) (r : ℕ × ℕ) (rest : List (ℕ × ℕ)) :
    allOk x1 x2 y1 y2 c1 c2 (r :: rest) =
      Bool.rec (allOk x1 x2 y1 y2 c1 c2 rest) false
        (Nat.beq (r.2 * x2 + r.1 * y1 + c1) (r.2 * x1 + r.1 * y2 + c2)) := rfl

theorem pairsOk_cons (p q : ℕ × ℕ) (rest : List (ℕ × ℕ)) :
    pairsOk p (q :: rest) =
      Bool.rec false (pairsOk p rest) (allOk p.1 q.1 p.2 q.2 (p.1 * q.2) (q.1 * p.2) rest) := rfl

theorem noThree_cons (p : ℕ × ℕ) (rest : List (ℕ × ℕ)) :
    noThree (p :: rest) = Bool.rec false (noThree rest) (pairsOk p rest) := rfl

theorem allOk_sound {p q : ℕ × ℕ} {l : List (ℕ × ℕ)}
    (h : allOk p.1 q.1 p.2 q.2 (p.1 * q.2) (q.1 * p.2) l = true) : ∀ r ∈ l, ¬ Coll p q r := by
  induction l with
  | nil => simp
  | cons r rest ih =>
    rw [allOk_cons] at h
    cases hb : Nat.beq (r.2 * q.1 + r.1 * p.2 + p.1 * q.2) (r.2 * p.1 + r.1 * q.2 + q.1 * p.2) with
    | true => rw [hb] at h; exact absurd h Bool.false_ne_true
    | false =>
      rw [hb] at h
      intro s hs
      rcases List.mem_cons.mp hs with rfl | hs
      · exact Nat.ne_of_beq_eq_false hb
      · exact ih h s hs

theorem pairsOk_sound {p : ℕ × ℕ} {l : List (ℕ × ℕ)} (h : pairsOk p l = true) :
    ∀ q r, [q, r] <+ l → ¬ Coll p q r := by
  induction l with
  | nil => intro q r hs; cases hs
  | cons a rest ih =>
    rw [pairsOk_cons] at h
    cases ha : allOk p.1 a.1 p.2 a.2 (p.1 * a.2) (a.1 * p.2) rest with
    | false => rw [ha] at h; exact absurd h Bool.false_ne_true
    | true =>
      rw [ha] at h
      intro q r hs
      cases hs with
      | cons _ hs => exact ih h q r hs
      | cons_cons _ hs => exact allOk_sound ha r (List.singleton_sublist.mp hs)

theorem noThree_sound {l : List (ℕ × ℕ)} (h : noThree l = true) :
    ∀ p q r, [p, q, r] <+ l → ¬ Coll p q r := by
  induction l with
  | nil => intro p q r hs; cases hs
  | cons a rest ih =>
    rw [noThree_cons] at h
    cases ha : pairsOk a rest with
    | false => rw [ha] at h; exact absurd h Bool.false_ne_true
    | true =>
      rw [ha] at h
      intro p q r hs
      cases hs with
      | cons _ hs => exact ih h p q r hs
      | cons_cons _ hs => exact pairsOk_sound ha q r hs

/-- Three grid points whose images in `ℝ × ℝ` lie in a collinear set satisfy `Coll`. -/
theorem coll_of_collinear {x y z : ℕ × ℕ} {S : Set (ℝ × ℝ)} (hS : Collinear ℝ S)
    (hx : ((x.1 : ℝ), (x.2 : ℝ)) ∈ S) (hy : ((y.1 : ℝ), (y.2 : ℝ)) ∈ S)
    (hz : ((z.1 : ℝ), (z.2 : ℝ)) ∈ S) : Coll x y z := by
  rw [collinear_iff_of_mem hx] at hS
  obtain ⟨v, hv⟩ := hS
  obtain ⟨a, ha⟩ := hv _ hy
  obtain ⟨b, hb⟩ := hv _ hz
  have h1 : (y.1 : ℝ) = a * v.1 + x.1 := by simpa using congrArg Prod.fst ha
  have h2 : (y.2 : ℝ) = a * v.2 + x.2 := by simpa using congrArg Prod.snd ha
  have h3 : (z.1 : ℝ) = b * v.1 + x.1 := by simpa using congrArg Prod.fst hb
  have h4 : (z.2 : ℝ) = b * v.2 + x.2 := by simpa using congrArg Prod.snd hb
  unfold Coll
  have : ((z.2 * y.1 + z.1 * x.2 + x.1 * y.2 : ℕ) : ℝ) = ((z.2 * x.1 + z.1 * y.2 + y.1 * x.2 : ℕ) : ℝ) := by
    push_cast
    linear_combination ((z.2 : ℝ) - x.2) * h1 + a * v.1 * h4 - ((y.2 : ℝ) - x.2) * h3 - b * v.1 * h2
  exact_mod_cast this

theorem allowed_of_check {n : ℕ} {l : List (ℕ × ℕ)} (h : check n l = true) :
    Green72.AllowedSet 3 n l.toFinset ∧ l.toFinset.card = 2 * n := by
  simp only [check, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨⟨hlen, hgrid⟩, hnd⟩, hno⟩ := h
  have hlen := Nat.eq_of_beq_eq_true hlen
  refine ⟨⟨?_, ?_⟩, by rw [List.toFinset_card_of_nodup hnd, hlen]⟩
  · intro i hi
    have := List.all_eq_true.mp hgrid i (List.mem_toFinset.mp hi)
    simpa using this
  · intro t hts htc hcol
    set L := l.filter (fun x => decide (x ∈ t)) with hL
    have hLsub : L <+ l := List.filter_sublist
    have hLnd : L.Nodup := hnd.sublist hLsub
    have hLt : ∀ x, x ∈ L ↔ x ∈ t := by
      intro x
      simp only [hL, List.mem_filter, decide_eq_true_eq]
      exact ⟨fun h => h.2, fun h => ⟨List.mem_toFinset.mp (hts h), h⟩⟩
    have hLt' : L.toFinset = t := by ext x; simp [hLt]
    have hlen3 : L.length = 3 := by rw [← List.toFinset_card_of_nodup hLnd, hLt', htc]
    clear_value L
    match L, hlen3, hLsub, hLt with
    | [x, y, z], _, hsub, hmem =>
      have mem : ∀ w, w ∈ t → ((w.1 : ℝ), (w.2 : ℝ)) ∈
          ({r | ∃ i ∈ t, r = ((↑i.1 : ℝ), (↑i.2 : ℝ))} : Set (ℝ × ℝ)) :=
        fun w hw => ⟨w, hw, rfl⟩
      exact noThree_sound hno x y z hsub
        (coll_of_collinear hcol (mem x ((hmem x).mp (by simp))) (mem y ((hmem y).mp (by simp)))
          (mem z ((hmem z).mp (by simp))))

theorem of_check {n : ℕ} {l : List (ℕ × ℕ)} (h : check n l = true) : Green72.NoKInLineFor 3 n := by
  obtain ⟨hA, hc⟩ := allowed_of_check h
  refine le_antisymm Green72.allowedSetSize_le ?_
  have hbdd : BddAbove {r | ∃ s, r = s.card ∧ Green72.AllowedSet 3 n s} := by
    refine ⟨n * n, ?_⟩
    rintro r ⟨s, rfl, hs⟩
    calc s.card ≤ (Finset.range n ×ˢ Finset.range n).card :=
          Finset.card_le_card fun i hi => by simpa using hs.is_bounded i hi
      _ = n * n := by simp
  exact le_csSup hbdd ⟨l.toFinset, hc.symm, hA⟩

end Green72Proof
