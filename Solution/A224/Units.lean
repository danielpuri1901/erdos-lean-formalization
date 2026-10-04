import FormalConjectures.OEIS.«224»

/-! a000224 deep attempt, lemma R1: squaring is 2-to-1 on residues coprime to an odd prime power. -/

namespace A224Deep

/-- R1. For an odd prime `p` and `j ≥ 1`, the number of distinct values of `x^2 % p^j` over
`x < p^j` with `p ∤ x` is `(p^j - p^(j-1)) / 2`, stated without division. -/
theorem card_unit_squares {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) {j : ℕ} (hj : 1 ≤ j) :
    2 * (((Finset.range (p ^ j)).filter (fun x => ¬ p ∣ x)).image
        (fun x => x ^ 2 % p ^ j)).card = p ^ j - p ^ (j - 1) := by
  have := Fact.mk hp
  have hp1 : 2 ≤ p := hp.two_le
  have harith : p ^ (j - 1) * (p - 1) = p ^ j - p ^ (j - 1) := by
    obtain ⟨j', rfl⟩ : ∃ j', j = j' + 1 := ⟨j - 1, by omega⟩
    rw [Nat.add_sub_cancel, Nat.mul_sub_one, pow_succ]
  have htot : Nat.totient (p ^ j) = p ^ j - p ^ (j - 1) := by
    rw [Nat.totient_prime_pow hp (by omega), harith]
  set N := p ^ j with hN
  have hNpos : 0 < N := by positivity
  have hpN : p ∣ N := by rw [hN]; exact dvd_pow_self p (by omega)
  have : NeZero N := ⟨hNpos.ne'⟩
  set U := (Finset.range N).filter (fun x => ¬ p ∣ x) with hU
  set f : ℕ → ℕ := fun x => x ^ 2 % N with hf
  -- Step 1
  have hcardU : U.card = N - p ^ (j - 1) := by
    have h1 : U = (Finset.range N).filter N.Coprime := by
      rw [hU]; apply Finset.filter_congr
      intro x _
      rw [hN, Nat.coprime_pow_left_iff (by omega), Nat.Prime.coprime_iff_not_dvd hp]
    rw [h1, ← Nat.totient_eq_card_coprime, htot]
  -- helper
  have hdvd2 : ∀ m, N ∣ m → 0 < m → m < 2 * N → m = N := by
    intro m ⟨c, hc⟩ h0 h2
    subst hc
    rcases c with _ | _ | c
    · omega
    · ring
    · nlinarith
  have hunit : ∀ a b : ℕ, ¬ p ∣ a → ((a : ZMod N) * (b : ZMod N) = 0) → N ∣ b := by
    intro a b ha hab
    have hcop : Nat.Coprime a N := by
      rw [hN]; exact Nat.Coprime.pow_right j ((Nat.Prime.coprime_iff_not_dvd hp).mpr ha).symm
    have hu : IsUnit (a : ZMod N) := (ZMod.isUnit_iff_coprime a N).mpr hcop
    have : (b : ZMod N) = 0 := (IsUnit.mul_right_eq_zero hu).mp hab
    rwa [ZMod.natCast_eq_zero_iff] at this
  -- Step 3
  have hfib : ∀ b ∈ U.image f, (U.filter (fun y => f y = b)).card = 2 := by
    intro b hb
    rw [Finset.mem_image] at hb
    obtain ⟨x, hxU, rfl⟩ := hb
    rw [hU, Finset.mem_filter, Finset.mem_range] at hxU
    obtain ⟨hxN, hpx⟩ := hxU
    have hx0 : 0 < x := by
      rcases Nat.eq_zero_or_pos x with h | h
      · exact absurd (h ▸ dvd_zero p) hpx
      · exact h
    have hNx : ¬ p ∣ N - x := by
      intro h
      apply hpx
      have h' : N = (N - x) + x := by omega
      rw [h'] at hpN
      exact (Nat.dvd_add_right h).mp hpN
    have hne : x ≠ N - x := by
      intro h
      have h2 : 2 * x = N := by omega
      have : p ∣ 2 * x := h2 ▸ hpN
      rcases (Nat.Prime.dvd_mul hp).mp this with h3 | h3
      · exact hp2 ((Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp h3)
      · exact hpx h3
    have hfx : f (N - x) = f x := by
      simp only [hf]
      rw [← ZMod.natCast_eq_natCast_iff']
      push_cast [Nat.cast_sub hxN.le]
      simp
    have hset : U.filter (fun y => f y = f x) = {x, N - x} := by
      ext y
      simp only [Finset.mem_filter, Finset.mem_insert, Finset.mem_singleton, hU, Finset.mem_range]
      constructor
      · rintro ⟨⟨hyN, hpy⟩, hfy⟩
        have hfy' : ((y : ZMod N)) ^ 2 = (x : ZMod N) ^ 2 := by
          have := hfy
          simp only [hf] at this
          rw [← ZMod.natCast_eq_natCast_iff'] at this
          push_cast at this
          exact this
        have hprod : ((y + x : ℕ) : ZMod N) * ((y + (N - x) : ℕ) : ZMod N) = 0 := by
          push_cast [Nat.cast_sub hxN.le]
          rw [ZMod.natCast_self]
          linear_combination hfy'
        have hnot : ¬ (p ∣ y + x ∧ p ∣ y + (N - x)) := by
          rintro ⟨h1, h2⟩
          have h3 : p ∣ (y + x) + (y + (N - x)) := dvd_add h1 h2
          have h4 : (y + x) + (y + (N - x)) = 2 * y + N := by omega
          rw [h4] at h3
          have h5 : p ∣ 2 * y := (Nat.dvd_add_left hpN).mp h3
          rcases (Nat.Prime.dvd_mul hp).mp h5 with h6 | h6
          · exact hp2 ((Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp h6)
          · exact hpy h6
        by_cases h1 : p ∣ y + x
        · have h2 : ¬ p ∣ y + (N - x) := fun h2 => hnot ⟨h1, h2⟩
          rw [mul_comm] at hprod
          have h3 := hdvd2 _ (hunit _ _ h2 hprod) (by omega) (by omega)
          right
          omega
        · have h3 := hdvd2 _ (hunit _ _ h1 hprod) (by omega) (by omega)
          left
          omega
      · rintro (rfl | rfl)
        · exact ⟨⟨hxN, hpx⟩, rfl⟩
        · exact ⟨⟨by omega, hNx⟩, hfx⟩
    rw [hset, Finset.card_pair hne]
  have hsum : U.card = (U.image f).card * 2 := by
    rw [Finset.card_eq_sum_card_image f U]
    exact Finset.sum_const_nat hfib
  change 2 * (U.image f).card = _
  omega

end A224Deep
