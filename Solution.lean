import FormalConjectures.GreensOpenProblems.«72»
import Solution.Green72.Witnesses

/-!
# Green 72 for 3 ≤ N ≤ 60

The bound `AllowedSetSize 3 N ≤ 2 * N` is `Green72.allowedSetSize_le`.
For the other direction each N has a witness list of `2 * N` points in `Green72Data`,
and a Boolean certificate `check N wN = true` is verified by kernel reduction.
`of_check` turns such a certificate into `NoKInLineFor 3 N`.
-/

open Green72Data

namespace Green72Proof

/-- The integer collinearity relation for three grid points, written without subtraction. -/
def Col (p q r : ℕ × ℕ) : Prop :=
  p.1 * q.2 + q.1 * r.2 + r.1 * p.2 = p.1 * r.2 + q.1 * p.2 + r.1 * q.2

lemma col_swap12 {p q r : ℕ × ℕ} : Col p q r → Col q p r := by
  unfold Col; intro h; linarith

lemma col_swap23 {p q r : ℕ × ℕ} : Col p q r → Col p r q := by
  unfold Col; intro h; linarith

/-- Real collinearity of three grid points implies the integer relation. -/
lemma col_of_collinear {a b c : ℕ × ℕ}
    (h : Collinear ℝ ({x | ∃ i ∈ ({a, b, c} : Finset (ℕ × ℕ)), x = ((↑i.1 : ℝ), (↑i.2 : ℝ))} :
      Set (ℝ × ℝ))) : Col a b c := by
  rw [collinear_iff_exists_forall_eq_smul_vadd] at h
  obtain ⟨p₀, v, hv⟩ := h
  obtain ⟨ra, ha⟩ := hv _ ⟨a, by simp, rfl⟩
  obtain ⟨rb, hb⟩ := hv _ ⟨b, by simp, rfl⟩
  obtain ⟨rc, hc⟩ := hv _ ⟨c, by simp, rfl⟩
  simp only [vadd_eq_add, Prod.ext_iff, Prod.fst_add, Prod.snd_add, Prod.smul_fst,
    Prod.smul_snd, smul_eq_mul] at ha hb hc
  unfold Col
  have : ((a.1 * b.2 + b.1 * c.2 + c.1 * a.2 : ℕ) : ℝ) =
      ((a.1 * c.2 + b.1 * a.2 + c.1 * b.2 : ℕ) : ℝ) := by
    push_cast
    rw [ha.1, ha.2, hb.1, hb.2, hc.1, hc.2]
    ring
  exact_mod_cast this

/- The checker is written with `List.rec` and `Bool.rec` rather than structural recursion,
which makes kernel reduction several times faster. The `_cons` lemmas give the usual equations. -/

/-- Inner loop of the checker: the line through `(p1, p2)` and `(q1, q2)` misses every `r`.
The constants `k1 = p1 * q2` and `k2 = q1 * p2` are computed once per pair. -/
noncomputable def allOk2 (p1 p2 q1 q2 k1 k2 : Nat) (l : List (Nat × Nat)) : Bool :=
  List.rec (motive := fun _ => Bool) true (fun r _ ih =>
    Bool.rec (motive := fun _ => Bool) ih false
      (Nat.beq (Nat.add (Nat.add (Nat.mul r.2 q1) (Nat.mul r.1 p2)) k1)
        (Nat.add (Nat.add (Nat.mul r.2 p1) (Nat.mul r.1 q2)) k2))) l

/-- Middle loop of the checker: `p` together with each `q` of the list. -/
noncomputable def pairsOk2 (p : Nat × Nat) (l : List (Nat × Nat)) : Bool :=
  List.rec (motive := fun _ => Bool) true (fun q rest ih =>
    Bool.rec (motive := fun _ => Bool) false ih
      (allOk2 p.1 p.2 q.1 q.2 (Nat.mul p.1 q.2) (Nat.mul q.1 p.2) rest)) l

/-- True iff no three points of the list are collinear (a faster form of `noThree`). -/
noncomputable def noThree2 (l : List (Nat × Nat)) : Bool :=
  List.rec (motive := fun _ => Bool) true (fun p rest ih =>
    Bool.rec (motive := fun _ => Bool) false ih (pairsOk2 p rest)) l

lemma allOk2_cons (p1 p2 q1 q2 k1 k2 : Nat) (r : Nat × Nat) (rest : List (Nat × Nat)) :
    allOk2 p1 p2 q1 q2 k1 k2 (r :: rest) =
      cond (Nat.beq (Nat.add (Nat.add (Nat.mul r.2 q1) (Nat.mul r.1 p2)) k1)
        (Nat.add (Nat.add (Nat.mul r.2 p1) (Nat.mul r.1 q2)) k2))
        false (allOk2 p1 p2 q1 q2 k1 k2 rest) := by
  show Bool.rec (motive := fun _ => Bool) (allOk2 p1 p2 q1 q2 k1 k2 rest) false
    (Nat.beq (Nat.add (Nat.add (Nat.mul r.2 q1) (Nat.mul r.1 p2)) k1)
      (Nat.add (Nat.add (Nat.mul r.2 p1) (Nat.mul r.1 q2)) k2)) = _
  cases Nat.beq (Nat.add (Nat.add (Nat.mul r.2 q1) (Nat.mul r.1 p2)) k1)
    (Nat.add (Nat.add (Nat.mul r.2 p1) (Nat.mul r.1 q2)) k2) <;> rfl

lemma pairsOk2_cons (p q : Nat × Nat) (rest : List (Nat × Nat)) :
    pairsOk2 p (q :: rest) =
      cond (allOk2 p.1 p.2 q.1 q.2 (Nat.mul p.1 q.2) (Nat.mul q.1 p.2) rest)
        (pairsOk2 p rest) false := by
  show Bool.rec (motive := fun _ => Bool) false (pairsOk2 p rest)
    (allOk2 p.1 p.2 q.1 q.2 (Nat.mul p.1 q.2) (Nat.mul q.1 p.2) rest) = _
  cases allOk2 p.1 p.2 q.1 q.2 (Nat.mul p.1 q.2) (Nat.mul q.1 p.2) rest <;> rfl

lemma noThree2_cons (p : Nat × Nat) (rest : List (Nat × Nat)) :
    noThree2 (p :: rest) = cond (pairsOk2 p rest) (noThree2 rest) false := by
  show Bool.rec (motive := fun _ => Bool) false (noThree2 rest) (pairsOk2 p rest) = _
  cases pairsOk2 p rest <;> rfl

/-- True iff no two entries of the list are equal. -/
def nodupB : List (Nat × Nat) → Bool
  | [] => true
  | p :: rest =>
    cond (rest.all fun q => !(Nat.beq p.1 q.1 && Nat.beq p.2 q.2)) (nodupB rest) false

/-- The full certificate for one grid size. -/
noncomputable def check (n : Nat) (l : List (Nat × Nat)) : Bool :=
  noThree2 l && inGrid n l && Nat.beq l.length (2 * n) && nodupB l

lemma allOk2_spec {p q : ℕ × ℕ} :
    ∀ {l : List (ℕ × ℕ)}, allOk2 p.1 p.2 q.1 q.2 (p.1 * q.2) (q.1 * p.2) l = true →
      ∀ r ∈ l, ¬ Col p q r
  | [], _, r, hr => by simp at hr
  | s :: rest, h, r, hr => by
    rw [allOk2_cons] at h
    cases hb : Nat.beq (Nat.add (Nat.add (Nat.mul s.2 q.1) (Nat.mul s.1 p.2)) (p.1 * q.2))
        (Nat.add (Nat.add (Nat.mul s.2 p.1) (Nat.mul s.1 q.2)) (q.1 * p.2)) with
    | true => rw [hb] at h; simp at h
    | false =>
      rw [hb] at h
      simp only [cond_false] at h
      rcases List.mem_cons.mp hr with rfl | hr
      · intro hc
        apply Nat.ne_of_beq_eq_false hb
        simp only [Nat.add_eq, Nat.mul_eq]
        unfold Col at hc
        linarith
      · exact allOk2_spec h r hr

lemma pairsOk2_spec {p : ℕ × ℕ} :
    ∀ {l : List (ℕ × ℕ)}, pairsOk2 p l = true →
      ∀ q ∈ l, ∀ r ∈ l, q ≠ r → ¬ Col p q r
  | [], _, q, hq, _, _, _ => by simp at hq
  | s :: rest, h, q, hq, r, hr, hqr => by
    rw [pairsOk2_cons] at h
    cases hb : allOk2 p.1 p.2 s.1 s.2 (Nat.mul p.1 s.2) (Nat.mul s.1 p.2) rest with
    | false => rw [hb] at h; simp at h
    | true =>
      rw [hb] at h
      simp only [cond_true] at h
      have hs := @allOk2_spec p s rest hb
      rcases List.mem_cons.mp hq with rfl | hq'
      · rcases List.mem_cons.mp hr with rfl | hr'
        · exact absurd rfl hqr
        · exact hs r hr'
      · rcases List.mem_cons.mp hr with rfl | hr'
        · exact fun hc => hs q hq' (col_swap23 hc)
        · exact pairsOk2_spec h q hq' r hr' hqr

lemma noThree2_spec :
    ∀ {l : List (ℕ × ℕ)}, noThree2 l = true →
      ∀ a ∈ l, ∀ b ∈ l, ∀ c ∈ l, a ≠ b → a ≠ c → b ≠ c → ¬ Col a b c
  | [], _, a, ha, _, _, _, _, _, _, _ => by simp at ha
  | s :: rest, h, a, ha, b, hb, c, hc, hab, hac, hbc => by
    rw [noThree2_cons] at h
    cases hp : pairsOk2 s rest with
    | false => rw [hp] at h; simp at h
    | true =>
      rw [hp] at h
      simp only [cond_true] at h
      have hs := pairsOk2_spec hp
      rcases List.mem_cons.mp ha with rfl | ha'
      · rcases List.mem_cons.mp hb with rfl | hb'
        · exact absurd rfl hab
        rcases List.mem_cons.mp hc with rfl | hc'
        · exact absurd rfl hac
        exact hs b hb' c hc' hbc
      rcases List.mem_cons.mp hb with rfl | hb'
      · rcases List.mem_cons.mp hc with rfl | hc'
        · exact absurd rfl hbc
        exact fun h' => hs a ha' c hc' hac (col_swap12 h')
      rcases List.mem_cons.mp hc with rfl | hc'
      · exact fun h' => hs a ha' b hb' hab (col_swap12 (col_swap23 h'))
      exact noThree2_spec h a ha' b hb' c hc' hab hac hbc

lemma nodupB_spec : ∀ {l : List (ℕ × ℕ)}, nodupB l = true → l.Nodup
  | [], _ => List.nodup_nil
  | s :: rest, h => by
    unfold nodupB at h
    cases hp : rest.all (fun q => !(Nat.beq s.1 q.1 && Nat.beq s.2 q.2)) with
    | false => rw [hp] at h; simp at h
    | true =>
      rw [hp] at h
      simp only [cond_true] at h
      refine List.nodup_cons.mpr ⟨fun hs => ?_, nodupB_spec h⟩
      have := List.all_eq_true.mp hp s hs
      simp [Nat.beq_refl] at this

/-- A verified certificate for size `n` gives the pigeonhole bound exactly. -/
theorem of_check (n : ℕ) (l : List (ℕ × ℕ)) (h : check n l = true) :
    Green72.NoKInLineFor 3 n := by
  simp only [check, Bool.and_eq_true] at h
  obtain ⟨⟨⟨hno, hgrid⟩, hlen⟩, hnd⟩ := h
  have hlen : l.length = 2 * n := Nat.eq_of_beq_eq_true hlen
  have hnd := nodupB_spec hnd
  have hgrid : ∀ p ∈ l, p.1 < n ∧ p.2 < n := by
    intro p hp
    have := List.all_eq_true.mp hgrid p hp
    simpa using this
  have hallowed : Green72.AllowedSet 3 n l.toFinset := by
    refine ⟨fun i hi => hgrid i (List.mem_toFinset.mp hi), ?_⟩
    intro t hts htc hcol
    obtain ⟨a, b, c, hab, hac, hbc, rfl⟩ := Finset.card_eq_three.mp htc
    have ha : a ∈ l := List.mem_toFinset.mp (hts (by simp))
    have hb : b ∈ l := List.mem_toFinset.mp (hts (by simp))
    have hc : c ∈ l := List.mem_toFinset.mp (hts (by simp))
    exact noThree2_spec hno a ha b hb c hc hab hac hbc (col_of_collinear hcol)
  unfold Green72.NoKInLineFor
  refine le_antisymm Green72.allowedSetSize_le ?_
  have hbdd : BddAbove {r | ∃ s, r = Finset.card s ∧ Green72.AllowedSet 3 n s} := by
    refine ⟨n * n, ?_⟩
    rintro r ⟨s, rfl, hs⟩
    calc s.card ≤ (Finset.range n ×ˢ Finset.range n).card :=
          Finset.card_le_card fun x hx => by
            have := hs.is_bounded x hx
            simp [Finset.mem_product, this.1, this.2]
      _ = n * n := by simp
  refine le_csSup hbdd ⟨l.toFinset, ?_, hallowed⟩
  rw [List.toFinset_card_of_nodup hnd, hlen]

/- Certificates, one per grid size, checked by kernel reduction. -/

set_option maxRecDepth 100000 in
theorem check3 : check 3 w3 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check4 : check 4 w4 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check5 : check 5 w5 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check6 : check 6 w6 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check7 : check 7 w7 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check8 : check 8 w8 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check9 : check 9 w9 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check10 : check 10 w10 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check11 : check 11 w11 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check12 : check 12 w12 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check13 : check 13 w13 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check14 : check 14 w14 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check15 : check 15 w15 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check16 : check 16 w16 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check17 : check 17 w17 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check18 : check 18 w18 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check19 : check 19 w19 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check20 : check 20 w20 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check21 : check 21 w21 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check22 : check 22 w22 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check23 : check 23 w23 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check24 : check 24 w24 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check25 : check 25 w25 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check26 : check 26 w26 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check27 : check 27 w27 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check28 : check 28 w28 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check29 : check 29 w29 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check30 : check 30 w30 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check31 : check 31 w31 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check32 : check 32 w32 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check33 : check 33 w33 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check34 : check 34 w34 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check35 : check 35 w35 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check36 : check 36 w36 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check37 : check 37 w37 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check38 : check 38 w38 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check39 : check 39 w39 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check40 : check 40 w40 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check41 : check 41 w41 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check42 : check 42 w42 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check43 : check 43 w43 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check44 : check 44 w44 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check45 : check 45 w45 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check46 : check 46 w46 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check47 : check 47 w47 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check48 : check 48 w48 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check49 : check 49 w49 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check50 : check 50 w50 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check51 : check 51 w51 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check52 : check 52 w52 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check53 : check 53 w53 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check54 : check 54 w54 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check55 : check 55 w55 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check56 : check 56 w56 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check57 : check 57 w57 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check58 : check 58 w58 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check59 : check 59 w59 = true := by decide +kernel

set_option maxRecDepth 100000 in
theorem check60 : check 60 w60 = true := by decide +kernel

end Green72Proof

open Green72Proof in
theorem green72_no_three_in_line_le {N : ℕ} (hN : 3 ≤ N) (hN' : N ≤ 60) :
    Green72.NoKInLineFor 3 N := by
  interval_cases N
  · exact of_check _ _ check3
  · exact of_check _ _ check4
  · exact of_check _ _ check5
  · exact of_check _ _ check6
  · exact of_check _ _ check7
  · exact of_check _ _ check8
  · exact of_check _ _ check9
  · exact of_check _ _ check10
  · exact of_check _ _ check11
  · exact of_check _ _ check12
  · exact of_check _ _ check13
  · exact of_check _ _ check14
  · exact of_check _ _ check15
  · exact of_check _ _ check16
  · exact of_check _ _ check17
  · exact of_check _ _ check18
  · exact of_check _ _ check19
  · exact of_check _ _ check20
  · exact of_check _ _ check21
  · exact of_check _ _ check22
  · exact of_check _ _ check23
  · exact of_check _ _ check24
  · exact of_check _ _ check25
  · exact of_check _ _ check26
  · exact of_check _ _ check27
  · exact of_check _ _ check28
  · exact of_check _ _ check29
  · exact of_check _ _ check30
  · exact of_check _ _ check31
  · exact of_check _ _ check32
  · exact of_check _ _ check33
  · exact of_check _ _ check34
  · exact of_check _ _ check35
  · exact of_check _ _ check36
  · exact of_check _ _ check37
  · exact of_check _ _ check38
  · exact of_check _ _ check39
  · exact of_check _ _ check40
  · exact of_check _ _ check41
  · exact of_check _ _ check42
  · exact of_check _ _ check43
  · exact of_check _ _ check44
  · exact of_check _ _ check45
  · exact of_check _ _ check46
  · exact of_check _ _ check47
  · exact of_check _ _ check48
  · exact of_check _ _ check49
  · exact of_check _ _ check50
  · exact of_check _ _ check51
  · exact of_check _ _ check52
  · exact of_check _ _ check53
  · exact of_check _ _ check54
  · exact of_check _ _ check55
  · exact of_check _ _ check56
  · exact of_check _ _ check57
  · exact of_check _ _ check58
  · exact of_check _ _ check59
  · exact of_check _ _ check60
