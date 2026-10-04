import FormalConjectures.OEIS.«224»

/-! Sweep work for a000224: partial results (even `n`, and the "odd prime ⇒" direction). -/

namespace A224Sweep

open OeisA224

/-- For `n ≥ 2` the squares mod `n` include `0` and `1`, so `a n ≥ 2`. -/
theorem two_le_a {n : Nat} (hn : 2 ≤ n) : 2 ≤ a n := by
  have hn0 : n ≠ 0 := by omega
  unfold a
  rw [if_neg hn0]
  have hsub : ({0, 1} : Finset Nat) ⊆ (Finset.range n).image (fun k : Nat => k ^ 2 % n) := by
    intro x hx
    simp only [Finset.mem_insert, Finset.mem_singleton] at hx
    simp only [Finset.mem_image, Finset.mem_range]
    rcases hx with rfl | rfl
    · exact ⟨0, by omega, by simp⟩
    · exact ⟨1, by omega, by simp [Nat.mod_eq_of_lt (show 1 < n by omega)]⟩
  have := Finset.card_le_card hsub
  simpa using this

/-- Even `n ≥ 2`: the congruence fails, since the modulus `a(a-1)` is even and `≥ 2`. -/
theorem not_modEq_of_even {n : Nat} (hn : 2 ≤ n) (he : Even n) :
    ¬ n ^ 2 ≡ 1 [MOD a n * (a n - 1)] := by
  intro h
  have ha := two_le_a hn
  set M := a n * (a n - 1) with hM
  have hM2 : 2 ≤ M := by
    have : 1 ≤ a n - 1 := by omega
    calc 2 ≤ a n * 1 := by omega
      _ ≤ a n * (a n - 1) := Nat.mul_le_mul_left _ this
  have hMe : 2 ∣ M := (Nat.even_mul_pred_self (a n)).two_dvd
  have hne : 2 ∣ n ^ 2 := by
    rcases he with ⟨r, rfl⟩
    exact ⟨2 * r * r, by ring⟩
  have h1 : 1 % M = 1 := Nat.mod_eq_of_lt (by omega)
  have hmod : 2 ∣ n ^ 2 % M := (Nat.dvd_mod_iff hMe).mpr hne
  unfold Nat.ModEq at h
  rw [h, h1] at hmod
  omega

/-- The conjecture holds for every even `n > 1` (both sides are false). -/
theorem conjecture_of_even (n : Nat) (hn : 1 < n) (he : Even n) :
    (n.Prime ∧ n ≠ 2) ↔ n ^ 2 ≡ 1 [MOD a n * (a n - 1)] := by
  constructor
  · rintro ⟨hp, h2⟩
    exact absurd (hp.even_iff.mp he) h2
  · intro h
    exact absurd h (not_modEq_of_even hn he)

/-- For an odd prime `p`, there are `(p+1)/2` squares mod `p`. -/
theorem a_prime {p : Nat} (hp : p.Prime) (h2 : p ≠ 2) : a p = (p + 1) / 2 := by
  have := Fact.mk hp
  have hp0 : p ≠ 0 := hp.ne_zero
  have hodd : p % 2 = 1 := by
    rcases Nat.even_or_odd p with he | ho
    · exact absurd (hp.even_iff.mp he) h2
    · exact Nat.odd_iff.mp ho
  set f : Nat → Nat := fun k => k ^ 2 % p with hf
  -- Step 1: the image of `range p` equals the image of `range ((p+1)/2)`.
  have himg : (Finset.range p).image f = (Finset.range ((p + 1) / 2)).image f := by
    apply Finset.Subset.antisymm
    · intro x hx
      simp only [Finset.mem_image, Finset.mem_range] at hx ⊢
      obtain ⟨k, hk, rfl⟩ := hx
      by_cases hkh : k < (p + 1) / 2
      · exact ⟨k, hkh, rfl⟩
      · refine ⟨p - k, by omega, ?_⟩
        simp only [hf]
        rw [← ZMod.natCast_eq_natCast_iff']
        push_cast [Nat.cast_sub hk.le]
        simp
    · apply Finset.image_subset_image
      intro x hx
      simp only [Finset.mem_range] at hx ⊢
      omega
  -- Step 2: `f` is injective on `range ((p+1)/2)`.
  have hinj : Set.InjOn f ((Finset.range ((p + 1) / 2) : Finset Nat) : Set Nat) := by
    intro j hj k hk hjk
    simp only [Finset.coe_range, Set.mem_Iio] at hj hk
    simp only [hf] at hjk
    rw [← ZMod.natCast_eq_natCast_iff'] at hjk
    push_cast at hjk
    rcases sq_eq_sq_iff_eq_or_eq_neg.mp hjk with h | h
    · rw [ZMod.natCast_eq_natCast_iff', Nat.mod_eq_of_lt (by omega),
        Nat.mod_eq_of_lt (by omega)] at h
      exact h
    · have h' : ((j + k : Nat) : ZMod p) = 0 := by push_cast; rw [h]; ring
      rw [ZMod.natCast_eq_zero_iff] at h'
      have : j + k = 0 := Nat.eq_zero_of_dvd_of_lt h' (by omega)
      omega
  unfold a
  rw [if_neg hp0]
  change ((Finset.range p).image f).card = _
  rw [himg, Finset.card_image_of_injOn hinj, Finset.card_range]

/-- The "odd prime ⇒ congruence" direction of the conjecture. -/
theorem modEq_of_odd_prime {p : Nat} (hp : p.Prime) (h2 : p ≠ 2) :
    p ^ 2 ≡ 1 [MOD a p * (a p - 1)] := by
  rw [a_prime hp h2]
  have hodd : p % 2 = 1 := by
    rcases Nat.even_or_odd p with he | ho
    · exact absurd (hp.even_iff.mp he) h2
    · exact Nat.odd_iff.mp ho
  obtain ⟨t, rfl⟩ : ∃ t, p = 2 * t + 1 := ⟨p / 2, by omega⟩
  have e1 : (2 * t + 1 + 1) / 2 = t + 1 := by omega
  rw [e1, Nat.add_sub_cancel]
  have e2 : (2 * t + 1) ^ 2 = 1 + (t + 1) * t * 4 := by ring
  rw [e2]
  unfold Nat.ModEq
  rw [Nat.add_mul_mod_self_left]

end A224Sweep


namespace A224Sweep

/-- Finite check: `true` unless `u, d` give a solution with `v = 4u(u-1)/d`. -/
def semiChk (u d : Nat) : Bool :=
  (((2*u-1)*(2*(4*u*(u-1)/d)-1))^2 - 1) % (u*(4*u*(u-1)/d)*(u*(4*u*(u-1)/d)-1)) != 0
    || u < 2 || d = 0 || 4*u*(u-1)/d ≤ u

theorem semiChk_all : ∀ u, u < 32 → ∀ d, d < 121 → semiChk u d = true := by
  decide +kernel

/-- Diophantine core of the semiprime case: for `2 ≤ u < v`,
`uv(uv-1)` does not divide `((2u-1)(2v-1))^2 - 1`. -/
theorem semi_core (u v : Nat) (hu : 2 ≤ u) (huv : u < v) :
    ¬ u * v * (u * v - 1) ∣ ((2 * u - 1) * (2 * v - 1)) ^ 2 - 1 := by
  rintro ⟨k, hk⟩
  have h1 : 1 ≤ 2 * u := by omega
  have h2 : 1 ≤ 2 * v := by omega
  have h3 : 1 ≤ u * v := Nat.one_le_iff_ne_zero.mpr (Nat.mul_ne_zero (by omega) (by omega))
  have h4 : 1 ≤ ((2 * u - 1) * (2 * v - 1)) ^ 2 :=
    Nat.one_le_iff_ne_zero.mpr (by apply pow_ne_zero; apply mul_ne_zero <;> omega)
  zify [h1, h2, h3, h4] at hk
  set U : Int := (u : Int) with hU
  set V : Int := (v : Int) with hV
  set K : Int := (k : Int) with hK
  have hU2 : 2 ≤ U := by omega
  have hUV : U < V := by omega
  have hK0 : 0 ≤ K := by omega
  -- Step 1: k ≤ 15.
  have hPs : U + V ≤ U * V := by nlinarith
  have key : 0 < (U + V) * (4 * (U * V) - (U + V) + 1) - 6 * (U * V) := by nlinarith
  have hPP : 0 < U * V * (U * V - 1) := by
    have : 1 < U * V := by nlinarith
    have : 0 < U * V - 1 := by omega
    positivity
  have iden : 16 * (U * V * (U * V - 1)) - (((2 * U - 1) * (2 * V - 1)) ^ 2 - 1)
      = 4 * ((U + V) * (4 * (U * V) - (U + V) + 1) - 6 * (U * V)) := by ring
  have hK15 : K ≤ 15 := by
    by_contra hc
    have : 16 ≤ K := by omega
    have := mul_le_mul_of_nonneg_left this hPP.le
    nlinarith
  -- Step 2: the quadratic in v.
  have hq : ((16 - K) * U ^ 2 - 16 * U + 4) * V ^ 2 + 4 * U * (U - 1)
      = (16 * U ^ 2 - (16 + K) * U + 4) * V := by linear_combination hk
  -- Step 3: α v < 16 u^2.
  have hV0 : 0 < V := by omega
  have hαV : ((16 - K) * U ^ 2 - 16 * U + 4) * V < 16 * U ^ 2 := by
    have hpos : 0 < 4 * U * (U - 1) := by
      have : 0 < U - 1 := by omega
      positivity
    have hle : (16 * U ^ 2 - (16 + K) * U + 4) * V ≤ 16 * U ^ 2 * V := by
      have : 16 * U ^ 2 - (16 + K) * U + 4 ≤ 16 * U ^ 2 := by nlinarith
      exact mul_le_mul_of_nonneg_right this hV0.le
    have : ((16 - K) * U ^ 2 - 16 * U + 4) * V * V < 16 * U ^ 2 * V := by nlinarith
    exact lt_of_mul_lt_mul_right this hV0.le
  -- Step 4: u ≤ 31.
  have hU31 : U ≤ 31 := by
    by_contra hc
    have hU32 : 32 ≤ U := by omega
    have hα : U ^ 2 - 16 * U + 4 ≤ (16 - K) * U ^ 2 - 16 * U + 4 := by nlinarith
    have hαpos : 0 < U ^ 2 - 16 * U + 4 := by nlinarith
    have hstep : (U ^ 2 - 16 * U + 4) * (U + 1) ≤ ((16 - K) * U ^ 2 - 16 * U + 4) * V :=
      mul_le_mul hα (by omega) (by omega) (by linarith)
    nlinarith
  -- Step 5: v ∣ 4u(u-1), with cofactor d < 121.
  have hdvdZ : V ∣ 4 * U * (U - 1) :=
    ⟨16 * U ^ 2 - (16 + K) * U + 4 - ((16 - K) * U ^ 2 - 16 * U + 4) * V, by linear_combination hq⟩
  have hu1 : 1 ≤ u := by omega
  have hdvd : v ∣ 4 * u * (u - 1) := by
    have : ((v : Int)) ∣ ((4 * u * (u - 1) : Nat) : Int) := by
      push_cast [Nat.cast_sub hu1]; exact hdvdZ
    exact Int.natCast_dvd_natCast.mp this
  obtain ⟨d, hd⟩ := hdvd
  have hu31 : u ≤ 31 := by omega
  have hdpos : 0 < d := by
    rcases Nat.eq_zero_or_pos d with h | h
    · rw [h, Nat.mul_zero] at hd
      have : 0 < 4 * u * (u - 1) := by
        have : 0 < u - 1 := by omega
        positivity
      omega
    · exact h
  have hd121 : d < 121 := by
    by_contra hc
    have hc' : 4 * (u - 1) ≤ d := by omega
    have : v * (4 * (u - 1)) ≤ v * d := Nat.mul_le_mul_left v hc'
    have : u * (4 * (u - 1)) < v * (4 * (u - 1)) :=
      Nat.mul_lt_mul_of_pos_right huv (by omega)
    have : 4 * u * (u - 1) = u * (4 * (u - 1)) := by ring
    omega
  have hvd : 4 * u * (u - 1) / d = v := Nat.div_eq_of_eq_mul_left hdpos hd
  -- Step 6: finite check.
  have hc := semiChk_all u (by omega) d hd121
  simp only [semiChk, hvd] at hc
  have hk' : ((2 * u - 1) * (2 * v - 1)) ^ 2 - 1 = u * v * (u * v - 1) * k := by
    zify [h1, h2, h3, h4]; exact hk
  rw [hk', Nat.mul_mod_right] at hc
  simp at hc
  omega

end A224Sweep
