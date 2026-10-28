import FormalConjectures.Mathoverflow.«75792»

/-! Solution for the intcomplexity target. See `TASK.md` and `NOTES.md`. -/

namespace IntComplexitySol

open Mathoverflow75792

theorem one_add_case (n a b : Nat) (hn : 1 ≤ n) (ha : 1 ≤ a) (hb : 1 ≤ b)
    (ih : n ^ 3 ≤ 3 ^ b) : (1 + n) ^ 3 ≤ 3 ^ (a + b) := by
  rcases Nat.lt_or_ge n 3 with hlt | hge
  · interval_cases n
    · calc (1 + 1) ^ 3 ≤ 3 ^ 2 := by norm_num
        _ ≤ 3 ^ (a + b) := Nat.pow_le_pow_right (by norm_num) (by omega)
    · have hb2 : 2 ≤ b := by
        by_contra hc
        have : b = 1 := by omega
        subst this
        norm_num at ih
      calc (1 + 2) ^ 3 ≤ 3 ^ 3 := by norm_num
        _ ≤ 3 ^ (a + b) := Nat.pow_le_pow_right (by norm_num) (by omega)
  · have h1 : (1 + n) ^ 3 ≤ 3 * n ^ 3 := by
      obtain ⟨t, rfl⟩ : ∃ t, n = t + 3 := ⟨n - 3, by omega⟩
      ring_nf
      nlinarith [Nat.zero_le t, Nat.zero_le (t ^ 2), Nat.zero_le (t ^ 3)]
    have h2 : 3 ≤ 3 ^ a := by
      calc 3 = 3 ^ 1 := by norm_num
        _ ≤ 3 ^ a := Nat.pow_le_pow_right (by norm_num) ha
    calc (1 + n) ^ 3 ≤ 3 * n ^ 3 := h1
      _ ≤ 3 ^ a * 3 ^ b := Nat.mul_le_mul h2 ih
      _ = 3 ^ (a + b) := (pow_add 3 a b).symm

theorem add_case (m n a b : Nat) (hm : 1 ≤ m) (hn : 1 ≤ n) (ha : 1 ≤ a) (hb : 1 ≤ b)
    (ih₁ : m ^ 3 ≤ 3 ^ a) (ih₂ : n ^ 3 ≤ 3 ^ b) : (m + n) ^ 3 ≤ 3 ^ (a + b) := by
  rcases Nat.lt_or_ge m 2 with hm2 | hm2
  · have : m = 1 := by omega
    subst this
    exact one_add_case n a b hn ha hb ih₂
  rcases Nat.lt_or_ge n 2 with hn2 | hn2
  · have : n = 1 := by omega
    subst this
    rw [add_comm m 1, add_comm a b]
    exact one_add_case m b a hm hb ha ih₁
  have hle : m + n ≤ m * n := by nlinarith
  calc (m + n) ^ 3 ≤ (m * n) ^ 3 := Nat.pow_le_pow_left hle 3
    _ = m ^ 3 * n ^ 3 := mul_pow m n 3
    _ ≤ 3 ^ a * 3 ^ b := Nat.mul_le_mul ih₁ ih₂
    _ = 3 ^ (a + b) := (pow_add 3 a b).symm

theorem cube_le {m k : Nat} (h : Reachable m k) : m ^ 3 ≤ 3 ^ k := by
  induction h with
  | one => norm_num
  | @add m n a b h₁ h₂ ih₁ ih₂ =>
      obtain ⟨m', a', rfl, rfl⟩ := h₁.dec
      obtain ⟨n', b', rfl, rfl⟩ := h₂.dec
      exact add_case _ _ _ _ (by omega) (by omega) (by omega) (by omega) ih₁ ih₂
  | @mul m n a b _ _ ih₁ ih₂ =>
      calc (m * n) ^ 3 = m ^ 3 * n ^ 3 := mul_pow m n 3
        _ ≤ 3 ^ a * 3 ^ b := Nat.mul_le_mul ih₁ ih₂
        _ = 3 ^ (a + b) := (pow_add 3 a b).symm

theorem three_mul_le {n k : Nat} (h : Reachable (3 ^ n) k) : 3 * n ≤ k := by
  have h1 := cube_le h
  rw [← pow_mul, mul_comm n 3] at h1
  exact (Nat.pow_le_pow_iff_right (by norm_num)).mp h1

theorem complexity_three_pow_eq (n : Nat) (hn : 0 < n) : complexity (3 ^ n) = 3 * n :=
  (Reachable.pow 3 n (by norm_num) hn).complexity_eq fun _ hk hr =>
    absurd (three_mul_le hr) (by omega)

end IntComplexitySol

theorem complexity_of_three_pow : type_of% @Mathoverflow75792.complexity_three_pow := by
  show True ↔ _
  exact iff_of_true trivial IntComplexitySol.complexity_three_pow_eq
