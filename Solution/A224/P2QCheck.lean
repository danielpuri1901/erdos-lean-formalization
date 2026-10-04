import FormalConjectures.OEIS.«224»

/-! a000224 deep attempt, route Q2 (family p²q): the two finite checks F1 and F2, by `decide +kernel`
on Bool checkers that loop with `List.range`. -/

namespace A224Deep

/-- Equation (E) of route Q2 as a Bool, with `A = (p^2 - p + 2) / 2`. -/
def q2E (p k w : ℕ) : Bool :=
  (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) * w ^ 2 + (p ^ 4 - 1)
    == (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2)) * w

/-- F1 checker: for every `p ≤ k w (w-1) + 1`: `p < 3`, or `p ∤ k w (w-1) + 1`, or (E) fails, or `p = 2w-1`. -/
def q2ChkSmall (k w : ℕ) : Bool :=
  (List.range (k * w * (w - 1) + 2)).all fun p =>
    p < 3 || (k * w * (w - 1) + 1) % p != 0 || !q2E p k w || p == 2 * w - 1

theorem q2ChkSmall_all : ∀ k, k < 16 → ∀ w, w < 16 → q2ChkSmall k w = true := by
  decide +kernel

/-- F1 unpacked. -/
theorem q2_small {p k w : ℕ} (hk : k ≤ 15) (hw : w ≤ 15) (hp3 : 3 ≤ p)
    (hdvd : p ∣ k * w * (w - 1) + 1)
    (hE : (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) * w ^ 2 + (p ^ 4 - 1)
      = (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2)) * w) :
    p = 2 * w - 1 := by
  have hc := q2ChkSmall_all k (by omega) w (by omega)
  unfold q2ChkSmall at hc
  rw [List.all_eq_true] at hc
  have hpN : p ≤ k * w * (w - 1) + 1 := Nat.le_of_dvd (by omega) hdvd
  have hmem : p ∈ List.range (k * w * (w - 1) + 2) := List.mem_range.mpr (by omega)
  have h := hc p hmem
  have hmod : (k * w * (w - 1) + 1) % p = 0 := Nat.mod_eq_zero_of_dvd hdvd
  simp only [q2E, Bool.or_eq_true, decide_eq_true_eq, bne_iff_ne, ne_eq, Bool.not_eq_true',
    beq_eq_false_iff_ne, beq_iff_eq] at h
  rcases h with ((h | h) | h) | h
  · omega
  · exact absurd hmod h
  · exact absurd hE h
  · exact h

/-- F2 checker: for `3 ≤ p`, `17 ≤ k`, `k A² < 4p⁴`, no `w ≤ B / δ` with `w ≥ 2` satisfies (E). -/
def q2ChkLarge (p k : ℕ) : Bool :=
  p < 3 || k < 17 || 4 * p ^ 4 ≤ k * ((p ^ 2 - p + 2) / 2) ^ 2 ||
  (List.range ((4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2))
      / (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) + 1)).all
    fun w => w < 2 || !q2E p k w

theorem q2ChkLarge_all : ∀ p, p < 32 → ∀ k, k < 21 → q2ChkLarge p k = true := by
  decide +kernel

/-- F2 unpacked. -/
theorem q2_large {p k w : ℕ} (hk1 : 17 ≤ k) (hk2 : k ≤ 20) (hp3 : 3 ≤ p) (hp31 : p ≤ 31)
    (hw : 2 ≤ w)
    (hδ : k * ((p ^ 2 - p + 2) / 2) ^ 2 < 4 * p ^ 4)
    (hwb : (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) * w
      < 4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2))
    (hE : (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) * w ^ 2 + (p ^ 4 - 1)
      = (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2)) * w) :
    False := by
  have hδpos : 0 < 4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2 := by omega
  have hwle : w ≤ (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2))
      / (4 * p ^ 4 - k * ((p ^ 2 - p + 2) / 2) ^ 2) := by
    rw [Nat.le_div_iff_mul_le hδpos, mul_comm]
    exact hwb.le
  have hc := q2ChkLarge_all p (by omega) k (by omega)
  unfold q2ChkLarge at hc
  simp only [Bool.or_eq_true, decide_eq_true_eq, List.all_eq_true] at hc
  rcases hc with ((h | h) | h) | h
  · omega
  · omega
  · omega
  · have h2 := h w (List.mem_range.mpr (by omega))
    simp only [q2E, Bool.not_eq_true',
      beq_eq_false_iff_ne, ne_eq] at h2
    rcases h2 with h2 | h2
    · omega
    · exact h2 hE


end A224Deep
