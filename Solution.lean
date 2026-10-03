import FormalConjectures.GreensOpenProblems.«72»
import Solution.Green72.Witnesses

/-!
# Green's Open Problem 72 for 3 ≤ N ≤ 60

For each `N` the witness `Green72Data.wN` is a list of `2N` points of the `N` by `N` grid.
A Boolean checker, evaluated by the kernel, confirms that the points are distinct, lie in the
grid and contain no three on a line. The checker is written with recursors and raw `Nat`
operations instead of structural recursion, `&&` and `==`, so that `decide +kernel` evaluates it
several times faster than `Green72Data.noThree`. A correctness lemma turns a successful check into
`Green72.AllowedSet 3 N`, so `AllowedSetSize 3 N ≥ 2N`, and `Green72.allowedSetSize_le` gives the
reverse inequality.
-/

open Green72Data

namespace Green72Solution

/- ## The checker -/

/-- The cross-term equation for three grid points: they are collinear iff it holds. -/
def Cross (p q r : ℕ × ℕ) : Prop :=
  p.1 * q.2 + q.1 * r.2 + r.1 * p.2 = p.1 * r.2 + q.1 * p.2 + r.1 * q.2

/-- Boolean test of `Cross` using raw `Nat` operations. -/
def crossB (p q r : ℕ × ℕ) : Bool :=
  Nat.beq (Nat.add (Nat.add (Nat.mul p.1 q.2) (Nat.mul q.1 r.2)) (Nat.mul r.1 p.2))
    (Nat.add (Nat.add (Nat.mul p.1 r.2) (Nat.mul q.1 p.2)) (Nat.mul r.1 q.2))

/-- `true` iff no point of `l` satisfies `Cross p q`. -/
noncomputable def allOkK (p q : ℕ × ℕ) (l : List (ℕ × ℕ)) : Bool :=
  @List.rec (ℕ × ℕ) (fun _ => Bool) true
    (fun r _ ih => @Bool.rec (fun _ => Bool) ih false (crossB p q r)) l

/-- `true` iff `allOkK p q rest` holds for every `q` of `l` with `rest` the points after `q`. -/
noncomputable def pairsOkK (p : ℕ × ℕ) (l : List (ℕ × ℕ)) : Bool :=
  @List.rec (ℕ × ℕ) (fun _ => Bool) true
    (fun q rest ih => @Bool.rec (fun _ => Bool) false ih (allOkK p q rest)) l

/-- `true` iff no three entries of `l`, taken in list order, satisfy `Cross`. -/
noncomputable def noThreeK (l : List (ℕ × ℕ)) : Bool :=
  @List.rec (ℕ × ℕ) (fun _ => Bool) true
    (fun p rest ih => @Bool.rec (fun _ => Bool) false ih (pairsOkK p rest)) l

/-- Boolean equality of grid points using raw `Nat` operations. -/
def eqB (p q : ℕ × ℕ) : Bool :=
  @Bool.rec (fun _ => Bool) false (Nat.beq p.2 q.2) (Nat.beq p.1 q.1)

/-- `true` iff `p` is not an entry of `l`. -/
noncomputable def freshK (p : ℕ × ℕ) (l : List (ℕ × ℕ)) : Bool :=
  @List.rec (ℕ × ℕ) (fun _ => Bool) true
    (fun q _ ih => @Bool.rec (fun _ => Bool) ih false (eqB p q)) l

/-- `true` iff the entries of `l` are pairwise distinct. -/
noncomputable def nodupK (l : List (ℕ × ℕ)) : Bool :=
  @List.rec (ℕ × ℕ) (fun _ => Bool) true
    (fun p rest ih => @Bool.rec (fun _ => Bool) false ih (freshK p rest)) l

/-- Everything the proof needs about a witness list for the `N` by `N` grid. -/
noncomputable def check (N : ℕ) (l : List (ℕ × ℕ)) : Bool :=
  noThreeK l && nodupK l && inGrid N l && Nat.beq l.length (2 * N)

/- ## Correctness of the checker -/

lemma rec_false_left {a c : Bool} :
    @Bool.rec (fun _ => Bool) a false c = true ↔ c = false ∧ a = true := by
  cases c <;> simp

lemma rec_false_right {a c : Bool} :
    @Bool.rec (fun _ => Bool) false a c = true ↔ c = true ∧ a = true := by
  cases c <;> simp

lemma crossB_iff (p q r : ℕ × ℕ) : crossB p q r = true ↔ Cross p q r := by
  unfold crossB Cross
  exact Iff.of_eq Nat.beq_eq

lemma cross_swap12 {p q r : ℕ × ℕ} : Cross q p r ↔ Cross p q r := by
  unfold Cross; constructor <;> intro h <;> linarith

lemma cross_swap23 {p q r : ℕ × ℕ} : Cross p r q ↔ Cross p q r := by
  unfold Cross; constructor <;> intro h <;> linarith

lemma allOkK_spec {p q : ℕ × ℕ} {l : List (ℕ × ℕ)} (h : allOkK p q l = true) :
    ∀ r ∈ l, ¬ Cross p q r := by
  induction l with
  | nil => simp
  | cons r0 rest ih =>
    have h' : @Bool.rec (fun _ => Bool) (allOkK p q rest) false (crossB p q r0) = true := h
    rw [rec_false_left] at h'
    intro r hr
    rcases List.mem_cons.mp hr with rfl | hr
    · rw [← crossB_iff, h'.1]; simp
    · exact ih h'.2 r hr

lemma pairsOkK_spec {p : ℕ × ℕ} {l : List (ℕ × ℕ)} (h : pairsOkK p l = true) :
    ∀ q ∈ l, ∀ r ∈ l, q ≠ r → ¬ Cross p q r := by
  induction l with
  | nil => simp
  | cons q0 rest ih =>
    have h' : @Bool.rec (fun _ => Bool) false (pairsOkK p rest) (allOkK p q0 rest) = true := h
    rw [rec_false_right] at h'
    intro q hq r hr hqr
    rcases List.mem_cons.mp hq with rfl | hq'
    · exact allOkK_spec h'.1 r (List.mem_of_ne_of_mem (Ne.symm hqr) hr)
    · rcases List.mem_cons.mp hr with rfl | hr'
      · rw [← cross_swap23]; exact allOkK_spec h'.1 q hq'
      · exact ih h'.2 q hq' r hr' hqr

lemma noThreeK_spec {l : List (ℕ × ℕ)} (h : noThreeK l = true) :
    ∀ x ∈ l, ∀ y ∈ l, ∀ z ∈ l, x ≠ y → x ≠ z → y ≠ z → ¬ Cross x y z := by
  induction l with
  | nil => simp
  | cons p rest ih =>
    have h' : @Bool.rec (fun _ => Bool) false (noThreeK rest) (pairsOkK p rest) = true := h
    rw [rec_false_right] at h'
    intro x hx y hy z hz hxy hxz hyz
    rcases List.mem_cons.mp hx with rfl | hx'
    · exact pairsOkK_spec h'.1 y (List.mem_of_ne_of_mem (Ne.symm hxy) hy)
        z (List.mem_of_ne_of_mem (Ne.symm hxz) hz) hyz
    rcases List.mem_cons.mp hy with rfl | hy'
    · rw [cross_swap12]
      exact pairsOkK_spec h'.1 x hx' z (List.mem_of_ne_of_mem (Ne.symm hyz) hz) hxz
    rcases List.mem_cons.mp hz with rfl | hz'
    · rw [← cross_swap23, cross_swap12]
      exact pairsOkK_spec h'.1 x hx' y hy' hxy
    exact ih h'.2 x hx' y hy' z hz' hxy hxz hyz

lemma eqB_iff (p q : ℕ × ℕ) : eqB p q = true ↔ p = q := by
  obtain ⟨a, b⟩ := p
  obtain ⟨c, d⟩ := q
  unfold eqB
  rw [rec_false_right, Nat.beq_eq, Nat.beq_eq, Prod.mk.injEq]

lemma freshK_spec {p : ℕ × ℕ} {l : List (ℕ × ℕ)} (h : freshK p l = true) : p ∉ l := by
  induction l with
  | nil => simp
  | cons q rest ih =>
    have h' : @Bool.rec (fun _ => Bool) (freshK p rest) false (eqB p q) = true := h
    rw [rec_false_left] at h'
    rw [List.mem_cons, not_or]
    refine ⟨fun hpq => ?_, ih h'.2⟩
    rw [← eqB_iff, h'.1] at hpq
    exact Bool.false_ne_true hpq

lemma nodupK_spec {l : List (ℕ × ℕ)} (h : nodupK l = true) : l.Nodup := by
  induction l with
  | nil => simp
  | cons p rest ih =>
    have h' : @Bool.rec (fun _ => Bool) false (nodupK rest) (freshK p rest) = true := h
    rw [rec_false_right] at h'
    exact List.nodup_cons.mpr ⟨freshK_spec h'.1, ih h'.2⟩

lemma inGrid_spec {N : ℕ} {l : List (ℕ × ℕ)} (h : inGrid N l = true) :
    ∀ p ∈ l, p.1 < N ∧ p.2 < N := by
  simpa [inGrid, List.all_eq_true] using h

/- ## From the checker to `AllowedSet` -/

lemma cross_of_collinear {P Q R : ℝ × ℝ} (h : Collinear ℝ ({P, Q, R} : Set (ℝ × ℝ))) :
    P.1 * Q.2 + Q.1 * R.2 + R.1 * P.2 = P.1 * R.2 + Q.1 * P.2 + R.1 * Q.2 := by
  rw [collinear_iff_of_mem (Set.mem_insert P _)] at h
  obtain ⟨v, hv⟩ := h
  obtain ⟨a, ha⟩ := hv Q (by simp)
  obtain ⟨b, hb⟩ := hv R (by simp)
  subst ha hb
  simp only [vadd_eq_add, Prod.fst_add, Prod.snd_add, Prod.smul_fst, Prod.smul_snd, smul_eq_mul]
  ring

lemma allowed_of {N : ℕ} {l : List (ℕ × ℕ)} (hl : noThreeK l = true)
    (hg : ∀ p ∈ l, p.1 < N ∧ p.2 < N) : Green72.AllowedSet 3 N l.toFinset where
  is_bounded i hi := hg i (List.mem_toFinset.mp hi)
  not_collinear := by
    intro t hts htc hcol
    obtain ⟨x, y, z, hxy, hxz, hyz, rfl⟩ := Finset.card_eq_three.mp htc
    have hx : x ∈ l := List.mem_toFinset.mp (hts (by simp))
    have hy : y ∈ l := List.mem_toFinset.mp (hts (by simp))
    have hz : z ∈ l := List.mem_toFinset.mp (hts (by simp))
    apply noThreeK_spec hl x hx y hy z hz hxy hxz hyz
    have hset : {r | ∃ i ∈ ({x, y, z} : Finset (ℕ × ℕ)), r = ((i.1 : ℝ), (i.2 : ℝ))} =
        ({((x.1 : ℝ), (x.2 : ℝ)), ((y.1 : ℝ), (y.2 : ℝ)), ((z.1 : ℝ), (z.2 : ℝ))} :
          Set (ℝ × ℝ)) := by
      ext r
      simp
    rw [hset] at hcol
    have h := cross_of_collinear hcol
    dsimp only at h
    unfold Cross
    exact_mod_cast h

theorem of_check {N : ℕ} {l : List (ℕ × ℕ)} (h : check N l = true) :
    Green72.NoKInLineFor 3 N := by
  simp only [check, Bool.and_eq_true] at h
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := h
  have hlen : l.length = 2 * N := Nat.eq_of_beq_eq_true h4
  unfold Green72.NoKInLineFor
  refine le_antisymm Green72.allowedSetSize_le ?_
  have hbdd : BddAbove {r | ∃ s, r = s.card ∧ Green72.AllowedSet 3 N s} := by
    refine ⟨N * N, ?_⟩
    rintro r ⟨s, rfl, hs⟩
    calc s.card ≤ (Finset.range N ×ˢ Finset.range N).card :=
          Finset.card_le_card fun i hi => by
            simpa [Finset.mem_product] using hs.is_bounded i hi
      _ = N * N := by simp
  have hcard : l.toFinset.card = (3 - 1) * N := by
    rw [List.toFinset_card_of_nodup (nodupK_spec h2), hlen]
  rw [← hcard]
  exact le_csSup hbdd ⟨l.toFinset, rfl, allowed_of h1 (inGrid_spec h3)⟩

/- ## The witnesses, checked by kernel reduction -/

theorem check3 : check 3 w3 = true := by decide +kernel

theorem check4 : check 4 w4 = true := by decide +kernel

theorem check5 : check 5 w5 = true := by decide +kernel

theorem check6 : check 6 w6 = true := by decide +kernel

theorem check7 : check 7 w7 = true := by decide +kernel

theorem check8 : check 8 w8 = true := by decide +kernel

theorem check9 : check 9 w9 = true := by decide +kernel

theorem check10 : check 10 w10 = true := by decide +kernel

theorem check11 : check 11 w11 = true := by decide +kernel

theorem check12 : check 12 w12 = true := by decide +kernel

theorem check13 : check 13 w13 = true := by decide +kernel

theorem check14 : check 14 w14 = true := by decide +kernel

theorem check15 : check 15 w15 = true := by decide +kernel

theorem check16 : check 16 w16 = true := by decide +kernel

theorem check17 : check 17 w17 = true := by decide +kernel

theorem check18 : check 18 w18 = true := by decide +kernel

theorem check19 : check 19 w19 = true := by decide +kernel

theorem check20 : check 20 w20 = true := by decide +kernel

theorem check21 : check 21 w21 = true := by decide +kernel

theorem check22 : check 22 w22 = true := by decide +kernel

theorem check23 : check 23 w23 = true := by decide +kernel

theorem check24 : check 24 w24 = true := by decide +kernel

theorem check25 : check 25 w25 = true := by decide +kernel

theorem check26 : check 26 w26 = true := by decide +kernel

theorem check27 : check 27 w27 = true := by decide +kernel

theorem check28 : check 28 w28 = true := by decide +kernel

theorem check29 : check 29 w29 = true := by decide +kernel

theorem check30 : check 30 w30 = true := by decide +kernel

theorem check31 : check 31 w31 = true := by decide +kernel

theorem check32 : check 32 w32 = true := by decide +kernel

theorem check33 : check 33 w33 = true := by decide +kernel

theorem check34 : check 34 w34 = true := by decide +kernel

theorem check35 : check 35 w35 = true := by decide +kernel

theorem check36 : check 36 w36 = true := by decide +kernel

theorem check37 : check 37 w37 = true := by decide +kernel

theorem check38 : check 38 w38 = true := by decide +kernel

theorem check39 : check 39 w39 = true := by decide +kernel

theorem check40 : check 40 w40 = true := by decide +kernel

theorem check41 : check 41 w41 = true := by decide +kernel

theorem check42 : check 42 w42 = true := by decide +kernel

theorem check43 : check 43 w43 = true := by decide +kernel

theorem check44 : check 44 w44 = true := by decide +kernel

theorem check45 : check 45 w45 = true := by decide +kernel

theorem check46 : check 46 w46 = true := by decide +kernel

theorem check47 : check 47 w47 = true := by decide +kernel

theorem check48 : check 48 w48 = true := by decide +kernel

theorem check49 : check 49 w49 = true := by decide +kernel

theorem check50 : check 50 w50 = true := by decide +kernel

theorem check51 : check 51 w51 = true := by decide +kernel

theorem check52 : check 52 w52 = true := by decide +kernel

theorem check53 : check 53 w53 = true := by decide +kernel

theorem check54 : check 54 w54 = true := by decide +kernel

theorem check55 : check 55 w55 = true := by decide +kernel

theorem check56 : check 56 w56 = true := by decide +kernel

theorem check57 : check 57 w57 = true := by decide +kernel

theorem check58 : check 58 w58 = true := by decide +kernel

theorem check59 : check 59 w59 = true := by decide +kernel

theorem check60 : check 60 w60 = true := by decide +kernel

end Green72Solution

open Green72Solution in
theorem green72_no_three_in_line_le {N : ℕ} (hN : 3 ≤ N) (hN' : N ≤ 60) :
    Green72.NoKInLineFor 3 N := by
  interval_cases N
  exacts [of_check check3, of_check check4, of_check check5, of_check check6, of_check check7,
    of_check check8, of_check check9, of_check check10, of_check check11, of_check check12,
    of_check check13, of_check check14, of_check check15, of_check check16, of_check check17,
    of_check check18, of_check check19, of_check check20, of_check check21, of_check check22,
    of_check check23, of_check check24, of_check check25, of_check check26, of_check check27,
    of_check check28, of_check check29, of_check check30, of_check check31, of_check check32,
    of_check check33, of_check check34, of_check check35, of_check check36, of_check check37,
    of_check check38, of_check check39, of_check check40, of_check check41, of_check check42,
    of_check check43, of_check check44, of_check check45, of_check check46, of_check check47,
    of_check check48, of_check check49, of_check check50, of_check check51, of_check check52,
    of_check check53, of_check check54, of_check check55, of_check check56, of_check check57,
    of_check check58, of_check check59, of_check check60]
