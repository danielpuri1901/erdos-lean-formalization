import FormalConjectures.Wikipedia.LeinsterGroup

/-! Solution for the dihedral target. See `TASK.md` and `NOTES.md`. -/

namespace DihedralLeinster

open DihedralGroup

variable {n : Nat}

/-- The rotation subgroup. -/
abbrev R (n : Nat) : Subgroup (DihedralGroup n) := Subgroup.zpowers (r 1)

lemma mem_R [NeZero n] {g : DihedralGroup n} : g ∈ R n ↔ ∃ i, g = r i := by
  sorry

lemma card_R : Nat.card (R n) = n := by
  sorry

/-- The rotation subgroup of order `d`, for `d ∣ n`. -/
def K (n d : Nat) : Subgroup (DihedralGroup n) := Subgroup.zpowers (r ((n / d : Nat) : ZMod n))

lemma card_K [NeZero n] {d : Nat} (hd : d ∣ n) : Nat.card (K n d) = d := by
  sorry

lemma K_le_R [NeZero n] (d : Nat) : K n d ≤ R n := by
  sorry

lemma conj_r (g : DihedralGroup n) (i : ZMod n) :
    g * r i * g⁻¹ = r i ∨ g * r i * g⁻¹ = (r i)⁻¹ := by
  sorry

lemma normal_of_le_R [NeZero n] {H : Subgroup (DihedralGroup n)} (h : H ≤ R n) : H.Normal := by
  sorry

lemma dvd_of_le_R {H : Subgroup (DihedralGroup n)} (h : H ≤ R n) : Nat.card H ∣ n := by
  sorry

lemma eq_K_of_le_R [NeZero n] {H : Subgroup (DihedralGroup n)} (h : H ≤ R n) :
    H = K n (Nat.card H) := by
  sorry

lemma eq_top_of_odd [NeZero n] (hn : Odd n) {H : Subgroup (DihedralGroup n)} (hN : H.Normal)
    (hH : ¬ H ≤ R n) : H = ⊤ := by
  sorry

open scoped Classical in
lemma normal_iff_odd [NeZero n] (hn : Odd n) (H : Subgroup (DihedralGroup n)) :
    H ∈ insert ⊤ (n.divisors.image (K n)) ↔ H.Normal := by
  sorry

open scoped Classical in
lemma sum_insert_top_image [NeZero n] :
    ∑ H ∈ insert ⊤ (n.divisors.image (K n)), Nat.card H = 2 * n + ∑ d ∈ n.divisors, d := by
  sorry

lemma sum_odd [NeZero n] (hn : Odd n) {F : Fintype {H : Subgroup (DihedralGroup n) // H.Normal}} :
    ∑ H : {H : Subgroup (DihedralGroup n) // H.Normal}, Nat.card H = 2 * n + ∑ d ∈ n.divisors, d := by
  sorry

/-- For even `n`, the parity homomorphism whose kernel is a second subgroup of index 2. -/
def phi (n : Nat) (h : 2 ∣ n) : DihedralGroup n →* Multiplicative (ZMod 2) where
  toFun g := match g with
    | r i => Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) i)
    | sr i => Multiplicative.ofAdd (ZMod.castHom h (ZMod 2) i + 1)
  map_one' := by
    sorry
  map_mul' := by
    sorry

lemma card_ker_phi [NeZero n] (h : 2 ∣ n) : Nat.card (phi n h).ker = n := by
  sorry

lemma sr_one_mem_ker (h : 2 ∣ n) : sr 1 ∈ (phi n h).ker := by
  sorry

lemma sr_zero_not_mem_ker (h : 2 ∣ n) : sr 0 ∉ (phi n h).ker := by
  sorry

lemma not_leinster_even [NeZero n] (hn : Even n)
    {F : Fintype {H : Subgroup (DihedralGroup n) // H.Normal}}
    (h : ∑ H : {H : Subgroup (DihedralGroup n) // H.Normal}, Nat.card H = 2 * (2 * n)) : False := by
  sorry

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
