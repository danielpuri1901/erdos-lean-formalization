import FormalConjectures.Wikipedia.GaussCircleProblem

/-! Solution for the gaussexact target. See `TASK.md` and `NOTES.md`. -/

open GaussianInt

namespace GaussExact

-- ### The divisor side

/-- The non-trivial character modulo 4 on the naturals. -/
def chi (d : ℕ) : ℤ := ZMod.χ₄ (d : ZMod 4)

lemma chi_mul (a b : ℕ) : chi (a * b) = chi a * chi b := by
  simp [chi, Nat.cast_mul, map_mul]

lemma chi_eq (d : ℕ) : chi d = if d % 2 = 0 then 0 else if d % 4 = 1 then 1 else -1 :=
  ZMod.χ₄_nat_eq_if_mod_four d

lemma chi_four (i : ℕ) :
    chi (4 * i) = 0 ∧ chi (4 * i + 1) = 1 ∧ chi (4 * i + 2) = 0 ∧ chi (4 * i + 3) = -1 := by
  simp only [chi_eq]
  refine ⟨?_, ?_, ?_, ?_⟩ <;> split_ifs <;> omega

/-- `D n = Σ_{d ∣ n} χ₄ d`. -/
def D (n : ℕ) : ℤ := ∑ d ∈ n.divisors, chi d

lemma filter_divisors_prime_mul (p k : ℕ) (hp : p.Prime) (hk : k ≠ 0) :
    (p * k).divisors.filter (fun d => ¬ p ∣ d) = k.divisors.filter (fun d => ¬ p ∣ d) := by
  ext d
  simp only [Finset.mem_filter, Nat.mem_divisors]
  constructor
  · rintro ⟨⟨hd, -⟩, hnd⟩
    have hcop : Nat.Coprime d p := ((Nat.Prime.coprime_iff_not_dvd hp).mpr hnd).symm
    exact ⟨⟨hcop.dvd_of_dvd_mul_left hd, hk⟩, hnd⟩
  · rintro ⟨⟨hd, -⟩, hnd⟩
    exact ⟨⟨Dvd.dvd.mul_left hd p, Nat.mul_ne_zero hp.ne_zero hk⟩, hnd⟩

lemma D_prime_mul (p m : ℕ) (hp : p.Prime) (hm : m ≠ 0) :
    D (p * m) = (∑ d ∈ m.divisors.filter (fun d => ¬ p ∣ d), chi d) + chi p * D m := by
  unfold D
  rw [← Finset.sum_filter_not_add_sum_filter _ (fun d => p ∣ d), filter_divisors_prime_mul p m hp hm]
  congr 1
  have himg : (p * m).divisors.filter (fun d => p ∣ d) = m.divisors.image (fun e => p * e) := by
    ext d
    simp only [Finset.mem_filter, Nat.mem_divisors, Finset.mem_image]
    constructor
    · rintro ⟨⟨hd, -⟩, ⟨e, rfl⟩⟩
      exact ⟨e, ⟨Nat.dvd_of_mul_dvd_mul_left hp.pos hd, hm⟩, rfl⟩
    · rintro ⟨e, ⟨he, -⟩, rfl⟩
      exact ⟨⟨Nat.mul_dvd_mul_left p he, Nat.mul_ne_zero hp.ne_zero hm⟩, dvd_mul_right p e⟩
  rw [himg, Finset.sum_image (fun a _ b _ h => Nat.eq_of_mul_eq_mul_left hp.pos h), Finset.mul_sum]
  exact Finset.sum_congr rfl (fun e _ => chi_mul p e)

lemma D_rec (p m : ℕ) (hp : p.Prime) (hm : m ≠ 0) :
    D (p * m) = (1 + chi p) * D m - (if p ∣ m then chi p * D (m / p) else 0) := by
  rw [D_prime_mul p m hp hm]
  split_ifs with hpm
  · obtain ⟨k, rfl⟩ := hpm
    have hk : k ≠ 0 := by
      rintro rfl
      simp at hm
    rw [Nat.mul_div_cancel_left k hp.pos, D_prime_mul p k hp hk,
      filter_divisors_prime_mul p k hp hk]
    ring
  · have : m.divisors.filter (fun d => ¬ p ∣ d) = m.divisors := by
      apply Finset.filter_true_of_mem
      intro d hd h
      exact hpm (h.trans (Nat.dvd_of_mem_divisors hd))
    rw [this]
    unfold D
    ring

-- ### The lattice point side

/-- The number of Gaussian integers of norm `n`. -/
noncomputable def R (n : ℕ) : ℕ := Set.ncard {z : GaussianInt | z.norm = n}

/-- The box `[-n, n]²`. -/
def box (n : ℕ) : Finset (ℤ × ℤ) := Finset.Icc (-(n : ℤ)) n ×ˢ Finset.Icc (-(n : ℤ)) n

lemma S_eq (n K : ℕ) (h : n ≤ K) :
    {z : GaussianInt | z.norm = n} = (fun z : ℤ × ℤ => (⟨z.1, z.2⟩ : GaussianInt)) ''
      ↑((box K).filter (fun z => z.1 ^ 2 + z.2 ^ 2 = (n : ℤ))) := by
  ext w
  simp only [Set.mem_ofPred_eq, Set.mem_image, Finset.coe_filter, box, Finset.mem_product,
    Finset.mem_Icc]
  constructor
  · intro hw
    rw [Zsqrtd.norm_def] at hw
    have h1 := Int.le_self_sq w.re
    have h2 := Int.le_self_sq (-w.re)
    have h3 := Int.le_self_sq w.im
    have h4 := Int.le_self_sq (-w.im)
    have h5 := sq_nonneg w.re
    have h6 := sq_nonneg w.im
    rw [neg_sq] at h2 h4
    have hK : (n : ℤ) ≤ K := by exact_mod_cast h
    refine ⟨(w.re, w.im), ⟨⟨⟨?_, ?_⟩, ?_, ?_⟩, ?_⟩, rfl⟩ <;> nlinarith
  · rintro ⟨z, ⟨-, hz⟩, rfl⟩
    rw [Zsqrtd.norm_def]
    simp only
    linear_combination hz

lemma R_eq_card (n K : ℕ) (h : n ≤ K) :
    R n = ((box K).filter (fun z => z.1 ^ 2 + z.2 ^ 2 = (n : ℤ))).card := by
  have he : Function.Injective (fun z : ℤ × ℤ => (⟨z.1, z.2⟩ : GaussianInt)) := by
    intro a b hab
    simp only [Zsqrtd.mk.injEq] at hab
    exact Prod.ext hab.1 hab.2
  unfold R
  rw [S_eq n K h, Set.ncard_image_of_injective _ he, Set.ncard_coe_finset]

lemma S_finite (n : ℕ) : {z : GaussianInt | z.norm = n}.Finite := by
  rw [S_eq n n le_rfl]
  exact (Finset.finite_toSet _).image _

lemma card_dvd (α : GaussianInt) (hα : α ≠ 0) (m : ℕ) :
    {z : GaussianInt | z.norm = α.norm * m ∧ α ∣ z}.ncard = R m := by
  have hαn : α.norm ≠ 0 := by rwa [Ne, GaussianInt.norm_eq_zero]
  have : {z : GaussianInt | z.norm = α.norm * m ∧ α ∣ z} = (fun w => α * w) '' {w | w.norm = m} := by
    ext z
    simp only [Set.mem_ofPred_eq, Set.mem_image]
    constructor
    · rintro ⟨hn, w, rfl⟩
      refine ⟨w, ?_, rfl⟩
      rw [Zsqrtd.norm_mul] at hn
      exact mul_left_cancel₀ hαn hn
    · rintro ⟨w, hw, rfl⟩
      exact ⟨by rw [Zsqrtd.norm_mul, hw], dvd_mul_right α w⟩
  rw [this, Set.ncard_image_of_injective _ (mul_right_injective₀ hα)]
  rfl

lemma card_natCast_dvd (p : ℕ) (hp : 1 < p) (m : ℕ) :
    {z : GaussianInt | z.norm = (p : ℤ) * m ∧ (p : GaussianInt) ∣ z}.ncard = if p ∣ m then R (m / p) else 0 := by
  have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast (show p ≠ 0 by omega)
  split_ifs with hpm
  · obtain ⟨k, rfl⟩ := hpm
    rw [Nat.mul_div_cancel_left k (by omega)]
    have hpz : (p : GaussianInt) ≠ 0 := by
      intro h
      have := congrArg Zsqrtd.re h
      simp at this
      omega
    rw [← card_dvd (p : GaussianInt) hpz k]
    have e : ∀ z : GaussianInt, (z.norm = (p : ℤ) * ((p * k : ℕ) : ℤ) ∧ (p : GaussianInt) ∣ z) ↔
        (z.norm = (p : GaussianInt).norm * k ∧ (p : GaussianInt) ∣ z) := by
      intro z
      rw [Zsqrtd.norm_natCast]
      push_cast
      rw [mul_assoc]
    simp only [e]
  · convert Set.ncard_empty GaussianInt
    ext z
    simp only [Set.mem_ofPred_eq, Set.mem_empty_iff_false, iff_false, not_and]
    rintro hn ⟨w, rfl⟩
    rw [Zsqrtd.norm_mul, Zsqrtd.norm_natCast, mul_assoc] at hn
    have h2 : (p : ℤ) * w.norm = m := mul_left_cancel₀ hp0 hn
    apply hpm
    have : (p : ℤ) ∣ (m : ℤ) := ⟨w.norm, h2.symm⟩
    exact_mod_cast this

lemma prime_of_norm_prime (π : GaussianInt) (p : ℕ) (hp : p.Prime) (hπ : π.norm = p) : Prime π := by
  rw [← UniqueFactorizationMonoid.irreducible_iff_prime, irreducible_iff]
  refine ⟨?_, ?_⟩
  · rw [← Zsqrtd.norm_eq_one_iff' (by norm_num) π, hπ]
    exact_mod_cast hp.one_lt.ne'
  · intro a b hab
    rw [hab, Zsqrtd.norm_mul] at hπ
    rw [← Zsqrtd.norm_eq_one_iff' (by norm_num) a, ← Zsqrtd.norm_eq_one_iff' (by norm_num) b]
    obtain ⟨x, hx⟩ := Int.eq_ofNat_of_zero_le (GaussianInt.norm_nonneg a)
    obtain ⟨y, hy⟩ := Int.eq_ofNat_of_zero_le (GaussianInt.norm_nonneg b)
    rw [hx, hy] at hπ ⊢
    have hxy : x * y = p := by exact_mod_cast hπ
    rw [← hxy] at hp
    rcases Nat.prime_mul_iff.mp hp with ⟨-, h⟩ | ⟨-, h⟩
    · right
      simp [h]
    · left
      simp [h]

lemma dvd_or_dvd_star (π : GaussianInt) (p : ℕ) (hp : p.Prime) (hπ : π.norm = p) (z : GaussianInt)
    (hz : (p : ℤ) ∣ z.norm) : π ∣ z ∨ star π ∣ z := by
  have hP := prime_of_norm_prime π p hp hπ
  have h1 : π ∣ z * star z := by
    rw [← Zsqrtd.norm_eq_mul_conj]
    have : π * star π ∣ ((z.norm : ℤ) : GaussianInt) := by
      rw [← Zsqrtd.norm_eq_mul_conj, hπ]
      exact map_dvd (Int.castRingHom GaussianInt) hz
    exact (dvd_mul_right π _).trans this
  rcases hP.dvd_or_dvd h1 with h | h
  · exact Or.inl h
  · right
    have := map_dvd (starRingEnd GaussianInt) h
    rwa [starRingEnd_apply, starRingEnd_apply, star_star] at this

lemma dvd_of_dvd_dvd_star (π : GaussianInt) (p : ℕ) (hp : p.Prime) (hodd : p ≠ 2)
    (hπ : π.norm = p) (z : GaussianInt) (h1 : π ∣ z) (h2 : star π ∣ z) : (p : GaussianInt) ∣ z := by
  have hp_eq : (p : GaussianInt) = π * star π := by
    rw [← Zsqrtd.norm_eq_mul_conj, hπ]
    push_cast
    rfl
  obtain ⟨w, rfl⟩ := h1
  have hP' := prime_of_norm_prime (star π) p hp (by rw [Zsqrtd.norm_conj, hπ])
  rcases hP'.dvd_or_dvd h2 with h | h
  · exfalso
    have h3 : (p : GaussianInt) ∣ π * π := by
      rw [hp_eq]
      exact mul_dvd_mul_left π h
    rw [← Int.cast_natCast, Zsqrtd.intCast_dvd] at h3
    simp only [Zsqrtd.re_mul, Zsqrtd.im_mul] at h3
    rw [Zsqrtd.norm_def] at hπ
    have hpZ : Prime (p : ℤ) := Nat.prime_iff_prime_int.mp hp
    have h4 : (p : ℤ) ∣ 2 * (π.re * π.im) := by
      have := h3.2
      rwa [show π.re * π.im + π.im * π.re = 2 * (π.re * π.im) by ring] at this
    rcases hpZ.dvd_or_dvd h4 with h5 | h5
    · have := Int.le_of_dvd (by norm_num) h5
      have := hp.two_le
      omega
    · have hri : (p : ℤ) ∣ π.re ∧ (p : ℤ) ∣ π.im := by
        rcases hpZ.dvd_or_dvd h5 with h6 | h6
        · refine ⟨h6, ?_⟩
          have : (p : ℤ) ∣ π.im * π.im := by
            have e : π.im * π.im = π.re * π.re - (π.re * π.re + -1 * π.im * π.im) := by ring
            rw [e]
            exact dvd_sub (dvd_mul_of_dvd_left h6 _) h3.1
          exact (hpZ.dvd_or_dvd this).elim id id
        · refine ⟨?_, h6⟩
          have : (p : ℤ) ∣ π.re * π.re := by
            have e : π.re * π.re = (π.re * π.re + -1 * π.im * π.im) + π.im * π.im := by ring
            rw [e]
            exact dvd_add h3.1 (dvd_mul_of_dvd_left h6 _)
          exact (hpZ.dvd_or_dvd this).elim id id
      obtain ⟨⟨x, hx⟩, ⟨y, hy⟩⟩ := hri
      rw [hx, hy] at hπ
      have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.ne_zero
      have e1 : (p : ℤ) * (p * (x * x + y * y)) = p * 1 := by linear_combination hπ
      have e2 := mul_left_cancel₀ hp0 e1
      have e3 := Int.eq_one_of_mul_eq_one_right (by positivity) e2
      have := hp.one_lt
      omega
  · rw [hp_eq]
    exact mul_dvd_mul_left π h

lemma R_two (m : ℕ) : R (2 * m) = R m := by
  have hπ : (⟨1, 1⟩ : GaussianInt).norm = ((2 : ℕ) : ℤ) := by
    rw [Zsqrtd.norm_def]
    norm_num
  have hπ0 : (⟨1, 1⟩ : GaussianInt) ≠ 0 := by
    intro h
    have := congrArg Zsqrtd.re h
    simp at this
  rw [← card_dvd ⟨1, 1⟩ hπ0 m]
  unfold R
  congr 1
  ext z
  simp only [Set.mem_ofPred_eq, hπ]
  push_cast
  constructor
  · intro hz
    refine ⟨hz, ?_⟩
    rcases dvd_or_dvd_star ⟨1, 1⟩ 2 Nat.prime_two hπ z ⟨m, by rw [hz]; push_cast; ring⟩ with h | h
    · exact h
    · have e : star (⟨1, 1⟩ : GaussianInt) = ⟨1, 1⟩ * ⟨0, -1⟩ := by
        rw [Zsqrtd.star_mk]
        ext <;> simp
      rw [e] at h
      exact (dvd_mul_right _ _).trans h
  · exact fun h => h.1

lemma R_three (p m : ℕ) (hp : p.Prime) (h3 : p % 4 = 3) :
    R (p * m) = if p ∣ m then R (m / p) else 0 := by
  haveI := Fact.mk hp
  have hP : Prime (p : GaussianInt) := GaussianInt.prime_of_nat_prime_of_mod_four_eq_three p h3
  rw [← card_natCast_dvd p hp.one_lt m]
  unfold R
  congr 1
  ext z
  simp only [Set.mem_ofPred_eq]
  push_cast
  constructor
  · intro hz
    refine ⟨hz, ?_⟩
    have h1 : (p : GaussianInt) ∣ z * star z := by
      rw [← Zsqrtd.norm_eq_mul_conj, hz]
      push_cast
      exact dvd_mul_right _ _
    rcases hP.dvd_or_dvd h1 with h | h
    · exact h
    · have := map_dvd (starRingEnd GaussianInt) h
      rwa [starRingEnd_apply, starRingEnd_apply, star_star, star_natCast] at this
  · exact fun h => h.1

lemma R_one (p m : ℕ) (hp : p.Prime) (h1 : p % 4 = 1) :
    R (p * m) + (if p ∣ m then R (m / p) else 0) = 2 * R m := by
  haveI := Fact.mk hp
  obtain ⟨a, b, hab⟩ := Nat.Prime.sq_add_sq (p := p) (by omega)
  have hπ : (⟨a, b⟩ : GaussianInt).norm = p := by
    rw [Zsqrtd.norm_def, ← hab]
    push_cast
    ring
  set π : GaussianInt := ⟨a, b⟩ with hπdef
  have hπ' : (star π).norm = p := by rw [Zsqrtd.norm_conj, hπ]
  have hπ0 : π ≠ 0 := by
    intro h
    rw [h, Zsqrtd.norm_zero] at hπ
    have := hp.pos
    omega
  have hπ0' : star π ≠ 0 := by
    intro h
    rw [h, Zsqrtd.norm_zero] at hπ'
    have := hp.pos
    omega
  have hodd : p ≠ 2 := by omega
  have hp_eq : (p : GaussianInt) = π * star π := by
    rw [← Zsqrtd.norm_eq_mul_conj, hπ]
    push_cast
    rfl
  set A := {z : GaussianInt | z.norm = π.norm * m ∧ π ∣ z} with hAdef
  set B := {z : GaussianInt | z.norm = (star π).norm * m ∧ star π ∣ z} with hBdef
  have hA : A.ncard = R m := card_dvd π hπ0 m
  have hB : B.ncard = R m := card_dvd (star π) hπ0' m
  have hU : A ∪ B = {z : GaussianInt | z.norm = ((p * m : ℕ) : ℤ)} := by
    ext z
    simp only [hAdef, hBdef, Set.mem_union, Set.mem_ofPred_eq, hπ, hπ']
    push_cast
    constructor
    · rintro (⟨h, -⟩ | ⟨h, -⟩) <;> exact h
    · intro hz
      rcases dvd_or_dvd_star π p hp hπ z ⟨m, hz⟩ with h | h
      · exact Or.inl ⟨hz, h⟩
      · exact Or.inr ⟨hz, h⟩
  have hI : A ∩ B = {z : GaussianInt | z.norm = (p : ℤ) * m ∧ (p : GaussianInt) ∣ z} := by
    ext z
    simp only [hAdef, hBdef, Set.mem_inter_iff, Set.mem_ofPred_eq, hπ, hπ']
    constructor
    · rintro ⟨⟨hz, h1⟩, -, h2⟩
      exact ⟨hz, dvd_of_dvd_dvd_star π p hp hodd hπ z h1 h2⟩
    · rintro ⟨hz, h⟩
      rw [hp_eq] at h
      exact ⟨⟨hz, (dvd_mul_right _ _).trans h⟩, hz, (dvd_mul_left _ _).trans h⟩
  have hfin : (A ∪ B).Finite := by
    rw [hU]
    exact S_finite (p * m)
  have key := Set.ncard_union_add_ncard_inter A B (hfin.subset Set.subset_union_left)
    (hfin.subset Set.subset_union_right)
  have hR : ({z : GaussianInt | z.norm = ((p * m : ℕ) : ℤ)}).ncard = R (p * m) := rfl
  rw [hU, hR, hI, card_natCast_dvd p hp.one_lt m, hA, hB] at key
  omega

lemma R_zero : R 0 = 1 := by
  rw [R_eq_card 0 0 le_rfl]
  decide

lemma R_one' : R 1 = 4 := by
  rw [R_eq_card 1 1 le_rfl]
  decide

theorem R_eq (n : ℕ) (hn : n ≠ 0) : (R n : ℤ) = 4 * D n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  rcases Nat.lt_or_ge n 2 with h | h
  · have : n = 1 := by omega
    subst this
    rw [R_one']
    simp [D, chi_eq]
  · obtain ⟨p, hpdef⟩ : ∃ p, p = n.minFac := ⟨_, rfl⟩
    have hp : p.Prime := hpdef ▸ Nat.minFac_prime (by omega)
    obtain ⟨m, hm⟩ : p ∣ n := hpdef ▸ Nat.minFac_dvd n
    have hm0 : m ≠ 0 := by
      rintro rfl
      simp at hm
      omega
    have hmlt : m < n := by
      rw [hm]
      have := hp.two_le
      have := Nat.pos_of_ne_zero hm0
      nlinarith
    have ihm := ih m hmlt hm0
    rw [hm, D_rec p m hp hm0]
    have hdiv : p ∣ m → (R (m / p) : ℤ) = 4 * D (m / p) := by
      intro hpm
      obtain ⟨k, rfl⟩ := hpm
      have hk : k ≠ 0 := by
        rintro rfl
        simp at hm0
      rw [Nat.mul_div_cancel_left k hp.pos]
      apply ih k _ hk
      have := hp.two_le
      have := Nat.pos_of_ne_zero hk
      nlinarith
    rcases hp.eq_two_or_odd with h2 | hodd
    · subst h2
      have c2 : chi 2 = 0 := by simp [chi_eq]
      rw [R_two, ihm, c2]
      simp
    · have h13 : p % 4 = 1 ∨ p % 4 = 3 := by omega
      rcases h13 with h1 | h3
      · have c1 : chi p = 1 := by simp [chi_eq, h1, hodd]
        have key := R_one p m hp h1
        rw [c1]
        split_ifs at key ⊢ with hpm
        · have := hdiv hpm
          zify at key
          linarith
        · zify at key
          linarith
      · have c3 : chi p = -1 := by simp [chi_eq, h3, hodd]
        rw [R_three p m hp h3, c3]
        split_ifs with hpm
        · rw [hdiv hpm]
          ring
        · simp

-- ### Summation

lemma card_le (K : ℕ) :
    (((box K).filter (fun z => z.1 ^ 2 + z.2 ^ 2 ≤ (K : ℤ))).card : ℤ)
      = 1 + 4 * ∑ n ∈ Finset.range K, D (n + 1) := by
  have h1 : ((box K).filter (fun z => z.1 ^ 2 + z.2 ^ 2 ≤ (K : ℤ))).card
      = ∑ n ∈ Finset.range (K + 1), R n := by
    rw [Finset.card_eq_sum_card_fiberwise (f := fun z : ℤ × ℤ => (z.1 ^ 2 + z.2 ^ 2).toNat)
      (t := Finset.range (K + 1))]
    · apply Finset.sum_congr rfl
      intro n hn
      rw [Finset.mem_range] at hn
      rw [R_eq_card n K (by omega), Finset.filter_filter]
      congr 1
      apply Finset.filter_congr
      intro z _
      have hq : 0 ≤ z.1 ^ 2 + z.2 ^ 2 := by positivity
      generalize z.1 ^ 2 + z.2 ^ 2 = q at hq ⊢
      constructor
      · rintro ⟨h1, h2⟩
        omega
      · intro h
        omega
    · intro z hz
      simp only [Finset.mem_coe, Finset.mem_filter, Finset.coe_filter, Set.mem_ofPred_eq,
        Finset.mem_range] at hz ⊢
      have hq : 0 ≤ z.1 ^ 2 + z.2 ^ 2 := by positivity
      have := hz.2
      generalize z.1 ^ 2 + z.2 ^ 2 = q at hq this ⊢
      omega
  rw [h1, Finset.sum_range_succ', R_zero]
  push_cast
  rw [Finset.mul_sum, add_comm]
  congr 1
  exact Finset.sum_congr rfl (fun n _ => R_eq (n + 1) (by omega))

lemma sum_D (K M : ℕ) (h : K < M) :
    ∑ n ∈ Finset.range K, D (n + 1) = ∑ d ∈ Finset.range M, chi d * ((K / d : ℕ) : ℤ) := by
  induction K with
  | zero => simp
  | succ K ih =>
    rw [Finset.sum_range_succ, ih (by omega)]
    have e : ∀ d ∈ Finset.range M, chi d * (((K + 1) / d : ℕ) : ℤ)
        = chi d * ((K / d : ℕ) : ℤ) + (if d ∣ K + 1 then chi d else 0) := by
      intro d _
      rw [Nat.succ_div]
      split_ifs <;> push_cast <;> ring
    rw [Finset.sum_congr rfl e, Finset.sum_add_distrib, ← Finset.sum_filter]
    congr 1
    unfold D
    apply Finset.sum_congr _ (fun _ _ => rfl)
    ext d
    simp only [Nat.mem_divisors, Finset.mem_filter, Finset.mem_range]
    constructor
    · rintro ⟨hd, -⟩
      exact ⟨(Nat.le_of_dvd (by omega) hd).trans_lt h, hd⟩
    · rintro ⟨-, hd⟩
      exact ⟨hd, by omega⟩

lemma sum_chi (f : ℕ → ℤ) (J : ℕ) :
    ∑ d ∈ Finset.range (4 * J), chi d * f d = ∑ i ∈ Finset.range J, (f (4 * i + 1) - f (4 * i + 3)) := by
  induction J with
  | zero => simp
  | succ J ih =>
    obtain ⟨c0, c1, c2, c3⟩ := chi_four J
    rw [show 4 * (J + 1) = 4 * J + 1 + 1 + 1 + 1 by ring, Finset.sum_range_succ,
      Finset.sum_range_succ, Finset.sum_range_succ, Finset.sum_range_succ, ih,
      Finset.sum_range_succ]
    rw [show 4 * J + 1 + 1 = 4 * J + 2 by ring, show 4 * J + 2 + 1 = 4 * J + 3 by ring, c0, c1, c2, c3]
    ring

-- ### Back to the disc

lemma N_eq (r : ℝ) (hr : 0 ≤ r) :
    GaussCircleProblem.N r = ((box ⌊r ^ 2⌋₊).filter (fun z => z.1 ^ 2 + z.2 ^ 2 ≤ (⌊r ^ 2⌋₊ : ℤ))).card := by
  have key : ∀ m n : ℤ, (!₂[(m : ℝ), (n : ℝ)] ∈ Metric.closedBall (0 : EuclideanSpace ℝ (Fin 2)) r)
      ↔ m ^ 2 + n ^ 2 ≤ (⌊r ^ 2⌋₊ : ℤ) := by
    intro m n
    rw [mem_closedBall_zero_iff, ← sq_le_sq₀ (_root_.norm_nonneg _) hr, EuclideanSpace.real_norm_sq_eq]
    simp only [Fin.sum_univ_two]
    rw [Int.natCast_floor_eq_floor (sq_nonneg r), Int.le_floor]
    push_cast
    simp
  rw [← Set.ncard_coe_finset]
  apply congrArg Set.ncard
  ext ⟨m, n⟩
  simp only [Set.mem_ofPred_eq, Finset.coe_filter, box, Finset.mem_product, Finset.mem_Icc, key]
  constructor
  · intro h
    have h1 := Int.le_self_sq m
    have h2 := Int.le_self_sq (-m)
    have h3 := Int.le_self_sq n
    have h4 := Int.le_self_sq (-n)
    have h5 := sq_nonneg m
    have h6 := sq_nonneg n
    rw [neg_sq] at h2 h4
    exact ⟨⟨⟨by linarith, by linarith⟩, by linarith, by linarith⟩, h⟩
  · exact fun h => h.2

lemma floor_div (r : ℝ) (d : ℕ) : ⌊r ^ 2 / ((d : ℕ) : ℝ)⌋ = ((⌊r ^ 2⌋₊ / d : ℕ) : ℤ) := by
  rw [Int.floor_div_natCast, ← Int.natCast_floor_eq_floor (sq_nonneg r)]
  norm_cast

end GaussExact

theorem gauss_circle_exact_form : type_of% @GaussCircleProblem.exact_form_floor := by
  intro r hr
  set K := ⌊r ^ 2⌋₊ with hK
  have ht : ∑' (i : ℕ), (⌊r ^ 2 / (4 * i + 1)⌋ - ⌊r ^ 2 / (4 * i + 3)⌋)
      = ∑ i ∈ Finset.range (K + 1), (((K / (4 * i + 1) : ℕ) : ℤ) - ((K / (4 * i + 3) : ℕ) : ℤ)) := by
    rw [tsum_eq_sum (s := Finset.range (K + 1))]
    · apply Finset.sum_congr rfl
      intro i _
      have h1 := GaussExact.floor_div r (4 * i + 1)
      have h3 := GaussExact.floor_div r (4 * i + 3)
      push_cast at h1 h3
      rw [h1, h3]
      push_cast
      rfl
    · intro i hi
      rw [Finset.mem_range, not_lt] at hi
      have hlt : r ^ 2 < K + 1 := Nat.lt_floor_add_one _
      have hi' : (K : ℝ) + 1 ≤ i := by exact_mod_cast hi
      have hr2 : 0 ≤ r ^ 2 := sq_nonneg r
      have hi0 : (0 : ℝ) ≤ i := Nat.cast_nonneg i
      rw [Int.floor_eq_zero_iff.mpr, Int.floor_eq_zero_iff.mpr, sub_zero]
      · refine ⟨by positivity, ?_⟩
        rw [div_lt_one (by positivity)]
        linarith
      · refine ⟨by positivity, ?_⟩
        rw [div_lt_one (by positivity)]
        linarith
  rw [ht, GaussExact.N_eq r hr, GaussExact.card_le, GaussExact.sum_D K (4 * (K + 1)) (by omega),
    GaussExact.sum_chi]
