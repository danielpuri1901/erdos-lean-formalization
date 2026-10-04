import FormalConjectures.OEIS.«77408»

/-!
# Sweep a077408: bounded check of the base-3 trajectory of 103

`OeisA77408.conjecture` says that no term `a n` is a base-3 palindrome.
Here we prove the bounded statement `∀ n < N, ¬ IsBasePalindrome 3 (a n)` for an explicit `N`.

Plan (one Lean block per line of the written argument in `sweep/a077408/NOTES.md`):
1. `revAux` reverses base-3 digits by structural recursion on a fuel argument (kernel friendly).
2. `revAux_eq`: `revAux` agrees with `Nat.ofDigits 3 (Nat.digits 3 n).reverse` plus a shifted accumulator.
3. `revBase_eq_revAux`: `revBase 3 n = revAux n n 0`.
4. `check x k` tests the next `k` terms from `x`; `check_sound` turns `check (a m) k = true` into the bounded claim.
5. `decide +kernel` evaluates `check 103 N`.

Part 2 (Lemma P and the reduction, `sweep/a077408/NOTES.md` section C1-C2):
6. `dig`, `len`, `pal_iff`: palindromes via the digit function `n / 3^i % 3`.
7. `noOverflow`, `overflow`: the carry arguments, on abstract digit sums `s`, carries `c`, digits `e`.
8. `carry`, `carry_step`: schoolbook addition of `x` and `revBase 3 x`.
9. `lemmaP`: `x + rev x` palindromic implies `x` carry-free or `x` palindromic;
   `lemmaP_converse`: carry-free implies `x + rev x` palindromic.
10. `conjecture_iff_not_carryFree`: the conjecture holds iff no `a n` is carry-free.
-/

namespace A077408Sweep

open OeisA77408

/-- Base-3 digit reversal with fuel: pushes the low digit of `n` onto `acc`. -/
def revAux : Nat → Nat → Nat → Nat
  | 0, _, acc => acc
  | fuel + 1, n, acc => if n = 0 then acc else revAux fuel (n / 3) (acc * 3 + n % 3)

/-- Step 2: with enough fuel, `revAux` computes the reversal, plus `acc` shifted past the digits. -/
theorem revAux_eq (fuel : Nat) : ∀ n acc : Nat, n ≤ fuel →
    revAux fuel n acc =
      Nat.ofDigits 3 (Nat.digits 3 n).reverse + acc * 3 ^ (Nat.digits 3 n).length := by
  induction fuel with
  | zero =>
    intro n acc h
    have hn : n = 0 := by omega
    subst hn
    simp [revAux]
  | succ f ih =>
    intro n acc h
    rcases Nat.eq_zero_or_pos n with hn | hn
    · subst hn
      simp [revAux]
    · rw [revAux, if_neg (by omega), ih (n / 3) _ (by omega), Nat.digits_def' (by norm_num) hn]
      simp only [List.reverse_cons, Nat.ofDigits_append, List.length_reverse, List.length_cons,
        Nat.ofDigits_singleton, pow_succ]
      ring

/-- Step 3: the imported `revBase 3` equals the fuelled reversal. -/
theorem revBase_eq_revAux (n : Nat) : revBase 3 n = revAux n n 0 := by
  rw [revAux_eq n n 0 le_rfl]
  simp [revBase]

/-- One reverse-and-add step, computed with `revAux`. -/
def step (x : Nat) : Nat := x + revAux x x 0

/-- `check x k = true` iff none of the `k` terms `x, step x, …` is a palindrome. -/
def check : Nat → Nat → Bool
  | _, 0 => true
  | x, k + 1 => (x != revAux x x 0) && check (step x) k

theorem a_succ_eq_step (m : Nat) : a (m + 1) = step (a m) := by
  rw [step, ← revBase_eq_revAux]
  rfl

/-- Step 4: soundness of `check` along the trajectory. -/
theorem check_sound (k : Nat) : ∀ m : Nat, check (a m) k = true →
    ∀ i < k, ¬ IsBasePalindrome 3 (a (m + i)) := by
  induction k with
  | zero => intro m _ i hi; omega
  | succ k ih =>
    intro m h i hi
    simp only [check, Bool.and_eq_true, bne_iff_ne, ne_eq] at h
    rcases i with _ | j
    · rw [IsBasePalindrome, revBase_eq_revAux]
      exact h.1
    · rw [← a_succ_eq_step] at h
      have := ih (m + 1) h.2 j (by omega)
      rwa [show m + 1 + j = m + (j + 1) by omega] at this

/-- Step 5: the kernel evaluates the checker on the first 1000 terms. -/
theorem check_103_1000 : check 103 1000 = true := by decide +kernel

/-- Bounded form of `OeisA77408.conjecture`: none of `a 0, …, a 999` is a base-3 palindrome. -/
theorem no_palindrome_below_1000 (n : Nat) (hn : n < 1000) : ¬ IsBasePalindrome 3 (a n) := by
  have h := check_sound 1000 0 check_103_1000 n hn
  rwa [Nat.zero_add] at h

/-! ## Part 2: Lemma P and the reduction -/

/-- Base-3 digit of `n` at position `i`. -/
def dig (n i : Nat) : Nat := n / 3 ^ i % 3

/-- Number of base-3 digits. -/
def len (n : Nat) : Nat := (Nat.digits 3 n).length

theorem dig_lt (n i : Nat) : dig n i < 3 := Nat.mod_lt _ (by norm_num)

theorem ofDigits_div_pow_mod (L : List Nat) (hL : ∀ l ∈ L, l < 3) (i : Nat) :
    Nat.ofDigits 3 L / 3 ^ i % 3 = L.getD i 0 := by
  induction L generalizing i with
  | nil => simp [Nat.ofDigits]
  | cons a L ih =>
    have ha : a < 3 := hL a (by simp)
    have hL' : ∀ l ∈ L, l < 3 := fun l hl => hL l (by simp [hl])
    rw [Nat.ofDigits_cons]
    cases i with
    | zero => simp; omega
    | succ i =>
      rw [pow_succ', ← Nat.div_div_eq_div_mul,
        show (a + 3 * Nat.ofDigits 3 L) / 3 = Nat.ofDigits 3 L by omega]
      simpa using ih hL' i

theorem dig_eq_getD (n i : Nat) : dig n i = (Nat.digits 3 n).getD i 0 := by
  rw [Nat.getD_digits _ _ (by norm_num)]; rfl

theorem dig_rev (x i : Nat) (hi : i < len x) : dig (revBase 3 x) i = dig x (len x - 1 - i) := by
  have hrev : ∀ l ∈ (Nat.digits 3 x).reverse, l < 3 := fun l hl =>
    Nat.digits_lt_base (by norm_num) (List.mem_reverse.mp hl)
  rw [dig, revBase, ofDigits_div_pow_mod _ hrev, List.getD_reverse _ hi, dig_eq_getD]
  rfl

theorem pal_iff (n : Nat) :
    IsBasePalindrome 3 n ↔ ∀ i < len n, dig n i = dig n (len n - 1 - i) := by
  constructor
  · intro h i hi
    have h1 : dig n i = dig (revBase 3 n) i := congrArg (fun m => dig m i) h
    rw [h1, dig_rev n i hi]
  · intro h
    have hE : (Nat.digits 3 n).reverse = Nat.digits 3 n := by
      apply List.ext_getElem (by simp)
      intro i h1 h2
      rw [List.getElem_reverse]
      have e1 := dig_eq_getD n i
      have e2 := dig_eq_getD n (len n - 1 - i)
      rw [List.getD_eq_getElem _ _ h2] at e1
      rw [List.getD_eq_getElem _ _ (by unfold len; omega)] at e2
      have := h i h2
      unfold len at this e2
      rw [← e1, ← e2]; exact this.symm
    unfold IsBasePalindrome revBase
    rw [hE, Nat.ofDigits_digits]


/-- No-overflow half of Lemma P, on abstract digit sums `s`, carries `c`, output digits `e`. -/
theorem noOverflow (L : Nat) (s c e : Nat → Nat)
    (hc0 : c 0 = 0) (hcL : c L = 0) (hcle : ∀ i, c i ≤ 1)
    (hs : ∀ i < L, s i = s (L - 1 - i))
    (he : ∀ i < L, e i = (s i + c i) % 3) (hcs : ∀ i < L, c (i + 1) = (s i + c i) / 3)
    (hpal : ∀ i < L, e i = e (L - 1 - i)) : ∀ i < L, s i ≤ 2 := by
  -- Step 1: carries into mirrored positions agree.
  have h1 : ∀ i < L, c i = c (L - 1 - i) := by
    intro i hi
    have := hpal i hi
    rw [he i hi, he (L - 1 - i) (by omega), ← hs i hi] at this
    have := hcle i; have := hcle (L - 1 - i)
    omega
  -- Step 2: carries out of mirrored positions agree.
  have h2 : ∀ i < L, c (i + 1) = c (L - i) := by
    intro i hi
    have := hcs (L - 1 - i) (by omega)
    rw [show L - 1 - i + 1 = L - i by omega, ← hs i hi, ← h1 i hi, ← hcs i hi] at this
    exact this.symm
  -- Step 3: every carry vanishes.
  have h3 : ∀ i ≤ L, c i = 0 := by
    intro i
    induction i using Nat.strong_induction_on with
    | _ i ih =>
      intro hi
      match i, ih, hi with
      | 0, _, _ => exact hc0
      | 1, _, hi => rw [h2 0 (by omega)]; simpa using hcL
      | j + 2, ih, hi =>
        rw [h2 (j + 1) (by omega), show L - (j + 1) = L - 1 - j by omega, ← h1 j (by omega)]
        exact ih j (by omega) (by omega)
  -- Step 4: no carry out of position i means s i ≤ 2.
  intro i hi
  have := hcs i hi
  rw [h3 (i + 1) (by omega), h3 i (by omega)] at this
  omega

/-- Overflow half of Lemma P: the mirrored digit sums are all 0 or 4. -/
theorem overflow (L : Nat) (s c e : Nat → Nat)
    (hc0 : c 0 = 0) (hcL : c L = 1) (hcle : ∀ i, c i ≤ 1) (hsle : ∀ i < L, s i ≤ 4)
    (hs : ∀ i < L, s i = s (L - 1 - i))
    (he : ∀ i < L, e i = (s i + c i) % 3) (heL : e L = 1)
    (hcs : ∀ i < L, c (i + 1) = (s i + c i) / 3)
    (hpal : ∀ i < L + 1, e i = e (L - i)) : ∀ m < L, s m = 4 * c (m + 1) ∧ c (m + 1) = c (L - m) := by
  intro m
  induction m using Nat.strong_induction_on with
  | _ m ih =>
    intro hm
    -- carry out of the mirror position L-1-m
    have hout := hcs (L - 1 - m) (by omega)
    rw [show L - 1 - m + 1 = L - m by omega, ← hs m hm] at hout
    have hcm := hcs m hm
    have hp := hpal m (by omega)
    rw [he m hm] at hp
    have := hcle m; have := hcle (L - m); have := hcle (L - 1 - m); have := hsle m hm
    match m, ih, hm, hout, hcm, hp with
    | 0, _, hm, hout, hcm, hp =>
      simp only [Nat.sub_zero, Nat.zero_add] at hout hcm hp ⊢
      rw [heL, hc0] at hp
      rw [hc0] at hcm
      rw [hcL] at hout ⊢
      have := hcle (L - 1)
      omega
    | j + 1, ih, hm, hout, hcm, hp =>
      obtain ⟨ih1, ih2⟩ := ih j (by omega) (by omega)
      have e1 : e (L - (j + 1)) = (s (L - (j + 1)) + c (L - (j + 1))) % 3 := he _ (by omega)
      have s1 : s (L - (j + 1)) = s j := by
        rw [hs j (by omega)]; congr 1; omega
      rw [e1, s1, ih1] at hp
      have hA := hcle (j + 1)
      have hB := hcle (L - 1 - (j + 1))
      have hC := hcle (L - (j + 1))
      have hS := hsle (j + 1) hm
      clear e1 s1 ih ih1 ih2 he hcs hs hpal hsle hcle
      generalize s (j + 1) = S at *
      generalize c (j + 1) = N at *
      generalize c (j + 1 + 1) = N' at *
      generalize c (L - (j + 1)) = Q at *
      generalize c (L - 1 - (j + 1)) = T at *
      subst hout hcm
      interval_cases S <;> interval_cases N <;> interval_cases T <;> omega

/-- Carry into position `k` when adding `x` and `r` in base 3. -/
def carry (x r k : Nat) : Nat := (x % 3 ^ k + r % 3 ^ k) / 3 ^ k

theorem carry_zero (x r : Nat) : carry x r 0 = 0 := by simp [carry, Nat.mod_one]

theorem carry_le (x r k : Nat) : carry x r k ≤ 1 := by
  have hP : 0 < 3 ^ k := by positivity
  have h1 := Nat.mod_lt x hP
  have h2 := Nat.mod_lt r hP
  have : (x % 3 ^ k + r % 3 ^ k) / 3 ^ k < 2 := by
    rw [Nat.div_lt_iff_lt_mul hP]; omega
  unfold carry; omega

theorem div_P (P t w : Nat) (hP : 0 < P) (hw : w < P) : (P * t + w) / P = t := by
  rw [Nat.add_comm, Nat.add_mul_div_left _ _ hP, Nat.div_eq_of_lt hw, Nat.zero_add]

/-- Schoolbook addition, one digit at a time. -/
theorem carry_step (x r k : Nat) :
    dig (x + r) k = (dig x k + dig r k + carry x r k) % 3 ∧
    carry x r (k + 1) = (dig x k + dig r k + carry x r k) / 3 := by
  have hP : 0 < 3 ^ k := by positivity
  have hc : carry x r (k + 1) = (x % 3 ^ (k + 1) + r % 3 ^ (k + 1)) / 3 ^ (k + 1) := rfl
  rw [Nat.mod_pow_succ, Nat.mod_pow_succ, pow_succ] at hc
  have hab : x % 3 ^ k + r % 3 ^ k = 3 ^ k * carry x r k + (x % 3 ^ k + r % 3 ^ k) % 3 ^ k :=
    (Nat.div_add_mod _ _).symm
  have hw : (x % 3 ^ k + r % 3 ^ k) % 3 ^ k < 3 ^ k := Nat.mod_lt _ hP
  have hx := Nat.div_add_mod x (3 ^ k)
  have hr := Nat.div_add_mod r (3 ^ k)
  unfold dig
  generalize 3 ^ k = P at *
  constructor
  · have e : x + r = P * (x / P + r / P + carry x r k) + (x % P + r % P) % P := by
      rw [Nat.mul_add, Nat.mul_add]; omega
    rw [e, div_P _ _ _ hP hw]
    omega
  · rw [hc]
    have e2 : x % P + P * (x / P % 3) + (r % P + P * (r / P % 3)) =
        P * (x / P % 3 + r / P % 3 + carry x r k) + (x % P + r % P) % P := by
      rw [Nat.mul_add, Nat.mul_add]; omega
    rw [e2, ← Nat.div_div_eq_div_mul, div_P _ _ _ hP hw]

/-- `x` is carry-free: every mirrored digit pair sums to at most 2. -/
def CarryFree (x : Nat) : Prop := ∀ i < len x, dig x i + dig x (len x - 1 - i) ≤ 2

/-- Lemma P (the direction used for the reduction). -/
theorem lemmaP (x : Nat) (hx : x ≠ 0) (h : IsBasePalindrome 3 (x + revBase 3 x)) :
    CarryFree x ∨ IsBasePalindrome 3 x := by
  have hb : 1 < 3 := by norm_num
  have hL1 : 1 ≤ len x := by
    have := (Nat.lt_digits_length_iff (k := 0) hb x).mpr (by simp; omega)
    unfold len; omega
  have hxlt : x < 3 ^ len x := (Nat.digits_length_le_iff (k := len x) hb x).mp le_rfl
  have hxge : 3 ^ (len x - 1) ≤ x := (Nat.lt_digits_length_iff hb x).mp (by unfold len at *; omega)
  have hrlt : revBase 3 x < 3 ^ len x := by
    have := Nat.ofDigits_lt_base_pow_length (l := (Nat.digits 3 x).reverse) hb
      (fun l hl => Nat.digits_lt_base hb (List.mem_reverse.mp hl))
    simpa [revBase, len] using this
  have hcL : carry x (revBase 3 x) (len x) = (x + revBase 3 x) / 3 ^ len x := by
    unfold carry; rw [Nat.mod_eq_of_lt hxlt, Nat.mod_eq_of_lt hrlt]
  have hP : 0 < 3 ^ len x := by positivity
  have hcLle := carry_le x (revBase 3 x) (len x)
  have hstep : ∀ i < len x,
      dig (x + revBase 3 x) i =
        ((dig x i + dig x (len x - 1 - i)) + carry x (revBase 3 x) i) % 3 ∧
      carry x (revBase 3 x) (i + 1) =
        ((dig x i + dig x (len x - 1 - i)) + carry x (revBase 3 x) i) / 3 := by
    intro i hi
    have := carry_step x (revBase 3 x) i
    rwa [dig_rev x i hi] at this
  have hs : ∀ i < len x, (fun i => dig x i + dig x (len x - 1 - i)) i =
      (fun i => dig x i + dig x (len x - 1 - i)) (len x - 1 - i) := by
    intro i hi
    simp only
    rw [show len x - 1 - (len x - 1 - i) = i by omega, Nat.add_comm]
  rw [pal_iff] at h
  rcases (show carry x (revBase 3 x) (len x) = 0 ∨ carry x (revBase 3 x) (len x) = 1 by omega)
    with h0 | h1
  · -- no overflow: the sum has `len x` digits
    have hylt : x + revBase 3 x < 3 ^ len x := by
      have : (x + revBase 3 x) / 3 ^ len x < 1 := by omega
      rwa [Nat.div_lt_iff_lt_mul hP, Nat.one_mul] at this
    have hy : len (x + revBase 3 x) = len x := by
      have a1 := (Nat.digits_length_le_iff (k := len x) hb (x + revBase 3 x)).mpr hylt
      have a2 := (Nat.lt_digits_length_iff (k := len x - 1) hb (x + revBase 3 x)).mpr (by omega)
      unfold len at *; omega
    left
    intro i hi
    exact noOverflow (len x) (fun i => dig x i + dig x (len x - 1 - i)) (carry x (revBase 3 x))
      (dig (x + revBase 3 x)) (carry_zero _ _) h0 (carry_le _ _) hs
      (fun i hi => (hstep i hi).1) (fun i hi => (hstep i hi).2)
      (fun i hi => by have := h i (by omega); rwa [hy] at this) i hi
  · -- overflow: the sum has `len x + 1` digits and leading digit 1
    have hyge : 3 ^ len x ≤ x + revBase 3 x := by
      have : 1 ≤ (x + revBase 3 x) / 3 ^ len x := by omega
      rwa [Nat.le_div_iff_mul_le hP, Nat.one_mul] at this
    have hy : len (x + revBase 3 x) = len x + 1 := by
      have a1 := (Nat.digits_length_le_iff (k := len x + 1) hb (x + revBase 3 x)).mpr
        (by rw [pow_succ]; omega)
      have a2 := (Nat.lt_digits_length_iff (k := len x) hb (x + revBase 3 x)).mpr hyge
      unfold len at *; omega
    have heL : dig (x + revBase 3 x) (len x) = 1 := by
      unfold dig; rw [← hcL, h1]
    have hsle : ∀ i < len x, (fun i => dig x i + dig x (len x - 1 - i)) i ≤ 4 := by
      intro i _; have := dig_lt x i; have := dig_lt x (len x - 1 - i); simp only; omega
    have key := overflow (len x) (fun i => dig x i + dig x (len x - 1 - i))
      (carry x (revBase 3 x)) (dig (x + revBase 3 x)) (carry_zero _ _) h1 (carry_le _ _) hsle hs
      (fun i hi => (hstep i hi).1) heL (fun i hi => (hstep i hi).2)
      (fun i hi => by
        have := h i (by omega)
        rwa [hy, show len x + 1 - 1 - i = len x - i by omega] at this)
    right
    rw [pal_iff]
    intro i hi
    have h4 := (key i hi).1
    have := carry_le x (revBase 3 x) (i + 1)
    have := dig_lt x i
    have := dig_lt x (len x - 1 - i)
    omega

/-- Lemma P, easy direction: a carry-free `x` gives a palindromic `x + rev x`. -/
theorem lemmaP_converse (x : Nat) (hcf : CarryFree x) : IsBasePalindrome 3 (x + revBase 3 x) := by
  by_cases hx : x = 0
  · subst hx; simp [IsBasePalindrome, revBase]
  have hb : 1 < 3 := by norm_num
  have hL1 : 1 ≤ len x := by
    have := (Nat.lt_digits_length_iff (k := 0) hb x).mpr (by simp; omega)
    unfold len; omega
  have hxlt : x < 3 ^ len x := (Nat.digits_length_le_iff (k := len x) hb x).mp le_rfl
  have hxge : 3 ^ (len x - 1) ≤ x := (Nat.lt_digits_length_iff hb x).mp (by unfold len at *; omega)
  have hrlt : revBase 3 x < 3 ^ len x := by
    have := Nat.ofDigits_lt_base_pow_length (l := (Nat.digits 3 x).reverse) hb
      (fun l hl => Nat.digits_lt_base hb (List.mem_reverse.mp hl))
    simpa [revBase, len] using this
  have hcL : carry x (revBase 3 x) (len x) = (x + revBase 3 x) / 3 ^ len x := by
    unfold carry; rw [Nat.mod_eq_of_lt hxlt, Nat.mod_eq_of_lt hrlt]
  have hP : 0 < 3 ^ len x := by positivity
  have hstep : ∀ i < len x,
      dig (x + revBase 3 x) i =
        ((dig x i + dig x (len x - 1 - i)) + carry x (revBase 3 x) i) % 3 ∧
      carry x (revBase 3 x) (i + 1) =
        ((dig x i + dig x (len x - 1 - i)) + carry x (revBase 3 x) i) / 3 := by
    intro i hi
    have := carry_step x (revBase 3 x) i
    rwa [dig_rev x i hi] at this
  -- no pair sums past 2, so no carry ever occurs
  have hc : ∀ i ≤ len x, carry x (revBase 3 x) i = 0 := by
    intro i
    induction i with
    | zero => intro _; exact carry_zero _ _
    | succ i ih =>
      intro hi
      rw [(hstep i (by omega)).2, ih (by omega)]
      have := hcf i (by omega)
      omega
  have hylt : x + revBase 3 x < 3 ^ len x := by
    have : (x + revBase 3 x) / 3 ^ len x < 1 := by rw [← hcL, hc _ le_rfl]; omega
    rwa [Nat.div_lt_iff_lt_mul hP, Nat.one_mul] at this
  have hy : len (x + revBase 3 x) = len x := by
    have a1 := (Nat.digits_length_le_iff (k := len x) hb (x + revBase 3 x)).mpr hylt
    have a2 := (Nat.lt_digits_length_iff (k := len x - 1) hb (x + revBase 3 x)).mpr (by omega)
    unfold len at *; omega
  rw [pal_iff, hy]
  intro i hi
  rw [(hstep i hi).1, (hstep (len x - 1 - i) (by omega)).1, hc i (by omega), hc _ (by omega),
    show len x - 1 - (len x - 1 - i) = i by omega]
  omega

/-- Reduction of `OeisA77408.conjecture`: it holds iff no term of the trajectory is carry-free. -/
theorem conjecture_iff_not_carryFree :
    (∀ n, ¬ IsBasePalindrome 3 (a n)) ↔ ∀ n, ¬ CarryFree (a n) := by
  constructor
  · intro h n hcf
    exact h (n + 1) (lemmaP_converse (a n) hcf)
  · intro hcf n
    induction n with
    | zero => exact no_palindrome_below_1000 0 (by norm_num)
    | succ n ih =>
      intro h
      have hne : a n ≠ 0 := by
        intro h0
        apply ih
        rw [h0]
        simp [IsBasePalindrome, revBase]
      rcases lemmaP (a n) hne h with h1 | h1
      · exact hcf n h1
      · exact ih h1

end A077408Sweep
