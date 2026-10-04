import FormalConjectures.OEIS.«112970»

/-! Solution for the a112970 target. See `TASK.md` and `NOTES.md`. -/

namespace A112970Sol

open OeisA112970

theorem a_zero : a 0 = 1 := by rw [a]; rfl

theorem a_one : a 1 = 1 := by rw [a]; rfl

theorem a_odd (k : Nat) : a (2 * k + 1) = a k := by
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · rw [a_one, a_zero]
  · have h1 : (2 * k + 1 = 0) = False := by simp
    have h2 : (2 * k + 1 = 1) = False := by simp; omega
    have h3 : ((2 * k + 1) % 2 = 1) = True := by simp
    have h4 : (2 * k + 1) / 2 = k := by omega
    rw [a]
    simp only [h1, h2, h3, h4, ite_true, ite_false]

theorem a_even (k : Nat) : a (2 * k) = a k + (if k < 2 then 0 else a (k - 2)) := by
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · simp [a_zero]
  · have h1 : (2 * k = 0) = False := by simp; omega
    have h2 : (2 * k = 1) = False := by simp
    have h3 : ((2 * k) % 2 = 1) = False := by simp
    have h4 : (2 * k) / 2 = k := by omega
    rw [a]
    simp only [h1, h2, h3, h4, ite_false]

theorem a_pow_sub_one (m : Nat) : a (2 ^ m - 1) = 1 := by
  induction m with
  | zero => simpa using a_zero
  | succ m ih =>
    have h : 2 ^ (m + 1) - 1 = 2 * (2 ^ m - 1) + 1 := by
      have := Nat.one_le_two_pow (n := m)
      rw [pow_succ]; omega
    rw [h, a_odd, ih]

theorem a_pow_sub_two (m : Nat) (hm : 1 ≤ m) : a (2 ^ m - 2) = (m + 1) / 2 := by
  induction m using Nat.strong_induction_on with
  | _ m ih =>
    rcases m with _ | _ | _ | m
    · omega
    · simpa using a_zero
    · have : a 2 = 1 := by simpa [a_zero, a_one] using a_even 1
      simpa using this
    · -- m + 3
      have hp : 2 ≤ 2 ^ (m + 1) := by
        have := Nat.one_le_two_pow (n := m); rw [pow_succ]; omega
      have e1 : 2 ^ (m + 3) - 2 = 2 * (2 ^ (m + 2) - 1) := by
        rw [pow_succ 2 (m + 2), pow_succ 2 (m + 1)]; omega
      have e2 : 2 ^ (m + 2) - 1 - 2 = 2 * (2 ^ (m + 1) - 2) + 1 := by
        rw [pow_succ 2 (m + 1)]; omega
      have e3 : ¬ (2 ^ (m + 2) - 1 < 2) := by
        rw [pow_succ 2 (m + 1)]; omega
      rw [e1, a_even, if_neg e3, e2, a_odd, a_pow_sub_one, ih (m + 1) (by omega) (by omega)]
      omega

theorem a_pow_succ (n : Nat) (hn : 1 ≤ n) : a (2 ^ (n + 1)) = a (2 ^ n) + a (2 ^ n - 2) := by
  have hp : ¬ (2 ^ n < 2) := by
    have := Nat.pow_le_pow_right (show 0 < 2 by norm_num) hn
    simp at this; omega
  rw [pow_succ, mul_comm, a_even, if_neg hp]

theorem arith_step (n : Nat) : n ^ 2 / 4 + (n + 1) / 2 = (n + 1) ^ 2 / 4 := by
  rcases Nat.even_or_odd' n with ⟨j, rfl | rfl⟩
  · have e1 : (2 * j) ^ 2 = 4 * (j * j) := by ring
    have e2 : (2 * j + 1) ^ 2 = 4 * (j * j + j) + 1 := by ring
    rw [e1, e2]; omega
  · have e1 : (2 * j + 1) ^ 2 = 4 * (j * j + j) + 1 := by ring
    have e2 : (2 * j + 1 + 1) ^ 2 = 4 * (j * j + 2 * j + 1) := by ring
    rw [e1, e2]; omega

theorem main (n : Nat) : a (2 ^ n) = n ^ 2 / 4 + 1 := by
  induction n with
  | zero => simpa using a_one
  | succ n ih =>
    rcases Nat.eq_zero_or_pos n with rfl | hn
    · simpa [a_zero, a_one] using a_even 1
    · rw [a_pow_succ n hn, ih, a_pow_sub_two n hn, ← arith_step n]
      omega

end A112970Sol

theorem a112970_power_of_two : type_of% @OeisA112970.conjecture1_value :=
  @A112970Sol.main
