import FormalConjectures.OEIS.«224»

/-! a000224 deep attempt, family p^e q (uniform, `4 ≤ e`): the three finite checks, by
`decide +kernel` on Bool checkers that loop with `List.range` (same method as `P3QCheck.lean`). -/

namespace A224Deep

/-- `c` of the uniform family: `p + 2` for even `e`, `2p + 1` for odd `e`. -/
def q4c (p e : ℕ) : ℕ := if e % 2 = 0 then p + 2 else 2 * p + 1
/-- Closed form of `a (p^e)`: `(p * p^e + c) / (2 (p+1))`. -/
def q4A (p e : ℕ) : ℕ := (p * p ^ e + q4c p e) / (2 * (p + 1))
/-- The mod-p constraint number. -/
def q4N (e k w : ℕ) : ℕ := if e % 2 = 0 then k * w * (w - 1) + 1 else k * w * (w - 2) + 4
/-- Equation (E) as a Bool. -/
def q4E (p e k w : ℕ) : Bool :=
  (4 * (p ^ e) ^ 2 - k * (q4A p e) ^ 2) * w ^ 2 + ((p ^ e) ^ 2 - 1)
    == (4 * (p ^ e) ^ 2 - k * q4A p e) * w

-- Check 1 (`k ≤ 15`)

/-- Check 1: for every odd `p ≥ 3` with `p ≤ k w (w-1) + 4` dividing one of the two constraint
numbers, and every `4 ≤ e ≤ 23` with `p ∣ q4N e k w`, (E) fails. -/
def q4ChkSmall (k w : ℕ) : Bool :=
  (List.range (k * w * (w - 1) + 5)).all fun p =>
    p < 3 || p % 2 == 0 ||
    ((k * w * (w - 1) + 1) % p != 0 && (k * w * (w - 2) + 4) % p != 0) ||
    (List.range 24).all fun e => e < 4 || q4N e k w % p != 0 || !q4E p e k w

theorem q4ChkSmall_all : ∀ k, k < 16 → ∀ w, w < 16 → q4ChkSmall k w = true := by
  decide +kernel

/-- Check 1 unpacked. -/
theorem q4_small {p e k w : ℕ} (hk : k ≤ 15) (hw : w ≤ 15) (hp3 : 3 ≤ p) (hodd : p % 2 = 1)
    (he : 4 ≤ e) (he' : e ≤ 23) (hdvd : p ∣ q4N e k w)
    (hE : (4 * (p ^ e) ^ 2 - k * (q4A p e) ^ 2) * w ^ 2 + ((p ^ e) ^ 2 - 1)
      = (4 * (p ^ e) ^ 2 - k * q4A p e) * w) : False := by
  have hc := q4ChkSmall_all k (by omega) w (by omega)
  unfold q4ChkSmall at hc
  rw [List.all_eq_true] at hc
  have hNpos : 0 < q4N e k w := by unfold q4N; split <;> omega
  have hpN : p ≤ q4N e k w := Nat.le_of_dvd hNpos hdvd
  have hNle : q4N e k w ≤ k * w * (w - 1) + 4 := by
    unfold q4N
    split
    · omega
    · have : k * w * (w - 2) ≤ k * w * (w - 1) := Nat.mul_le_mul_left _ (by omega)
      omega
  have hmem : p ∈ List.range (k * w * (w - 1) + 5) := List.mem_range.mpr (by omega)
  have h := hc p hmem
  have hmod : q4N e k w % p = 0 := Nat.mod_eq_zero_of_dvd hdvd
  simp only [Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq, bne_iff_ne, ne_eq,
    beq_iff_eq, List.all_eq_true, List.mem_range] at h
  rcases h with ((h | h) | h) | h
  · omega
  · omega
  · unfold q4N at hmod
    split at hmod
    · exact h.1 hmod
    · exact h.2 hmod
  · have h2 := h e (by omega)
    simp only [Bool.not_eq_true', q4E, beq_eq_false_iff_ne, ne_eq] at h2
    rcases h2 with (h2 | h2) | h2
    · omega
    · exact h2 hmod
    · exact h2 hE

-- Check 2 (`k = 16`, small `p`)

/-- Check 2: for odd `3 ≤ p`, `5 ≤ e ≤ 14`, `2 ≤ w ≤ (p+5)/2`, (E) with `k = 16` fails. -/
def q4ChkK16 (p : ℕ) : Bool :=
  p < 3 || p % 2 == 0 || (List.range 15).all fun e => e < 5 ||
    (List.range ((p + 5) / 2 + 1)).all fun w => w < 2 || !q4E p e 16 w

theorem q4ChkK16_all : ∀ p, p < 27 → q4ChkK16 p = true := by decide +kernel

/-- Check 2 unpacked. -/
theorem q4_k16_small_p {p e w : ℕ} (hp3 : 3 ≤ p) (hodd : p % 2 = 1) (hp : p ≤ 26)
    (he : 5 ≤ e) (he' : e ≤ 14) (hw : 2 ≤ w) (hw' : 2 * w ≤ p + 5)
    (hE : (4 * (p ^ e) ^ 2 - 16 * (q4A p e) ^ 2) * w ^ 2 + ((p ^ e) ^ 2 - 1)
      = (4 * (p ^ e) ^ 2 - 16 * q4A p e) * w) : False := by
  have hc := q4ChkK16_all p (by omega)
  unfold q4ChkK16 at hc
  simp only [Bool.or_eq_true, decide_eq_true_eq, beq_iff_eq, List.all_eq_true,
    List.mem_range] at hc
  rcases hc with (h | h) | h
  · omega
  · omega
  · have h1 := h e (by omega)
    rcases h1 with h1 | h1
    · omega
    · have h2 := h1 w (by omega)
      simp only [Bool.not_eq_true', q4E, beq_eq_false_iff_ne, ne_eq] at h2
      rcases h2 with h2 | h2
      · omega
      · exact h2 hE

-- Check 3 (`k ≥ 17`)

/-- Check 3: for odd `3 ≤ p`, `4 ≤ e`, `17 ≤ k`, `k A² < 4 X²`, no `2 ≤ w ≤ B / δ` satisfies (E). -/
def q4ChkLarge (p e k : ℕ) : Bool :=
  p < 3 || p % 2 == 0 || e < 4 || k < 17 || 4 * (p ^ e) ^ 2 ≤ k * (q4A p e) ^ 2 ||
  (List.range ((4 * (p ^ e) ^ 2 - k * q4A p e) / (4 * (p ^ e) ^ 2 - k * (q4A p e) ^ 2) + 1)).all
    fun w => w < 2 || !q4E p e k w

/-- One Bool for the whole range, to avoid deep recursion of nested bounded ∀ in the kernel. -/
def q4ChkLargeAll : Bool :=
  (List.range 33).all fun p => (List.range 30).all fun e => (List.range 29).all fun k =>
    q4ChkLarge p e k

theorem q4ChkLargeAll_true : q4ChkLargeAll = true := by decide +kernel

/-- Check 3 unpacked. -/
theorem q4_large {p e k w : ℕ} (hk1 : 17 ≤ k) (hk2 : k ≤ 28) (hp3 : 3 ≤ p) (hodd : p % 2 = 1)
    (hp32 : p ≤ 32) (he : 4 ≤ e) (he' : e ≤ 29) (hw : 2 ≤ w)
    (hδ : k * (q4A p e) ^ 2 < 4 * (p ^ e) ^ 2)
    (hwb : (4 * (p ^ e) ^ 2 - k * (q4A p e) ^ 2) * w < 4 * (p ^ e) ^ 2 - k * q4A p e)
    (hE : (4 * (p ^ e) ^ 2 - k * (q4A p e) ^ 2) * w ^ 2 + ((p ^ e) ^ 2 - 1)
      = (4 * (p ^ e) ^ 2 - k * q4A p e) * w) : False := by
  have hδpos : 0 < 4 * (p ^ e) ^ 2 - k * (q4A p e) ^ 2 := by omega
  have hwle : w ≤ (4 * (p ^ e) ^ 2 - k * q4A p e) / (4 * (p ^ e) ^ 2 - k * (q4A p e) ^ 2) := by
    rw [Nat.le_div_iff_mul_le hδpos, mul_comm]
    exact hwb.le
  have hc := q4ChkLargeAll_true
  unfold q4ChkLargeAll at hc
  simp only [List.all_eq_true, List.mem_range] at hc
  have hc2 := hc p (by omega) e (by omega) k (by omega)
  unfold q4ChkLarge at hc2
  simp only [Bool.or_eq_true, decide_eq_true_eq, beq_iff_eq, List.all_eq_true] at hc2
  rcases hc2 with ((((h | h) | h) | h) | h) | h
  · omega
  · omega
  · omega
  · omega
  · omega
  · have h2 := h w (List.mem_range.mpr (by omega))
    simp only [Bool.not_eq_true', q4E, beq_eq_false_iff_ne, ne_eq] at h2
    rcases h2 with h2 | h2
    · omega
    · exact h2 hE

end A224Deep
