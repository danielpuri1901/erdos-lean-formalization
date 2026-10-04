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

end SweepA4290
