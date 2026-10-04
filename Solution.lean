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
