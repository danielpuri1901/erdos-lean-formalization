import FormalConjectures.Wikipedia.GaussCircleProblem

/-! Solution for the gaussexact target. See `TASK.md` and `NOTES.md`. -/

open GaussianInt

namespace GaussExact

-- ### The divisor side

/-- The non-trivial character modulo 4 on the naturals. -/
def chi (d : ℕ) : ℤ := ZMod.χ₄ (d : ZMod 4)

lemma chi_mul (a b : ℕ) : chi (a * b) = chi a * chi b := by
  simp [chi, Nat.cast_mul, map_mul]

/-- `D n = Σ_{d ∣ n} χ₄ d`. -/
def D (n : ℕ) : ℤ := ∑ d ∈ n.divisors, chi d

lemma filter_divisors_prime_mul (p k : ℕ) (hp : p.Prime) (hk : k ≠ 0) :
    (p * k).divisors.filter (fun d => ¬ p ∣ d) = k.divisors.filter (fun d => ¬ p ∣ d) := by
  sorry

lemma D_prime_mul (p m : ℕ) (hp : p.Prime) (hm : m ≠ 0) :
    D (p * m) = (∑ d ∈ m.divisors.filter (fun d => ¬ p ∣ d), chi d) + chi p * D m := by
  sorry

lemma D_rec (p m : ℕ) (hp : p.Prime) (hm : m ≠ 0) :
    D (p * m) = (1 + chi p) * D m - (if p ∣ m then chi p * D (m / p) else 0) := by
  sorry

-- ### The lattice point side

/-- The number of Gaussian integers of norm `n`. -/
noncomputable def R (n : ℕ) : ℕ := Set.ncard {z : GaussianInt | z.norm = n}

/-- The box `[-n, n]²`. -/
def box (n : ℕ) : Finset (ℤ × ℤ) := Finset.Icc (-(n : ℤ)) n ×ˢ Finset.Icc (-(n : ℤ)) n

lemma R_eq_card (n K : ℕ) (h : n ≤ K) :
    R n = ((box K).filter (fun z => z.1 ^ 2 + z.2 ^ 2 = (n : ℤ))).card := by
  sorry

lemma S_finite (n : ℕ) : {z : GaussianInt | z.norm = n}.Finite := by
  sorry

lemma card_dvd (α : GaussianInt) (hα : α ≠ 0) (m : ℕ) :
    {z : GaussianInt | z.norm = α.norm * m ∧ α ∣ z}.ncard = R m := by
  sorry

lemma card_natCast_dvd (p : ℕ) (hp : 1 < p) (m : ℕ) :
    {z : GaussianInt | z.norm = (p : ℤ) * m ∧ (p : GaussianInt) ∣ z}.ncard = if p ∣ m then R (m / p) else 0 := by
  sorry

lemma prime_of_norm_prime (π : GaussianInt) (p : ℕ) (hp : p.Prime) (hπ : π.norm = p) : Prime π := by
  sorry

lemma dvd_or_dvd_star (π : GaussianInt) (p : ℕ) (hp : p.Prime) (hπ : π.norm = p) (z : GaussianInt)
    (hz : (p : ℤ) ∣ z.norm) : π ∣ z ∨ star π ∣ z := by
  sorry

lemma R_two (m : ℕ) : R (2 * m) = R m := by
  sorry

lemma R_three (p m : ℕ) (hp : p.Prime) (h3 : p % 4 = 3) :
    R (p * m) = if p ∣ m then R (m / p) else 0 := by
  sorry

lemma R_one (p m : ℕ) (hp : p.Prime) (h1 : p % 4 = 1) :
    R (p * m) + (if p ∣ m then R (m / p) else 0) = 2 * R m := by
  sorry

lemma R_zero : R 0 = 1 := by
  sorry

lemma R_one' : R 1 = 4 := by
  sorry

theorem R_eq (n : ℕ) (hn : n ≠ 0) : (R n : ℤ) = 4 * D n := by
  sorry

-- ### Summation

lemma card_le (K : ℕ) :
    (((box K).filter (fun z => z.1 ^ 2 + z.2 ^ 2 ≤ (K : ℤ))).card : ℤ)
      = 1 + 4 * ∑ n ∈ Finset.range K, D (n + 1) := by
  sorry

lemma sum_D (K M : ℕ) (h : K < M) :
    ∑ n ∈ Finset.range K, D (n + 1) = ∑ d ∈ Finset.range M, chi d * ((K / d : ℕ) : ℤ) := by
  sorry

lemma sum_chi (f : ℕ → ℤ) (J : ℕ) :
    ∑ d ∈ Finset.range (4 * J), chi d * f d = ∑ i ∈ Finset.range J, (f (4 * i + 1) - f (4 * i + 3)) := by
  sorry

-- ### Back to the disc

lemma N_eq (r : ℝ) (hr : 0 ≤ r) :
    GaussCircleProblem.N r = ((box ⌊r ^ 2⌋₊).filter (fun z => z.1 ^ 2 + z.2 ^ 2 ≤ (⌊r ^ 2⌋₊ : ℤ))).card := by
  sorry

lemma floor_div (r : ℝ) (d : ℕ) : ⌊r ^ 2 / ((d : ℕ) : ℝ)⌋ = ((⌊r ^ 2⌋₊ / d : ℕ) : ℤ) := by
  sorry

end GaussExact

theorem gauss_circle_exact_form : type_of% @GaussCircleProblem.exact_form_floor := by
  intro r hr
  sorry
