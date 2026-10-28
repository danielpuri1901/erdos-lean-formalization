import FormalConjectures.Wikipedia.LeinsterGroup

/-! Solution for the dihedral target. See `TASK.md` and `NOTES.md`. -/

namespace DihedralLeinster

open DihedralGroup

variable {n : Nat}

/-- The rotation subgroup. -/
abbrev R (n : Nat) : Subgroup (DihedralGroup n) := Subgroup.zpowers (r 1)

lemma mem_R [NeZero n] {g : DihedralGroup n} : g ∈ R n ↔ ∃ i, g = r i := by
  constructor
  · intro h
    obtain ⟨k, rfl⟩ := Subgroup.mem_zpowers_iff.mp h
    exact ⟨k, r_one_zpow k⟩
  · rintro ⟨i, rfl⟩
    have : (r 1 : DihedralGroup n) ^ i.val = r i := by rw [r_one_pow, ZMod.natCast_zmod_val]
    rw [← this]
    exact pow_mem (Subgroup.mem_zpowers _) _

lemma card_R : Nat.card (R n) = n := by
  rw [Nat.card_zpowers, orderOf_r_one]

/-- The rotation subgroup of order `d`, for `d ∣ n`. -/
def K (n d : Nat) : Subgroup (DihedralGroup n) := Subgroup.zpowers (r ((n / d : Nat) : ZMod n))

lemma card_K [NeZero n] {d : Nat} (hd : d ∣ n) : Nat.card (K n d) = d := by
  have hn : n ≠ 0 := NeZero.ne n
  rw [K, Nat.card_zpowers, orderOf_r, ZMod.val_natCast]
  have h1 : Nat.gcd n (n / d % n) = n / d := by
    rw [Nat.gcd_comm, ← Nat.gcd_rec, Nat.gcd_eq_right (Nat.div_dvd_of_dvd hd)]
  rw [h1, Nat.div_div_self hd hn]

lemma K_le_R [NeZero n] (d : Nat) : K n d ≤ R n := by
  rw [K, Subgroup.zpowers_le]
  exact mem_R.mpr ⟨_, rfl⟩

lemma conj_r (g : DihedralGroup n) (i : ZMod n) :
    g * r i * g⁻¹ = r i ∨ g * r i * g⁻¹ = (r i)⁻¹ := by
  rcases g with j | j
  · left
    rw [inv_r, r_mul_r, r_mul_r]
    congr 1
    ring
  · right
    rw [inv_sr, inv_r, sr_mul_r, sr_mul_sr]
    congr 1
    ring

lemma normal_of_le_R [NeZero n] {H : Subgroup (DihedralGroup n)} (h : H ≤ R n) : H.Normal := by
  constructor
  intro x hx g
  obtain ⟨i, rfl⟩ := mem_R.mp (h hx)
  rcases conj_r g i with e | e <;> rw [e]
  · exact hx
  · exact H.inv_mem hx

lemma dvd_of_le_R {H : Subgroup (DihedralGroup n)} (h : H ≤ R n) : Nat.card H ∣ n := by
  have := Subgroup.card_dvd_of_le h
  rwa [card_R] at this

lemma eq_K_of_le_R [NeZero n] {H : Subgroup (DihedralGroup n)} (h : H ≤ R n) :
    H = K n (Nat.card H) := by
  have hd := dvd_of_le_R h
  set d := Nat.card H with hdef
  have hdpos : 0 < d := Nat.card_pos
  apply Subgroup.eq_of_le_of_card_ge
  · intro x hx
    obtain ⟨i, rfl⟩ := mem_R.mp (h hx)
    have h1 : (r i) ^ d = 1 := orderOf_dvd_iff_pow_eq_one.mp (Subgroup.orderOf_dvd_natCard H hx)
    rw [r_pow, ← r_zero] at h1
    have h2 : i * (d : ZMod n) = 0 := r.inj h1
    have h3 : n ∣ i.val * d := by
      rw [← ZMod.natCast_eq_zero_iff]
      push_cast
      rw [ZMod.natCast_zmod_val]
      exact h2
    obtain ⟨e, he⟩ := hd
    have h4 : e ∣ i.val := by
      have h3' : e * d ∣ i.val * d := by
        rw [mul_comm e d, ← he]
        exact h3
      exact Nat.dvd_of_mul_dvd_mul_right hdpos h3'
    obtain ⟨m, hm⟩ := h4
    have hne : n / d = e := by rw [he, Nat.mul_div_cancel_left _ hdpos]
    rw [K, hne]
    have : (r (e : ZMod n)) ^ m = r i := by
      rw [r_pow]
      congr 1
      rw [← ZMod.natCast_zmod_val i, hm]
      push_cast
      ring
    rw [← this]
    exact pow_mem (Subgroup.mem_zpowers _) _
  · rw [card_K hd]

lemma eq_top_of_odd [NeZero n] (hn : Odd n) {H : Subgroup (DihedralGroup n)} (hN : H.Normal)
    (hH : ¬ H ≤ R n) : H = ⊤ := by
  have hex : ∃ i, sr i ∈ H := by
    by_contra hc
    push Not at hc
    apply hH
    intro x hx
    rcases x with j | j
    · exact mem_R.mpr ⟨j, rfl⟩
    · exact absurd hx (hc j)
  obtain ⟨i, hi⟩ := hex
  have h2 : (2 : ZMod n) * (((n + 1) / 2 : Nat) : ZMod n) = 1 := by
    have e : 2 * ((n + 1) / 2) = n + 1 := by
      obtain ⟨m, hm⟩ := hn
      omega
    have h' : ((2 * ((n + 1) / 2) : Nat) : ZMod n) = ((n + 1 : Nat) : ZMod n) := by rw [e]
    push_cast at h'
    rw [h', ZMod.natCast_self, zero_add]
  have hrot : ∀ k : ZMod n, r k ∈ H := by
    intro k
    set c : ZMod n := (((n + 1) / 2 : Nat) : ZMod n) with hc
    have hconj := hN.conj_mem (sr i) hi (r (-(c * k)))
    have hm := H.mul_mem hi hconj
    rw [inv_r, r_mul_sr, sr_mul_r, sr_mul_sr] at hm
    convert hm using 2
    linear_combination (-k) * h2
  have hrefl : ∀ k : ZMod n, sr k ∈ H := by
    intro k
    have hm := H.mul_mem hi (hrot (k - i))
    rw [sr_mul_r] at hm
    convert hm using 2
    ring
  rw [eq_top_iff]
  intro x _
  rcases x with k | k
  · exact hrot k
  · exact hrefl k

open scoped Classical in
lemma normal_iff_odd [NeZero n] (hn : Odd n) (H : Subgroup (DihedralGroup n)) :
    H ∈ insert ⊤ (n.divisors.image (K n)) ↔ H.Normal := by
  constructor
  · intro h
    rcases Finset.mem_insert.mp h with rfl | h
    · infer_instance
    · obtain ⟨d, -, rfl⟩ := Finset.mem_image.mp h
      exact normal_of_le_R (K_le_R d)
  · intro hN
    by_cases hR : H ≤ R n
    · apply Finset.mem_insert_of_mem
      apply Finset.mem_image.mpr
      exact ⟨Nat.card H, Nat.mem_divisors.mpr ⟨dvd_of_le_R hR, NeZero.ne n⟩, (eq_K_of_le_R hR).symm⟩
    · rw [eq_top_of_odd hn hN hR]
      exact Finset.mem_insert_self _ _

open scoped Classical in
lemma sum_insert_top_image [NeZero n] :
    ∑ H ∈ insert ⊤ (n.divisors.image (K n)), Nat.card H = 2 * n + ∑ d ∈ n.divisors, d := by
  rw [Finset.sum_insert, Finset.sum_image]
  · rw [Subgroup.card_top, DihedralGroup.nat_card]
    congr 1
    apply Finset.sum_congr rfl
    intro d hd
    exact card_K (Nat.dvd_of_mem_divisors hd)
  · intro a ha b hb hab
    have := congrArg (fun H : Subgroup (DihedralGroup n) => Nat.card H) hab
    rwa [card_K (Nat.dvd_of_mem_divisors ha), card_K (Nat.dvd_of_mem_divisors hb)] at this
  · intro h
    obtain ⟨d, hd, hK⟩ := Finset.mem_image.mp h
    have := congrArg (fun H : Subgroup (DihedralGroup n) => Nat.card H) hK
    rw [card_K (Nat.dvd_of_mem_divisors hd), Subgroup.card_top, DihedralGroup.nat_card] at this
    have := Nat.divisor_le hd
    have := NeZero.pos n
    omega

lemma sum_odd [NeZero n] (hn : Odd n) {F : Fintype {H : Subgroup (DihedralGroup n) // H.Normal}} :
    ∑ H : {H : Subgroup (DihedralGroup n) // H.Normal}, Nat.card H = 2 * n + ∑ d ∈ n.divisors, d := by
  classical
  rw [← Finset.sum_subtype _ (normal_iff_odd hn) (fun H => Nat.card H)]
  exact sum_insert_top_image

/-- For even `n`, the parity homomorphism whose kernel is a second subgroup of index 2. -/
def phi (n : Nat) (h : 2 ∣ n) : DihedralGroup n →* Multiplicative (ZMod 2) where
  toFun g := match g with
    | r i => Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) i)
    | sr i => Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) i + 1)
  map_one' := by
    show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) 0) = 1
    rw [map_zero, ofAdd_zero]
  map_mul' := by
    have k1 : ∀ a b : ZMod 2, b - a = a + 1 + (b + 1) := by decide
    have k2 : ∀ a b : ZMod 2, b - a + 1 = a + (b + 1) := by decide
    rintro (a | a) (b | b)
    · show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) (a + b)) =
        Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) a) *
          Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) b)
      rw [← ofAdd_add, map_add]
    · show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) (b - a) + 1) =
        Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) a) *
          Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) b + 1)
      rw [← ofAdd_add, map_sub, k2]
    · show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) (a + b) + 1) =
        Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) a + 1) *
          Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) b)
      rw [map_add (ZMod.castHom h (ZMod 2)), ← ofAdd_add]
      congr 1
      ring
    · show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) (b - a)) =
        Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) a + 1) *
          Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) b + 1)
      rw [← ofAdd_add, map_sub, k1]

lemma card_ker_phi [NeZero n] (h : 2 ∣ n) : Nat.card (phi n h).ker = n := by
  have hsurj : Function.Surjective (phi n h) := by
    intro y
    have : y = Multiplicative.ofAdd 0 ∨ y = Multiplicative.ofAdd 1 := by
      revert y
      decide
    rcases this with rfl | rfl
    · refine ⟨r 0, ?_⟩
      show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) 0) = _
      rw [map_zero]
    · refine ⟨sr 0, ?_⟩
      show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) 0 + 1) = _
      rw [map_zero, zero_add]
  have h1 := Subgroup.card_mul_index (phi n h).ker
  rw [Subgroup.index_ker, MonoidHom.range_eq_top.mpr hsurj, Subgroup.card_top,
    DihedralGroup.nat_card] at h1
  have h2 : Nat.card (Multiplicative (ZMod 2)) = 2 := by
    rw [Nat.card_eq_fintype_card]
    rfl
  rw [h2] at h1
  omega

lemma sr_one_mem_ker (h : 2 ∣ n) : sr 1 ∈ (phi n h).ker := by
  rw [MonoidHom.mem_ker]
  show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) 1 + 1) = 1
  rw [map_one]
  decide

lemma sr_zero_not_mem_ker (h : 2 ∣ n) : sr 0 ∉ (phi n h).ker := by
  rw [MonoidHom.mem_ker]
  show Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) 0 + 1) ≠ 1
  rw [map_zero, zero_add]
  decide

lemma not_leinster_even [NeZero n] (hn : Even n)
    {F : Fintype {H : Subgroup (DihedralGroup n) // H.Normal}}
    (h : ∑ H : {H : Subgroup (DihedralGroup n) // H.Normal}, Nat.card H = 2 * (2 * n)) : False := by
  classical
  have h2 : 2 ∣ n := even_iff_two_dvd.mp hn
  have hQnot : (phi n h2).ker ∉ insert ⊤ (n.divisors.image (K n)) := by
    intro hmem
    rcases Finset.mem_insert.mp hmem with e | e
    · exact sr_zero_not_mem_ker h2 (e ▸ Subgroup.mem_top _)
    · obtain ⟨d, -, hd⟩ := Finset.mem_image.mp e
      have hR := K_le_R (n := n) d (hd ▸ sr_one_mem_ker h2)
      obtain ⟨i, hi⟩ := mem_R.mp hR
      cases hi
  have hall : ∀ H ∈ insert (phi n h2).ker (insert ⊤ (n.divisors.image (K n))), H.Normal := by
    intro H hH
    rcases Finset.mem_insert.mp hH with rfl | hH
    · exact MonoidHom.normal_ker _
    · rcases Finset.mem_insert.mp hH with rfl | hH
      · infer_instance
      · obtain ⟨d, -, rfl⟩ := Finset.mem_image.mp hH
        exact normal_of_le_R (K_le_R d)
  have hsum : ∑ H ∈ insert (phi n h2).ker (insert ⊤ (n.divisors.image (K n))), Nat.card H =
      n + (2 * n + ∑ d ∈ n.divisors, d) := by
    rw [Finset.sum_insert hQnot, sum_insert_top_image, card_ker_phi h2]
  have hle : ∑ H ∈ insert (phi n h2).ker (insert ⊤ (n.divisors.image (K n))), Nat.card H ≤
      ∑ H : {H : Subgroup (DihedralGroup n) // H.Normal}, Nat.card H := by
    have e1 : ∑ x ∈ (insert (phi n h2).ker (insert ⊤ (n.divisors.image (K n)))).subtype
        (fun H => H.Normal), Nat.card x.1 =
        ∑ H ∈ insert (phi n h2).ker (insert ⊤ (n.divisors.image (K n))), Nat.card H := by
      refine (Finset.sum_subtype_eq_sum_filter (f := fun H : Subgroup (DihedralGroup n) => Nat.card H)
        (p := fun H => H.Normal)).trans ?_
      rw [Finset.filter_true_of_mem hall]
    rw [← e1]
    exact Finset.sum_le_sum_of_subset
      (f := fun x : {H : Subgroup (DihedralGroup n) // H.Normal} => Nat.card x.1)
      (@Finset.subset_univ _ F _)
  have hσ : 1 + n ≤ ∑ d ∈ n.divisors, d := by
    have hn0 := NeZero.ne n
    have h1n : (1 : Nat) ≠ n := by
      intro e
      rw [← e] at hn
      exact Nat.not_even_one hn
    have hsub : ({1, n} : Finset Nat) ⊆ n.divisors := by
      intro x hx
      rw [Finset.mem_insert, Finset.mem_singleton] at hx
      rcases hx with rfl | rfl
      · exact Nat.one_mem_divisors.mpr hn0
      · exact Nat.mem_divisors_self _ hn0
    have := Finset.sum_le_sum_of_subset (f := fun i : Nat => i) hsub
    rwa [Finset.sum_pair h1n] at this
  omega

end DihedralLeinster

theorem dihedral_leinster_iff : type_of% @LeinsterGroup.dihedral_is_leinster_iff_odd_perfect := by
  intro n _
  unfold LeinsterGroup.IsLeinster
  rw [DihedralGroup.card]
  rcases Nat.even_or_odd n with he | ho
  · constructor
    · intro h
      exact (DihedralLeinster.not_leinster_even he h).elim
    · rintro ⟨-, ho⟩
      exact absurd he (Nat.not_even_iff_odd.mpr ho)
  · rw [DihedralLeinster.sum_odd ho, Nat.perfect_iff_sum_divisors_eq_two_mul (NeZero.pos n)]
    constructor
    · intro h
      exact ⟨by omega, ho⟩
    · rintro ⟨h, -⟩
      omega
