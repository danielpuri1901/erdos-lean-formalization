import FormalConjectures.OEIS.«4290»

/-! Sweep work for a004290: the case k ≤ 1 of `OeisA4290.conjecture`. -/

namespace SweepA4290

open OeisA4290

/-- The defining set of `a n`. -/
def S (n : Nat) : Set Nat := { m : Nat | 0 < m ∧ n ∣ m ∧ ∀ d ∈ Nat.digits 10 m, d = 0 ∨ d = 1 }

/-- Upper bound from a witness. -/
lemma a_le_of_mem {n w : Nat} (h : w ∈ S n) : a n ≤ w := Nat.sInf_le h

/-- A list of 0/1 digits has sum at most its length. -/
lemma sum_le_length (L : List Nat) (h : ∀ d ∈ L, d = 0 ∨ d = 1) : L.sum ≤ L.length := by
  induction L with
  | nil => simp
  | cons x t ih =>
    simp only [List.sum_cons, List.length_cons]
    have hx : x ≤ 1 := by rcases h x (by simp) with rfl | rfl <;> omega
    have ht := ih (fun d hd => h d (by simp [hd]))
    omega

/-- A list with all entries zero has `ofDigits` zero. -/
lemma ofDigits_eq_zero (L : List Nat) (h : ∀ d ∈ L, d = 0) : Nat.ofDigits 10 L = 0 := by
  induction L with
  | nil => simp
  | cons x t ih =>
    rw [Nat.ofDigits_cons, h x (by simp), ih (fun d hd => h d (by simp [hd]))]

/-- A positive multiple of 9 with 0/1 digits is at least 10^8. -/
lemma ge_of_nine_dvd {m : Nat} (hm : m ∈ S 9) : 10 ^ 8 ≤ m := by
  obtain ⟨hpos, h9, hdig⟩ := hm
  -- s = digit sum; 9 ∣ s
  have hs9 : 9 ∣ (Nat.digits 10 m).sum := (Nat.nine_dvd_iff m).mp h9
  -- s ≤ number of digits
  have hsl : (Nat.digits 10 m).sum ≤ (Nat.digits 10 m).length := sum_le_length _ hdig
  -- s > 0, else every digit is 0 and m = 0
  have hs0 : (Nat.digits 10 m).sum ≠ 0 := by
    intro hz
    have hall : ∀ d ∈ Nat.digits 10 m, d = 0 := fun d hd => List.sum_eq_zero_iff.mp hz d hd
    have := Nat.ofDigits_digits 10 m
    rw [ofDigits_eq_zero _ hall] at this
    omega
  -- so s ≥ 9 and m has at least 9 digits
  have hlen : 9 ≤ (Nat.digits 10 m).length := by
    obtain ⟨c, hc⟩ := hs9
    rcases c with _ | c
    · omega
    · omega
  have hb := Nat.base_pow_length_digits_le 10 m (by norm_num) (by omega)
  have : 10 ^ 9 ≤ 10 ^ (Nat.digits 10 m).length := Nat.pow_le_pow_right (by norm_num) hlen
  omega

lemma R9_mem : 111111111 ∈ S 9 := by
  refine ⟨by norm_num, by norm_num, ?_⟩
  norm_num

lemma a_nine_ge : 10 ^ 8 ≤ a 9 := by
  show 10 ^ 8 ≤ sInf (S 9)
  exact le_csInf ⟨_, R9_mem⟩ (fun m hm => ge_of_nine_dvd hm)

/-- Witnesses: a n ≤ 1110 for 1 ≤ n ≤ 8. -/
lemma a_small (n : Nat) (h1 : 1 ≤ n) (h8 : n ≤ 8) : a n ≤ 1110 := by
  interval_cases n
  · exact (a_le_of_mem (w := 1) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)

/-- `OeisA4290.conjecture` for k = 0 (vacuous) and k = 1 (n < 9: a n ≤ 1110 < 10^8 ≤ a 9). -/
theorem conjecture_le_one (k : Nat) (hk : k ≤ 1) : ∀ n < 10 ^ k - 1, a n < a (10 ^ k - 1) := by
  intro n hn
  interval_cases k
  · simp at hn
  · have h9 := a_nine_ge
    norm_num at hn ⊢
    rcases Nat.eq_zero_or_pos n with rfl | hpos
    · rw [a_0]; omega
    · have := a_small n hpos (by omega)
      omega

/- ## k = 2 -/

/-- For a 0/1 list, the alternating sum is bounded by the sum and has the same parity. -/
lemma alt_props (L : List Nat) (h : ∀ d ∈ L, d = 0 ∨ d = 1) :
    |(L.map (fun n : Nat => (n : Int))).alternatingSum| ≤ (L.sum : Int) ∧
    2 ∣ (L.sum : Int) - (L.map (fun n : Nat => (n : Int))).alternatingSum := by
  induction L with
  | nil => simp
  | cons x t ih =>
    obtain ⟨ih1, ih2⟩ := ih (fun d hd => h d (by simp [hd]))
    have hx : x = 0 ∨ x = 1 := h x (by simp)
    simp only [List.map_cons, List.alternatingSum_cons, List.sum_cons, Nat.cast_add]
    set A := (t.map (fun n : Nat => (n : Int))).alternatingSum
    obtain ⟨c, hc⟩ := ih2
    refine ⟨?_, ⟨c + A, by linarith⟩⟩
    rw [abs_le] at ih1 ⊢
    rcases hx with rfl | rfl
    · simp only [Nat.cast_zero]; constructor <;> linarith [ih1.1, ih1.2]
    · simp only [Nat.cast_one]; constructor <;> linarith [ih1.1, ih1.2]

/-- A positive multiple of 99 with 0/1 digits is at least 10^17. -/
lemma ge_of_99_dvd {m : Nat} (hm : m ∈ S 99) : 10 ^ 17 ≤ m := by
  obtain ⟨hpos, h99, hdig⟩ := hm
  have h9 : 9 ∣ m := Nat.dvd_trans (by norm_num) h99
  have h11 : 11 ∣ m := Nat.dvd_trans (by norm_num) h99
  have hs9 : 9 ∣ (Nat.digits 10 m).sum := (Nat.nine_dvd_iff m).mp h9
  have hA11 := (Nat.eleven_dvd_iff).mp h11
  have hsl : (Nat.digits 10 m).sum ≤ (Nat.digits 10 m).length := sum_le_length _ hdig
  have hs0 : (Nat.digits 10 m).sum ≠ 0 := by
    intro hz
    have hall : ∀ d ∈ Nat.digits 10 m, d = 0 := fun d hd => List.sum_eq_zero_iff.mp hz d hd
    have := Nat.ofDigits_digits 10 m
    rw [ofDigits_eq_zero _ hall] at this
    omega
  obtain ⟨hab, hpar⟩ := alt_props _ hdig
  set A := ((Nat.digits 10 m).map (fun n : Nat => (n : Int))).alternatingSum
  set s := (Nat.digits 10 m).sum
  -- s = 9 is impossible: then |A| ≤ 9 and 11 ∣ A force A = 0, but s - A is even
  have hne9 : s ≠ 9 := by
    intro h9'
    rw [h9'] at hab hpar
    rw [abs_le] at hab
    obtain ⟨e, he⟩ := hA11
    obtain ⟨f, hf⟩ := hpar
    push_cast at hab hf
    omega
  have hlen : 18 ≤ (Nat.digits 10 m).length := by
    obtain ⟨c, hc⟩ := hs9
    rcases c with _ | _ | c
    · omega
    · omega
    · omega
  have hb := Nat.base_pow_length_digits_le 10 m (by norm_num) (by omega)
  have : 10 ^ 18 ≤ 10 ^ (Nat.digits 10 m).length := Nat.pow_le_pow_right (by norm_num) hlen
  omega

lemma R18_mem : 111111111111111111 ∈ S 99 := by
  refine ⟨by norm_num, by norm_num, ?_⟩
  norm_num

lemma a_99_ge : 10 ^ 17 ≤ a 99 := by
  show 10 ^ 17 ≤ sInf (S 99)
  exact le_csInf ⟨_, R18_mem⟩ (fun m hm => ge_of_99_dvd hm)

/-- Witnesses (exact values of a n, from BFS): a n < 10^17 for 1 ≤ n ≤ 98. -/
lemma a_small_99 (n : Nat) (h1 : 1 ≤ n) (h98 : n ≤ 98) : a n ≤ 10 ^ 17 - 1 := by
  interval_cases n
  · exact (a_le_of_mem (w := 1) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111111111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1111111110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 110101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1101111111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1101101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11111111100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 110010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 101010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1101101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1111111110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1101010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1100001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11011111110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1001000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11011010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11011111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1111011111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1000000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1111110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1101011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10000101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111111111000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1100100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 101010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10010011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1111111101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 101011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1010100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 111010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11011010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11010111) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11010101) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1111111110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 1001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11010100) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 10000011) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 100110) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 110010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11100000) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11100001) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)
  · exact (a_le_of_mem (w := 11000010) ⟨by norm_num, by norm_num, by norm_num⟩).trans (by norm_num)

/-- `OeisA4290.conjecture` for k ≤ 2. -/
theorem conjecture_le_two (k : Nat) (hk : k ≤ 2) : ∀ n < 10 ^ k - 1, a n < a (10 ^ k - 1) := by
  intro n hn
  rcases Nat.lt_or_ge k 2 with hk2 | hk2
  · exact conjecture_le_one k (by omega) n hn
  · obtain rfl : k = 2 := by omega
    have h99 := a_99_ge
    norm_num at hn ⊢
    rcases Nat.eq_zero_or_pos n with rfl | hpos
    · rw [a_0]; omega
    · have := a_small_99 n hpos (by omega)
      omega

/- ## General lower bound: 0/1 multiples of 10^k - 1 are ≥ 10^(9k-1) -/

/-- Decimal digit sum. -/
def ds (n : Nat) : Nat := (Nat.digits 10 n).sum

lemma ds_eq (n : Nat) : ds n = n % 10 + ds (n / 10) := by
  rcases Nat.eq_zero_or_pos n with rfl | hn
  · simp [ds]
  · unfold ds
    rw [Nat.digits_def' (by norm_num) hn, List.sum_cons]

lemma ds_one : ds 1 = 1 := by simp [ds]

/-- Digit sum is subadditive. -/
lemma ds_add_le (N : Nat) : ∀ a b, a + b = N → ds (a + b) ≤ ds a + ds b := by
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    intro a b hN
    rcases Nat.eq_zero_or_pos (a + b) with h0 | hpos
    · have ha : a = 0 := by omega
      have hb : b = 0 := by omega
      subst ha hb; simp
    · rw [ds_eq (a + b), ds_eq a, ds_eq b]
      by_cases hc : a % 10 + b % 10 < 10
      · have h1 : (a + b) / 10 = a / 10 + b / 10 := by omega
        have h2 : (a + b) % 10 = a % 10 + b % 10 := by omega
        rw [h1, h2]
        have := ih (a / 10 + b / 10) (by omega) (a / 10) (b / 10) rfl
        omega
      · have h1 : (a + b) / 10 = (a / 10 + b / 10) + 1 := by omega
        have h2 : (a + b) % 10 + 10 = a % 10 + b % 10 := by omega
        rw [h1]
        have e1 := ih (a / 10 + b / 10 + 1) (by omega) (a / 10 + b / 10) 1 rfl
        have e2 := ih (a / 10 + b / 10) (by omega) (a / 10) (b / 10) rfl
        rw [ds_one] at e1
        omega

/-- Splitting off the low k digits. -/
lemma ds_split (k : Nat) : ∀ H L, L < 10 ^ k → ds (10 ^ k * H + L) = ds H + ds L := by
  induction k with
  | zero =>
    intro H L hL
    have hL0 : L = 0 := by simpa using hL
    subst hL0; simp [ds]
  | succ k ih =>
    intro H L hL
    rw [ds_eq (10 ^ (k + 1) * H + L), ds_eq L]
    have h1 : (10 ^ (k + 1) * H + L) % 10 = L % 10 := by
      rw [pow_succ, mul_comm (10 ^ k) 10, mul_assoc, Nat.mul_add_mod]
    have h2 : (10 ^ (k + 1) * H + L) / 10 = 10 ^ k * H + L / 10 := by
      rw [pow_succ, mul_comm (10 ^ k) 10, mul_assoc, Nat.mul_add_div (by norm_num)]
    have hL' : L / 10 < 10 ^ k := by
      rw [pow_succ] at hL; omega
    rw [h1, h2, ih H (L / 10) hL']
    omega

lemma ds_pow_sub_one (k : Nat) : ds (10 ^ k - 1) = 9 * k := by
  induction k with
  | zero => simp [ds]
  | succ k ih =>
    have hX : 1 ≤ 10 ^ k := Nat.one_le_pow _ _ (by norm_num)
    rw [ds_eq, pow_succ]
    have h1 : (10 ^ k * 10 - 1) % 10 = 9 := by omega
    have h2 : (10 ^ k * 10 - 1) / 10 = 10 ^ k - 1 := by omega
    rw [h1, h2, ih]
    ring

/-- Every positive multiple of 10^k - 1 has digit sum at least 9k (k ≥ 1). -/
lemma ds_of_dvd (k : Nat) (hk : 1 ≤ k) (N : Nat) : 0 < N → (10 ^ k - 1) ∣ N → 9 * k ≤ ds N := by
  have hX : 10 ≤ 10 ^ k := by
    calc 10 = 10 ^ 1 := by norm_num
      _ ≤ 10 ^ k := Nat.pow_le_pow_right (by norm_num) hk
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    intro hpos hdvd
    by_cases hlt : N < 10 ^ k
    · obtain ⟨q, hq⟩ := hdvd
      have hq1 : q = 1 := by
        rcases q with _ | _ | q
        · simp at hq; omega
        · rfl
        · exfalso
          have : (10 ^ k - 1) * (q + 1 + 1) ≥ (10 ^ k - 1) * 2 := Nat.mul_le_mul_left _ (by omega)
          omega
      subst hq1
      rw [hq, mul_one, ds_pow_sub_one]
    · replace hlt := not_lt.mp hlt
      set H := N / 10 ^ k
      set L := N % 10 ^ k
      have hN : N = 10 ^ k * H + L := (Nat.div_add_mod N (10 ^ k)).symm
      have hL : L < 10 ^ k := Nat.mod_lt _ (by omega)
      have hH : 1 ≤ H := (Nat.le_div_iff_mul_le (by omega)).mpr (by omega)
      have hlt2 : H + L < N := by
        have : 10 * H ≤ 10 ^ k * H := Nat.mul_le_mul_right _ hX
        omega
      have hdvd2 : (10 ^ k - 1) ∣ H + L := by
        have h3 : N = (10 ^ k - 1) * H + (H + L) := by
          rw [hN]
          have : 10 ^ k * H = (10 ^ k - 1) * H + H := by
            rw [Nat.sub_mul, one_mul, Nat.sub_add_cancel (Nat.le_mul_of_pos_left H (by omega))]
          omega
        have := (Nat.dvd_add_right (Dvd.intro H rfl)).mp (h3 ▸ hdvd)
        exact this
      have h1 := ih (H + L) hlt2 (by omega) hdvd2
      have h2 := ds_add_le (H + L) H L rfl
      rw [hN, ds_split k H L hL]
      omega

/-- Every 0/1 multiple of 10^k - 1 (k ≥ 1) is at least 10^(9k-1). -/
lemma ge_of_mem_rep (k : Nat) (hk : 1 ≤ k) {m : Nat} (hm : m ∈ S (10 ^ k - 1)) :
    10 ^ (9 * k - 1) ≤ m := by
  obtain ⟨hpos, hdvd, hdig⟩ := hm
  have h1 := ds_of_dvd k hk m hpos hdvd
  have h2 : ds m ≤ (Nat.digits 10 m).length := sum_le_length _ hdig
  have hb := Nat.base_pow_length_digits_le 10 m (by norm_num) (by omega)
  have h3 : 10 ^ (9 * k) ≤ 10 ^ (Nat.digits 10 m).length := Nat.pow_le_pow_right (by norm_num) (by omega)
  have h4 : 10 ^ (9 * k) = 10 * 10 ^ (9 * k - 1) := by
    rw [← pow_succ']; congr 1; omega
  omega

/-- Proved reduction: if `S (10^k - 1)` is nonempty (true: it contains the repunit R_{9k})
and every `0 < n < 10^k - 1` has a 0/1 multiple below `10^(9k-1)`, the conjecture holds at k. -/
theorem conjecture_of_witnesses (k : Nat) (hk : 1 ≤ k) (hne : (S (10 ^ k - 1)).Nonempty)
    (hw : ∀ n, 0 < n → n < 10 ^ k - 1 → ∃ w ∈ S n, w < 10 ^ (9 * k - 1)) :
    ∀ n < 10 ^ k - 1, a n < a (10 ^ k - 1) := by
  intro n hn
  have hlow : 10 ^ (9 * k - 1) ≤ a (10 ^ k - 1) :=
    le_csInf hne (fun m hm => ge_of_mem_rep k hk hm)
  rcases Nat.eq_zero_or_pos n with rfl | hpos
  · rw [a_0]; exact lt_of_lt_of_le (by positivity) hlow
  · obtain ⟨w, hwS, hwlt⟩ := hw n hpos hn
    exact lt_of_le_of_lt (a_le_of_mem hwS) (lt_of_lt_of_le hwlt hlow)

/- ## The repunit R_{9k} lies in S (10^k - 1), so a (10^k - 1) ≥ 10^(9k-1) unconditionally -/

/-- Repunit with j ones. -/
def rep : Nat → Nat
  | 0 => 0
  | j + 1 => 10 * rep j + 1

lemma rep_digits (j : Nat) : ∀ d ∈ Nat.digits 10 (rep j), d = 0 ∨ d = 1 := by
  induction j with
  | zero => simp [rep]
  | succ j ih =>
    intro d hd
    rw [rep, Nat.digits_def' (by norm_num) (by omega)] at hd
    have h1 : (10 * rep j + 1) % 10 = 1 := by omega
    have h2 : (10 * rep j + 1) / 10 = rep j := by omega
    rw [h1, h2] at hd
    rcases List.mem_cons.mp hd with h | h
    · exact Or.inr h
    · exact ih d h

lemma nine_rep (j : Nat) : 9 * rep j + 1 = 10 ^ j := by
  induction j with
  | zero => simp [rep]
  | succ j ih => rw [rep, pow_succ]; omega

lemma rep_add (a b : Nat) : rep (a + b) = rep a * 10 ^ b + rep b := by
  induction b with
  | zero => simp [rep]
  | succ b ih => rw [← Nat.add_assoc, rep, rep, ih, pow_succ]; ring

lemma rep_mul_modEq (k i : Nat) : rep (k * i) ≡ i * rep k [MOD 10 ^ k - 1] := by
  have h10 : 10 ^ k ≡ 1 [MOD 10 ^ k - 1] := by
    have hX : 1 ≤ 10 ^ k := Nat.one_le_pow _ _ (by norm_num)
    exact (Nat.modEq_iff_dvd' hX).mpr dvd_rfl |>.symm
  induction i with
  | zero => simp [rep]; rfl
  | succ i ih =>
    rw [Nat.mul_succ, rep_add]
    calc rep (k * i) * 10 ^ k + rep k ≡ i * rep k * 1 + rep k [MOD 10 ^ k - 1] :=
          Nat.ModEq.add_right _ (Nat.ModEq.mul ih h10)
      _ = (i + 1) * rep k := by ring

lemma rep_mem (k : Nat) (hk : 1 ≤ k) : rep (k * 9) ∈ S (10 ^ k - 1) := by
  refine ⟨?_, ?_, rep_digits _⟩
  · have := nine_rep (k * 9)
    have : 1 < 10 ^ (k * 9) := Nat.one_lt_pow (by omega) (by norm_num)
    omega
  · have h1 := rep_mul_modEq k 9
    have h2 : 9 * rep k = 10 ^ k - 1 := by have := nine_rep k; omega
    rw [h2] at h1
    exact (Nat.modEq_zero_iff_dvd).mp (h1.trans ((Nat.modEq_zero_iff_dvd).mpr dvd_rfl))

lemma a_rep_ge (k : Nat) (hk : 1 ≤ k) : 10 ^ (9 * k - 1) ≤ a (10 ^ k - 1) :=
  le_csInf ⟨_, rep_mem k hk⟩ (fun _ hm => ge_of_mem_rep k hk hm)

/-- Proved reduction (unconditional form): the conjecture at k ≥ 1 follows from upper bounds
alone: every `0 < n < 10^k - 1` has a 0/1 multiple below `10^(9k-1)`. -/
theorem conjecture_of_witnesses' (k : Nat) (hk : 1 ≤ k)
    (hw : ∀ n, 0 < n → n < 10 ^ k - 1 → ∃ w ∈ S n, w < 10 ^ (9 * k - 1)) :
    ∀ n < 10 ^ k - 1, a n < a (10 ^ k - 1) :=
  conjecture_of_witnesses k hk ⟨_, rep_mem k hk⟩ hw

/- ## k = 3 via the reduction: witnesses (exact a n from BFS) below 10^26 for n < 999 -/

lemma wit3_0 (n : Nat) (h1 : 1 ≤ n) (h2 : n ≤ 125) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨1, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

lemma wit3_1 (n : Nat) (h1 : 126 ≤ n) (h2 : n ≤ 250) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨11110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010111010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111111111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101111111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001111001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

lemma wit3_2 (n : Nat) (h1 : 251 ≤ n) (h2 : n ≤ 375) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨110001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111011111111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000000111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011001011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111001111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

lemma wit3_3 (n : Nat) (h1 : 376 ≤ n) (h2 : n ≤ 500) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨10011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111111111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011111110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100001000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001111101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101010101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111111111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

lemma wit3_4 (n : Nat) (h1 : 501 ≤ n) (h2 : n ≤ 625) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨100000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111011111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000111001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110011110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011011011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10100000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110111111111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001011010101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011111011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101001111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

lemma wit3_5 (n : Nat) (h1 : 626 ≤ n) (h2 : n ≤ 750) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨110010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010110101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110001010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000001111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101000100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001111001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101100110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110010111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101000011111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101000000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101100010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111111001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110011110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011100111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

lemma wit3_6 (n : Nat) (h1 : 751 ≤ n) (h2 : n ≤ 875) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨1111000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110010101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011101011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101101001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10111000011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101110001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011011101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101011010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110100010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101100100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110011110111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111111111111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111010000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000100001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101111101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011101110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111010111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100110000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001100110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10100100010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010011101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101111111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110001110101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111111100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110011101111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

lemma wit3_7 (n : Nat) (h1 : 876 ≤ n) (h2 : n ≤ 998) : ∃ w ∈ S n, w < 10 ^ 26 := by
  interval_cases n
  · exact ⟨111011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010111010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011101100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110011111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111111111111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100001111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100001110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101111001001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100010110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011111111111111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101000011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111100001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000010001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110001111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111011010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010111010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110101000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011111000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10100100101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101101101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110110100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101001100011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101111111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10110111001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100001011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1101111011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110111110000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101110101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111110110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10101011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001111101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100111011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101011011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111011010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111011110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111111100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111010111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11110100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011001110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10010000101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11011000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111101101011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10011111011100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010010001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11001101110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1010100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1000000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1100111111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111011, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1001010101010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11000111101, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨10001100111000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11010001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111010010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100101000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨100000000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11111011111101001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1111111111111111110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨11101100000, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1011000111, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨110001010, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨1110000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110000100, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111110000001, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩
  · exact ⟨111000000110, ⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

/-- `OeisA4290.conjecture` for k = 3. -/
theorem conjecture_three : ∀ n < 10 ^ 3 - 1, a n < a (10 ^ 3 - 1) := by
  refine conjecture_of_witnesses' 3 (by norm_num) (fun n h0 hn => ?_)
  norm_num at hn ⊢
  rcases Nat.lt_or_ge n 126 with h | h
  · exact wit3_0 n (by omega) (by omega)
  rcases Nat.lt_or_ge n 251 with h | h
  · exact wit3_1 n (by omega) (by omega)
  rcases Nat.lt_or_ge n 376 with h | h
  · exact wit3_2 n (by omega) (by omega)
  rcases Nat.lt_or_ge n 501 with h | h
  · exact wit3_3 n (by omega) (by omega)
  rcases Nat.lt_or_ge n 626 with h | h
  · exact wit3_4 n (by omega) (by omega)
  rcases Nat.lt_or_ge n 751 with h | h
  · exact wit3_5 n (by omega) (by omega)
  rcases Nat.lt_or_ge n 876 with h | h
  · exact wit3_6 n (by omega) (by omega)
  exact wit3_7 n (by omega) (by omega)

/-- `OeisA4290.conjecture` for every k ≤ 3. -/
theorem conjecture_le_three (k : Nat) (hk : k ≤ 3) : ∀ n < 10 ^ k - 1, a n < a (10 ^ k - 1) := by
  rcases Nat.lt_or_ge k 3 with h | h
  · exact conjecture_le_two k (by omega)
  · obtain rfl : k = 3 := by omega
    exact conjecture_three

end SweepA4290
